<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		#star{
            color: yellow;
            size: 6px;
        }
        .starIcon{
            position:absolute;
            margin-left: 50px;
        }
        #tagTable {
            width: 900px;
            text-align: center;
            vertical-align: middle;
        }
        .outer{width: 1200px;}
        .outer {
            margin: auto;
        }
        .inner{
            width: 1100px;
            box-sizing: border-box;

        }
        .inner {
            margin: auto;
        }
        .inner>table{
            margin: auto;
        }
        .pagination{
            text-align: center;
            margin: auto;
        }
        .pagination li a.page-link{
            color: rgb(220, 53, 69);
        }
        .pagination .active a {
            background-color: rgb(220, 53, 69) !important;
            border: 1px solid white !important;
        }
        .page-link:hover{
            color: white !important;
        }
        #updateTag{
            background-color:  rgb(220, 53, 69);
            color: white;
            border: 1px solid  rgb(220, 53, 69);
            border-radius: 3px;
        }
        #addTag{
            background-color:  rgb(220, 53, 69);
            color: white;
            border: 1px solid  rgb(220, 53, 69);
            border-radius: 3px;
            margin-left: 918px;
        }
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	<br>
	<c:if test="${ !empty loginUser && (loginUser.userStatus == 'Y') }">
	    <div class="innerOuter">
		    <div class="outer">
		        <!--폰트어썸 사용함-->
		        <div class="starIcon">
		            <i id="star" class="fas fa-star fa-stack-2x">TAGS</i>
		            <i id="starBold" class="far  fa-star fa-stack-2x">TAGS</i>
		        </div>
		        <br>
		        <hr>
		        <br>
		        <div class="inner">
		            <!--모든 태그가 뿌려지고 -->
		            <h5><b>관리자 전용 TAG관리 페이지</b> </h5>
		            <button id="addTag"  data-toggle="modal" data-target="#insertModal">추가하기 </button>
		            <br><br>
		            <table class="table tagTable" width="850px">
		                <thead style="text-align: center;">
		                    <tr>
		                        <th>TAG번호</th>
		                        <th>TAG명</th>
		                        <th>수정하기</th>
		                        <!-- 사실 수정하기 버튼 눌렀을 때 해당 TAG명을 수정할 수 있는 방법은 모르겠음...modal?-->
		                    </tr>
		                </thead>
		                <tbody style="text-align: center;">
		                	<c:forEach var="t" items="${list }"> 
			                    <tr>
			                        <td>${t.tagNo }</td>
			                        <td>${t.tagName }</td>
			                        <td>
			                        		<button id="updateTag"  data-toggle="modal" data-target="#updateModal">수정하기</button>
			                        		<input type="hidden" id="tagNo" name="tagNo" value="${t.tagNo}">
			                        </td>
			                    </tr>
		                    </c:forEach>
		                </tbody>
		            </table>
		            <br>
		        </div>
		            <!-- 페이징 바 -->
		        <div class="paging-area">
		            <ul class="pagination justify-content-center">
			            <c:choose>
			          		<c:when test="${ pi.currentPage eq 1 }">
			               		<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
			               	</c:when>
			                <c:otherwise>
		               			<li class="page-item"><a class="page-link" href="tagAdmin.ad?currentPage=${pi.currentPage -1 }">&laquo;</a></li>
			                </c:otherwise>
		         		</c:choose>
		          
			           <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage }">
		           			<li class="page-item"><a class="page-link" href="tagAdmin.ad?currentPage=${ p }">${ p }</a></li>
			           </c:forEach>
			           
			           <c:choose>
			              	<c:when test="${ pi.currentPage eq pi.maxPage }">
			               		<li class="page-item disabled"><a class="page-link">&raquo;</a></li>
			                </c:when>
			               <c:otherwise>
		                		<li class="page-item"><a class="page-link" href="tagAdmin.ad?currentPage=${ pi.currentPage+1 }">&raquo;</a></li>
			               </c:otherwise>
		              </c:choose>
		          </ul>
		        </div>
		        
		    </div>
		
		    <!-- The Modal -->
		    
		    <div class="modal" id="insertModal">
		        <div class="modal-dialog">
		            <div class="modal-content">
		        
		                <!-- Header -->
		                <div class="modal-header">
		                <h4 class="modal-title">Tag추가하기</h4>
		                <button type="button" class="close" data-dismiss="modal">&times;</button>
		                </div>
		                    <!-- body -->
		                    <div class="modal-body">
		                        Tag : <input type="text" id="tagName" name="tagName">
		                    </div>
		            
		                    <!-- footer -->
		                    <div class="modal-footer">
		                        <button type="button" onclick="insertTag();" class="btn btn-danger" data-dismiss="modal">추가하기</button>
		                    </div>
		            </div>
		        </div>
		    </div>
		    <script>
		    	function insertTag(){
		    		var tagName = $('#tagName').val();
		    		location.href="addTag.ad?tagName="+ tagName;
		    	}
		    </script>
		  
		    <div class="modal" id="updateModal">
		        <div class="modal-dialog">
		            <div class="modal-content">
		        
		                <!-- Modal Header -->
		                <div class="modal-header">
		                <h4 class="modal-title">Tag수정하기</h4>
		                <button type="button" class="close" data-dismiss="modal">&times;</button>
		                </div>
		                
	                    <!-- Modal body -->
	                    <div class="modal-body">
	                        Tag : <input type="text" id="newTagName" name="newTagName" placeholder="수정하시려는 태그명을 입력하세요.">
	                    </div>
	            
	                    <!-- Modal footer -->
	                    <div class="modal-footer">
	                        <button type="button"  onclick="updateTag();" class="btn btn-danger" data-dismiss="modal">수정완료</button>
	                    </div>
		               
		            </div>
		        </div>
		    </div>
		    
		    <script>
		    	function updateTag(){
		    		// 넘겨줄때 해당 tag의 태그 번호도 같이 넘겨줘야함
		    		var tagNo = $("#tagNo").val();
		    		var tagName= $('#newTagName').val();
		    		
		    		location.href="updateTag.ad?tagName="+tagName+'&tagNo='+tagNo;
		    	}
		    </script>
		</div>
	</c:if>


</body>
</html>