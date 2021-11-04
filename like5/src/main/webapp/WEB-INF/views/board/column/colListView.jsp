<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Column</title>

<!-- colListView.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/colListView.css" />  

</head>
<body>
    
    <!--메뉴바-->
    <jsp:include page="../../common/header.jsp" />   
 
    <!--전체 감싸는 div-->
    <div class="innerOuter" style="margin-top:50px; padding-left:50px">

        <div class="TalkPageHeaderModule">
            <div class="column-filter-box-wrapper"  style="width: 280px;">
                <div><h2 class="column-header"><b>칼럼</b> &nbsp;&nbsp;</h2></div>
                <div>
                    <div id="column-select-btn">
                        <div class="column-filter-box-inner" id="selectOption" >
                        	<c:choose>
	                        	<c:when test="${empty flag }">
		                        	<div onclick="colOrderByCount(1)" class="column-filter-item on">최신순</div>
		                            <div onclick="colOrderByCount(2)" class="column-filter-item " >조회순</div>
		                            <div onclick="colOrderByCount(3)" class="column-filter-item ">좋아요순</div>
	                        	</c:when>
	                        	<c:when test="${flag eq 'views' }">
		                        	<div onclick="colOrderByCount(1)" class="column-filter-item ">최신순</div>
		                            <div onclick="colOrderByCount(2)" class="column-filter-item on" >조회순</div>
		                            <div onclick="colOrderByCount(3)" class="column-filter-item ">좋아요순</div>
	                        	</c:when>
	                        	<c:when test="${flag eq 'likes' }">
		                            <div onclick="colOrderByCount(1)" class="column-filter-item ">최신순</div>
		                            <div onclick="colOrderByCount(2)" class="column-filter-item " >조회순</div>
		                            <div onclick="colOrderByCount(3)" class="column-filter-item on">좋아요순</div>
	                            </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

	 	<form id="colOrderByCount" action="" method="post">
       		<input type="hidden" name="condition" value="">
       	</form>

        <!--메인 시작-->
        <div class="main" id="columnList" style="width: 1000px; margin-top: 50px; margin-left: 0px;">
            <div style="margin-left:88%;">
            	<c:if test="${!empty loginUser}">
                	<button id="insertColumn" class="btn btn-danger" onclick="insertColumn();">글작성</button>
                </c:if>
            </div>

            <script>
                /*글작성 버튼 클릭시 해당 페이지로 이동*/
                function insertColumn(){
                   location.href="colEnrollForm.bo";
                }
                
                /*조회 기준(최신순,조회순,좋아요순) 클릭시 배경색 변경되는 JS*/
                $(document).on("click","#selectOption>div",function(){
                    $(this).toggleClass('on');
                    $(this).siblings().removeClass('on');
                })     
                
                
               	function colOrderByCount(condition){
	   	    		// 전체 조회할 때
	   	    		if(condition==1){
	   	    			$("#colOrderByCount").attr("action","colList.bo").submit();
	   	    		// 조회수
	   	    		}else{
	   	    			// 조회수 조회
	   	    			if(condition==2){
	   	    				//input type hidden 요소의 value를 daily로 지정하기
	   	    				$("#colOrderByCount").children("input[type=hidden]").attr("value","views");
	   	    				$("#colOrderByCount").attr("action","colOrderByCount.bo?flag=views")
	   	    				.submit();
	
	   	    			}else{
	   	    				// 댓글수
	   	        			// input type hidden 요소의 value를 study로 지정하기 
	   	    				$("#colOrderByCount").children("input[type=hidden]").attr("value","likes");
	   	    				$("#colOrderByCount").attr("action","colOrderByCount.bo?flag=likes")
	   	    				.submit();
	   	    			}
	   	    		}
	           	 }
            </script>

		
	            <div class="list-area" style="margin-top: 10px;">   
	            	<c:forEach var="col" items="${colList}">         
	                	<!--반복문 돌리기-->
		                <div class="thumbnail" style="margin-left:0px" >
		                   	<input type="hidden" class="col-bno" value="${col.bno}">
		                   	<c:choose>
								<c:when test="${!empty loginUser}">
				                   	<input type="hidden" class="mno" value="${loginUser.memNo}">
								</c:when>
								<c:otherwise>
									<input type="hidden" class="mno" value="0">
								</c:otherwise>		                   	
		                   	</c:choose>
		                    <c:choose>
			                    <c:when test="${!empty col.imgPath}">
			                   		 <img src="${col.imgPath}" style="width:300px; height: 250px;">
		                   		 </c:when>
		                   		 <c:otherwise>
		                   		 	 <img src="${pageContext.request.contextPath}/resources/images/common/default-img.jpg" style="width:300px; height: 250px;">
		                   		 </c:otherwise>
		                    </c:choose>
		                    <div class="column-conetent">
		                        <h6><b>${col.title}</b></h6><br>
		                        <span>${col.enrollDate}</span><br>
		                        <div class="test1">
		                            <div>by <b>${col.nickname}</b></div>
		                            <div style="margin-left: 200px; padding: 0;">👍<b>${col.like}</b></div>
		                       </div>
		                    </div>
		                </div>
                     </c:forEach>
	           	  </div>
      
			
		
			<!-- 글번호와 mno를 넘겨주어 해당 칼럼에 좋아요와 스크랩 여부를 확인 -->
            <script>
	            $(function(){
	            	 $(".thumbnail").click(function(){
	                    location.href="colDetail.bo?bno="+$(this).children(".col-bno").val()+"&mno="+$(this).children(".mno").val();
	                })
	            });
            </script>

            <div style="display:inline-block; margin-left: 400px; margin-top: 50px; margin-bottom:50px">
                <!--페이징 시작-->
                <div id="pagingArea">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                        	<!-- 이전으로 -->
                        	<c:choose>
                        		<c:when test="${pi.currentPage eq 1 }">
		                            <li class="page-item disabled">
		                            <a class="page-link" aria-label="Previous">
		                                <span aria-hidden="true">&laquo;</span>
		                                <span class="sr-only">Previous</span>
		                            </a>
		                            </li>
	                            </c:when>
	                            <c:otherwise>
	                            	<c:choose>
	                            		<c:when test="${!empty condition}">
		                            		<li class="page-item">
				                            	<a class="page-link" href="colOrderByCount.bo?currentPage=${pi.currentPage-1}&condition=${condition}&flag=${condition}" aria-label="Previous">
				                            		<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span>
				                            	</a>
			                            	</li>
	                            		</c:when>
	                            		<c:otherwise>
		                           			<li class="page-item">
				                            	<a class="page-link" href="colList.bo?currentPage=${pi.currentPage-1}&flag=${condition}" aria-label="Previous">
				                            		<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span>
				                            	</a>
			                            	</li>
		                            	</c:otherwise>
	                            	</c:choose>
	                            </c:otherwise>
                            </c:choose>
                            
                            <!-- 반복문 돌리기 -->
                            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                           		 <c:choose>
	                           		 <c:when test="${!empty condition}"> 
			                           	<li class="page-item"><a class="page-link" href="colOrderByCount.bo?currentPage=${ p }&condition=${condition}&flag=${condition}">${ p }</a></li>
	                           		 </c:when>
	                           		 <c:otherwise>
	                           		 	 <li class="page-item"><a class="page-link" href="colList.bo?currentPage=${p}&flag=${condition}">${p}</a></li>
	                           		 </c:otherwise>
                           		 </c:choose>
                            </c:forEach>
                            
                            <!-- 다음으로 -->
                            <c:choose>
                            	<c:when test="${pi.currentPage eq pi.maxPage}">
		                            <li class="page-item disabled">
		                            <a class="page-link" aria-label="Next">
		                                <span aria-hidden="true">&raquo;</span>
		                                <span class="sr-only">Next</span>
		                            </a>
		                            </li>
	                            </c:when>
	                            <c:otherwise>
	                            <c:choose>
	                            	<c:when test="${!empty condition}">
			                             <li class="page-item">
					                          <a class="page-link" href="colOrderByCount.bo?currentPage=${pi.currentPage+1}&condition=${condition}&flag=${condition}" aria-label="Previous">
					                              <span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span>
					                          </a>
				                          </li>
			                          </c:when>
			                          <c:otherwise>
		                          		 <li class="page-item">
					                          <a class="page-link" href="colList.bo?currentPage=${pi.currentPage+1}&flag=${condition}" aria-label="Next">
					                              <span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span>
					                          </a>
				                          </li>
			                          </c:otherwise>
		                          </c:choose>
	                            </c:otherwise>
                            </c:choose>
                        </ul>
                    </nav>
                </div>
            </div>
            <!--페이징 끝-->
        </div>
        <!--메인 끝-->
    <!--전체 감싸는 div-->
    </div>


 	<!--푸터바-->
	<jsp:include page="../../common/footer.jsp" />
     


</body>
</html>