<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Community</title>
    
<!-- comListView.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/comListView.css" />
	
	
</head>
<body>

    <!--메뉴바-->
    <jsp:include page="../../common/header.jsp" />   
   

    <!--전체 감싸는 div-->
    <div class="innerOuter" style="margin-top:50px;padding-left:50px">

           
        <!--카테고리 시작-->
        <div class="community-header"> 
            <div class="sidebar-item-wrapper">
                <div class="category-tag-header-wrapper" align="center">
                	<c:if test="${!empty loginUser }">
                    	<button class="btn btn-danger" style="width: 100%; margin-bottom: 15px;" onclick="comEnrollForm();">글작성</button>
                    </c:if>
                    <h4 class="item-header">카테고리 📚</h4>
                    
                    <script>
                    	function comEnrollForm(){
                    		location.href="comEnrollForm.bo";
                    	}
                    
                    </script>
                    
                    <hr>
                </div>
                <div class="category-list-wrapper">
                    <ul><a onclick="comOrderByCategory(1)" class="aTags">📖전체 </a></ul>
                    <ul><a onclick="comOrderByCategory(2)"class="aTags">📕일상</a></ul>
                    <ul><a onclick="comOrderByCategory(3)"class="aTags">📕스터디모집</a></ul>
                </div>
            </div>
            	
	            	
	       	<!-- 위의 a태그 클릭시  아래의 script에서 생성된 매핑값 넘기는 목적 -->
	       	<form id="comOrderByCategory" action="" method="post">
	       		<input type="hidden" name="condition" value="">
	       	</form>
	            	
	       	 <script>
		        	function comOrderByCategory(condition){
		        		// 전체 조회할 때
		        		if(condition==1){
		        			$("#comOrderByCategory").attr("action","comList.bo").submit();
		        		// 일상 or 스터디 모집으로 조회
		        		}else{
		        			// 일상 카테고리 조회
		        			if(condition==2){
		        				//input type hidden 요소의 value를 daily로 지정하기
		        				$("#comOrderByCategory").children("input[type=hidden]").attr("value","daily");
		        				$("#comOrderByCategory").attr("action","comOrderByCategory.bo").submit();
		        			}else{
		        				// 스터디 모집으로 조회
			        			// input type hidden 요소의 value를 study로 지정하기 
		        				$("#comOrderByCategory").children("input[type=hidden]").attr("value","study");
		        				$("#comOrderByCategory").attr("action","comOrderByCategory.bo").submit();
		        			}
		        		}
		        	}
	     	</script>
            
        <!--카테고리 끝--> 
        </div>

        <div class="TalkPageHeaderModule">
            <div class="talk-filter-box-wrapper"  style="width: 280px;" >
                <div><h2 class="content-header"><b>전체</b> &nbsp;&nbsp;</h2></div>
                <div class="talk-filter-box-inner" id="selectOption" style="width:88%">
                	<c:choose>
                		<c:when test="${empty flag}">
                			<div onclick="comOrderByCount(1)" class="talk-filter-item on">최신순</div>
                			<div onclick="comOrderByCount(2)" class="talk-filter-item " >조회순</div>
                			<div onclick="comOrderByCount(3)" class="talk-filter-item ">댓글순</div>
              			</c:when>
              			<c:when test="${flag eq 'views'}">
              				<div onclick="comOrderByCount(1)" class="talk-filter-item ">최신순</div>
                			<div onclick="comOrderByCount(2)" class="talk-filter-item on" >조회순</div>
                			<div onclick="comOrderByCount(3)" class="talk-filter-item ">댓글순</div>
              			</c:when>
              			<c:when test="${flag eq 'reply'}">
              				<div onclick="comOrderByCount(1)" class="talk-filter-item ">최신순</div>
                			<div onclick="comOrderByCount(2)" class="talk-filter-item " >조회순</div>
                			<div onclick="comOrderByCount(3)" class="talk-filter-item on">댓글순</div>
              			</c:when>
                	</c:choose>
                </div>
            </div>
        </div>
        
        
       <form id="comOrderByCount" action="" method="post">
       		<input type="hidden" name="condition" value="">
       	</form>
	
  
        <!--메인 시작-->
        <div class="main" id="communityList">
	            <div class="talk-count-box" style="height: 100px; padding-top: 30px;">
	            	<c:choose>
	            		<c:when test="${!empty condition}">
	               	 		<h3><b> ${listCount}개의 게시물</b></h3>
	               	 	</c:when>
	               	 	<c:otherwise>
	               	 		<h3><b> ${listCount}개의 게시물</b></h3>
	               	 	</c:otherwise>
	                </c:choose>
	            </div>

            	  <!--반복적으로 생성될 요소들-->
				 <c:forEach var="c" items="${comList}">
		            <div class="TalkBoxItem">
		                <hr>
		                <!--하나의 컨텐츠 감쌀 영역-->
		                <div class="talk-box-wrapper">
		              		 <input type="hidden" class="com-bno" value="${c.bno}">
		                    <!--content 영역-->
		                    <div class="talk-box-col__content">
	                            <div class="talk-box-row__title">
	                                <h5 class="post-title">${c.title}
	                                	<c:choose>
	                                		<c:when test="${!empty c.reply }">
	                                    		<label class="post-commentcount">[${c.reply}]</label>
	                                    	</c:when>
	                                    	<c:otherwise>
	                                    		<label class="post-commentcount">[0]</label>
	                                    	</c:otherwise>
	                                    </c:choose>
	                                </h5>
	                            </div>
		                        <!--게시글 정보 (카테고리, 작성일, 작성자)-->
		                        <div class="talk-box-row__info">
		                            <label class="talk-box-label">${c.category } | </label>
		                            <label class="talk-box-label">${c.enrollDate} | </label>
		                            <label class="talk-box-label">${c.nickname }</label>
		                        </div>
		                    </div>
		                    <!--thumbnail영역-->
		                    <c:choose>
		                    	<c:when test="${!empty c.imgPath}">
		                    		<div class="talk-box-col__thumbnail">
			                        <img src="${c.imgPath}">
			                    	</div>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<div class="talk-box-col__thumbnail">
			                        <img src="${pageContext.request.contextPath}/resources/images/common/default-img.jpg">
		                    	</c:otherwise>
		                    </c:choose>
		            	</div>
		          	  </div>
            		</c:forEach>
            <!--메인 끝-->
        </div>
        

        <script>
            
            /*JS 수정하기*/
    		 $(document).on("click","#selectOption>div",function(){
                 $(this).toggleClass('on');
                 $(this).siblings().removeClass('on');
             })
             
   		   	function comOrderByCount(condition){
   	    		// 전체 조회할 때
   	    		if(condition==1){
   	    			$("#comOrderByCount").attr("action","comList.bo").submit();
   	    		// 조회수
   	    		}else{
   	    			// 조회수 조회
   	    			if(condition==2){
   	    				//input type hidden 요소의 value를 views로 지정하기
   	    				$("#comOrderByCount").children("input[type=hidden]").attr("value","views");
   	    				$("#comOrderByCount").attr("action","comOrderByCount.bo?flag=views")
   	    				.submit();

   	    			}else{
   	    				// 댓글수
   	        			// input type hidden 요소의 value를 reply로 지정하기 
   	    				$("#comOrderByCount").children("input[type=hidden]").attr("value","reply");
   	    				$("#comOrderByCount").attr("action","comOrderByCount.bo?flag=reply")
   	    				.submit();
   	    			}
   	    		}
           	 }
	    
            
            $(function(){
                $(".talk-box-wrapper").click(function(){
                    //console.log($(this).children("input[type=hidden]").val());
                   	location.href="comDetail.bo?bno="+$(this).children("input[type=hidden]").val();
                })
            })
        </script>

     
        <div style="display: inline-block; margin-left: 25%;  margin-top: 30px;" >
            <div id="search-area" >
               
                <!--키워드 검색-->
                <form id="comSearchForm" action="comSearch.bo" method="Get">
                    <div class="community-header" > 
                        <div class="search-item-wrapper">
                            <div class="category-tag-header-wrapper"  style="margin-top:5px">
                                <select class="selectpicker radius" name="condition">
                                    <option value="titleAndcontent">제목+내용</option>
                                    <option value="title">제목만</option>
                                    <option value="writer">글작성자</option>
                                </select>
                            </div>
                            <input type="text" class="form-control" name="keyword"  placeholder="원하는 정렬 기준으로 검색해보세요!" style="width:300px">
                          	<div onclick="submit();"><i class="fas fa-search" style="margin-top:10px"></i></div>
                        </div>
                    </div>
                </form>
                
                <script>
                	$(function(){
                		if("${condition}" != ""){
                			$("option[value=${condition}]").attr("selected",true);
                		}
                	})
                	
                	//키워드 검색 기능 submit
                	function submit(){
                		$("#comSearchForm").submit();
                	}
                </script>
            </div>
            <div style="display:inline-block; margin-left: 30%;margin-bottom:50px; margin-top: 30px;">
                <div id="pagingArea">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
	                        <!-- 이전으로 -->
	                        <c:choose>
	                        	<c:when test="${ pi.currentPage eq 1 }">
	                        		<li class="page-item disabled">
		                            	<a class="page-link" aria-label="Previous">
		                            		<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span>
		                            	</a>
	                            	</li>
	                            </c:when>
	                            <c:otherwise>
	                            	<c:choose>
	                            		<c:when test="${!empty condition}">
	                            			<c:choose>
	                            				<c:when test="${condition.equals('views') || condition.equals('reply')}">
	                            					<li class="page-item">
					                            		<a class="page-link" href="comOrderByCount.bo?currentPage=${pi.currentPage-1}&condition=${condition}&flag=${condition}" aria-label="Previous">
					                            			<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span>
					                            		</a>
			                            			</li>
	                            				</c:when>
	                            				<c:when test="${!empty keyword }">
			                            			<li class="page-item">
					                            		<a class="page-link" href="comSearch.bo?currentPage=${pi.currentPage-1}&condition=${condition}&keyword=${keyword}&flag=${condition}" aria-label="Previous">
					                            			<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span>
					                            		</a>
			                            			</li>
		                            			</c:when>
		                            			<c:otherwise>
		                            				<a class="page-link" href="comOrderByCategory.bo?currentPage=${pi.currentPage-1}&condition=${condition}&flag=${condition}" aria-label="Previous">
					                            			<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span>
				                            		</a>
		                            			</c:otherwise>
	                            			</c:choose>
	                            		</c:when>
	                            		<c:otherwise>
			                            	<li class="page-item">
				                            	<a class="page-link" href="comList.bo?currentPage=${pi.currentPage-1}" aria-label="Previous">
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
	                        			<c:choose>
	                       					<c:when test="${condition.equals('views') || condition.equals('reply')}">
	                           					<li class="page-item">
				                            		<li class="page-item"><a class="page-link" href="comOrderByCount.bo?currentPage=${ p }&condition=${condition}&flag=${condition}">${ p }</a></li>
		                            			</li>
	                           				</c:when>
	                        				<c:when test="${!empty keyword }">
			                        			<li class="page-item"><a class="page-link" href="comSearch.bo?currentPage=${ p }&condition=${condition}&keyword=${keyword}&flag=${condition}">${ p }</a></li>
	                        				</c:when>
	                        				<c:otherwise>
	                        					<li class="page-item"><a class="page-link" href="comOrderByCategory.bo?currentPage=${ p }&condition=${condition}&flag=${condition}">${ p }</a></li>
	                        				</c:otherwise>
	                        			</c:choose>
	                        		</c:when>
	                        		<c:otherwise>
		                       			<li class="page-item"><a class="page-link" href="comList.bo?currentPage=${ p }">${ p }</a></li>
	                        		</c:otherwise>
	                        	</c:choose>
	                        </c:forEach>
	                        
	                        <!-- 다음으로 -->
	                        <c:choose>
		                        <c:when test="${ pi.currentPage eq pi.maxPage }">
		                       	  <li class="page-item disabled">
			                          <a class="page-link"  aria-label="Next">
			                              <span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span>
			                          </a>
		                          </li>
		                      	</c:when> 
		                      	<c:otherwise>
		                      		<c:choose>
	                      				<c:when test="${!empty condition}">
	                      					<c:choose>
                    							<c:when test="${condition.equals('views') || condition.equals('reply')}">
	                            					<li class="page-item">
					                            		<a class="page-link" href="comOrderByCount.bo?currentPage=${pi.currentPage+1}&condition=${condition}&flag=${condition}" aria-label="Previous">
					                            			<span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span>
					                            		</a>
			                            			</li>
	                            				</c:when>
                      							<c:when test="${!empty keyword }">
					                      		   	<li class="page-item">
							                          <a class="page-link" href="comSearch.bo?currentPage=${pi.currentPage+1}&condition=${condition}&keyword=${keyword}&flag=${condition}" aria-label="Next">
							                              <span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span>
							                          </a>
						                          	</li>
					                         	 </c:when>
					                         	 <c:otherwise>
						                         	 <li class="page-item">
								                          <a class="page-link" href="comOrderByCategory.bo?currentPage=${pi.currentPage+1}&condition=${condition}&flag=${condition}" aria-label="Next">
								                              <span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span>
								                          </a>
							                         </li>
					                         	 </c:otherwise>
				                          	</c:choose>
			                          	</c:when>
			                          	<c:otherwise>
			                          	 <li class="page-item">
					                          <a class="page-link" href="comList.bo?currentPage=${pi.currentPage+1}" aria-label="Next">
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
        </div>
    </div>

     

    <!--푸터바-->
	<jsp:include page="../../common/footer.jsp" />

</body>
</html>
