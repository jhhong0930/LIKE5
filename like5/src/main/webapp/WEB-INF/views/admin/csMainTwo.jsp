<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		.title{
            float: left;
            margin-right: 74px;
        }
        aside{
            float: left;
            margin-right: 50px;
        }
        .aside-title{
            padding: 30px 10px;
        }
        aside ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            width: 130px;
            /* background-color: #f1f1f1; */
        }
        aside li{
            border: 1px lightgray solid;
        }

        aside li a {
            display: block;
            color: #000;
            padding: 8px 16px;
            text-decoration: none;
            text-align: center;
        }

        aside li a.active {
            background-color: rgb(220, 53, 69);
            color: white;
            text-decoration: none;
        }

        aside li a:hover:not(.active) {
            background-color: rgb(220, 53, 69);
            color: white;
            text-decoration: none;
        }

        .input-search{
            border: 1px solid #ced4da;
            border-radius: .25rem;
            height: 38px;
        }

        table{
            text-align: center;
        }
        form{
            display: flex;
        }
        tr{
            height: 40px;
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
        #alreadyDone{
            color:  rgb(220, 53, 69) !important;
            font-weight: bolder;
        }
        #inProgress{
            color: lightslategray;
        }
        
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
	<div class="innerOuter">
	<c:if test="${ !empty loginUser && (loginUser.userStatus == 'Y') }">
		<div class="aside-title">
	
	        <h3 class="title">통합관리</h3>
	        
	        <div class="tab-area">
	            <button onclick="location.href='customer.ad'" class="btn btn-outline-danger ">신고내역</button>
	            <button onclick="location.href='csTwo.ad'" class="btn btn-outline-danger active">1:1문의</button>
	        </div>
	    </div>
	
	    <aside>
	        <ul>
	            <li>
	                <a  href="member.ad">회원관리</a>
	            </li>
	            <li>
	                <a href="board.ad">게시글관리</a>
	            </li>
	            <li>
	                <a class="active" href="customer.ad">고객센터</a>
	            </li>
	            <li>
	                <a href="donation.ad">후원관리</a>
	            </li>
	            <li>
	                <a href="list.bk">공간대여관리</a>
	            </li>
	            <li>
            		<a href="space.bo">공간예약관리</a> <%--정빈 사이드 바 추가 --%>
            	</li>
	        </ul>
	    </aside>
	
	    <article>
	        <!-- 검색기능 그냥 가져다가 써도 되려나...? 요건 해보면 알겠지 뭐 ㅎㅎ -->
	        <form action="searchCs.ad" method="POST"">
	            <select class="selectpicker" name="condition">
	                    <option value="all" name="all">전체</option>
	                    <option value="memName" name="memName">회원명</option>
	                    <option value="nickName" name="nickName">닉네임</option>
	                  </select>
	                <input type="text" class="form-control w-25" name="keyword" value="${ keyword }">
	                <button type="submit" class="btn btn-outline-danger">검색</button>
	        </form>
	
	        <br><br>
	
	        <table id="csList" class="table-bordered table-sm">
	            <thead>
	                <tr class="table-danger">
	                    <th width="50">No</th>
	                    <th width="80">회원명</th>
	                    <th>닉네임</th>
	                    <th width="500">1:1 문의 제목</th>
	                    <th width="100">문의 날짜</th>
	                    <th width="180">답변 상태</th>
	                </tr>
	            </thead>
	            <!--반복문으로 뿌릴 때 제목을 클릭하면 해당 게시글로 넘어갈 수 있도록 해줘야해! 그럼 게시글 제목에 input-hidden으로 게시글 번호를 넣어줘야겠지 아마두-->
	            <tbody>
	                <c:forEach var="cs" items="${list }">
	                	<tr>
	                		<td class="csNo" id="csNo">
	                			${cs.csNo }
	                		</td>
	                		<td>${cs.memName }</td>
		                    <td>${cs.nickname }</td>
		                    <td ><a href="csDetail.ad?csNo=${cs.csNo }" >${cs.csTitle }</a></td>
		                    <td>${cs.regDate }</td>
		                	<c:choose>
		                		<c:when test="${cs.status == 'Y' }">
		                			<td id="alreadyDone" >답변완료</td>
		                		</c:when>
		                		<c:when test="${cs.status == 'N' }">
		                			<td id="inProgress" >처리중</td>
		                		</c:when>
		                	</c:choose>
	                	</tr>
	                </c:forEach>
	            </tbody>
	        </table>
			<script>
            	$(function(){
            		$("#csList>tbody>tr").click(function(){
            			location.href="csDetail.ad?csNo=" + $(this).children(".csNo").text();
            		})
            	})
            </script>
			
			
	    	<Br>
	    	<!-- 페이징 바 -->
	    	
	        <ul class="pagination justify-content-center">
               	<c:choose>
               		<c:when test="${ pi.currentPage eq 1 }">
                    	<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
                    </c:when>
                    <c:otherwise>
                    	<c:choose>
                    		<c:when test="${!empty condition }">
                    			<li class="page-item"><a class="page-link" href="searchCs.ad?currentPage=${pi.currentPage-1 }&condition=${condition}&keyword=${keyword}">&laquo;</a></li>
                   			</c:when>
                    		<c:otherwise>
                    			<li class="page-item"><a class="page-link" href="csTwo.ad?currentPage=${pi.currentPage -1 }">&laquo;</a></li>
                    		</c:otherwise>
                    	</c:choose>
                    </c:otherwise>
              		</c:choose>
                <!-- 반복문으로  -->

				<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
					<c:choose>
						<c:when test="${!empty condition}">
							<c:choose>
								<c:when test="${pi.currentPage eq p}">
									<li class="page-item active"><a class="page-link" href="searchCs.ad?currentPage=${ p }&condition=${condition}&keyword=${keyword}">${p}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="searchCs.ad?currentPage=${ p }&condition=${condition}&keyword=${keyword}">${p}</a></li>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${pi.currentPage eq p}">
									<li class="page-item active"><a class="page-link" href="csTwo.ad?currentPage=${ p }">${p}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="csTwo.ad?currentPage=${ p }">${p}</a></li>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:forEach>
                    	
                <c:choose>
                   	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    	<li class="page-item disabled"><a class="page-link">&raquo;</a></li>
                    </c:when>
                    <c:otherwise>
                    	<c:choose>
                    		<c:when test="${ !empty condition }">
	                    		<li class="page-item"><a class="page-link" href="searchCs.ad?currentPage=${ pi.currentPage+1 }&condition=${condition}&keyword=${keyword}">&raquo;</a></li>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<li class="page-item"><a class="page-link" href="csTwo.ad?currentPage=${ pi.currentPage+1 }">&raquo;</a></li>
	                    	</c:otherwise>
	                    </c:choose>
                    </c:otherwise>
                   </c:choose>
               </ul>
	    </article>
	
	    <br><br>
	    
	    
	
	    <br><br>
	</c:if>
	</div>
	
	<script>
    	$(function(){
    		if("$(condition)" != ""){
    			$("option[value=${condition}]").attr("selected", true);
    		}
    	})
    </script>
    
			
</body>
</html>