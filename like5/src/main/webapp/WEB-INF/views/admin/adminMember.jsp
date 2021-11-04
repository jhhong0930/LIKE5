<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
    #alreadyDelBtn{
        background-color:  lightgray;
        color: white;
        border: 1px solid  lightgray;
        border-radius: 3px;
    }
    #delBtn{
        background-color:  rgb(220, 53, 69);
        color: white;
        border: 1px solid  rgb(220, 53, 69);
        border-radius: 3px;
    }
    aside-title{margin-top:30px;}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
	<br>
	<!-- 해당 페이지는 관리자로 로그인 한 경우만 보여지고  -->
    <div class="innerOuter">
	
		<c:if test="${ !empty loginUser && (loginUser.userStatus == 'Y') }">
	        <div class="aside-title">
	            <i class="fi fi-spinner-cog fi-spin"></i>
	            <i class="fi fi-acrobat-reader"></i>
	
	            <h3>통합관리</h3>
	            
	        </div>
	
	        <aside>
	            <ul>
	                <li>
	                    <a class="active" href="member.ad">회원관리</a>
	                </li>
	                <li>
	                    <a href="board.ad">게시글관리</a>
	                </li>
	                <li>
	                    <a href="customer.ad">고객센터</a>
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
	        	<!-- 검색창 **********이거 get방식으로 안하면 나중에 검색 페이지에 정보가 많아서 페이지 바뀔 때 keyword랑 condition이 바껴서 안되남? -->
	            <form id="searchBar" action="searchMem.ad" method="POST">
	                <select class="selectpicker" name="condition">
	                    <option value="all" name="all">전체</option>
	                    <option value="memName" name="memName">회원명</option>
	                    <option value="nickName" name="nickName">닉네임</option>
	                  </select>
	                <input type="text" class="form-control w-25" name="keyword" value="${ keyword }">
	                <button type="submit" class="btn btn-outline-danger">검색</button>
	            </form>
	
	            <br><br>
	
	            <table class="table-bordered table-sm" id="memTable">
	                <thead>
	                    <tr class="table-danger">
	                        <th>No</th>
	                        <th width=100px;>회원명</th>
	                        <th width=80px;>닉네임</th>
	                        <th width=200px;>이메일</th>
	                        <th width=150px;>은행이름</th>
	                        <th width=160px;>계좌번호</th>
	                        <th width=100px;>회원상태</th>
	                        <th width=100px;>회원삭제</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:forEach var="m" items="${list}">
		                    <tr>
		                        <td class="mno" id="mno">
		                        ${m.memNo }
		                        	<input type="hidden" value="${m.memNo }" name="mno">
		                        </td>
		                        <td>${m.memName }</td>
		                        <td>${m.nickName }</td>
		                        <td>${m.email }</td>
		                        <td>${m.bank }</td>
		                        <td>${m.accountNum }</td>
		                        <td>${m.entYN }</td>
		                        <c:choose>
		                        	<c:when test="${m.entYN == 'N'}">
			                        	<td><button id="delBtn" class="delbtn" onclick="deleteMem('${m.memNo }')">삭제</button></td>
			                   		</c:when>
			                   		<c:when test="${m.entYN == 'Y'}">
			                        	<td><button id="alreadyDelBtn"  class=" delbtn" disabled>삭제</button></td>
			                   		</c:when>
		                   		</c:choose>
		                    </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
	
	            <br><br>
	
	            <!-- <nav aria-label="Page navigation example"> -->
	                <ul class="pagination justify-content-center">
	                	
	                	<c:choose>
	                		<c:when test="${ pi.currentPage eq 1 }">
		                    	<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
		                    </c:when>
		                    <c:otherwise>
		                    	<c:choose>
		                    		<c:when test="${!empty condition }">
		                    			<li class="page-item"><a class="page-link" href="searchMem.ad?currentPage=${pi.currentPage-1 }&condition=${condition}&keyword=${keyword}">&laquo;</a></li>
		                   			</c:when>
		                    		<c:otherwise>
		                    			<li class="page-item"><a class="page-link" href="member.ad?currentPage=${pi.currentPage -1 }">&laquo;</a></li>
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
											<li class="page-item active"><a class="page-link" href="searchMem.ad?currentPage=${ p }&condition=${condition}&keyword=${keyword}">${p}</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="searchMem.ad?currentPage=${ p }&condition=${condition}&keyword=${keyword}">${p}</a></li>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${pi.currentPage eq p}">
											<li class="page-item active"><a class="page-link" href="member.ad?currentPage=${ p }">${p}</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="member.ad?currentPage=${ p }">${p}</a></li>
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
			                    		<li class="page-item"><a class="page-link" href="searchMem.ad?currentPage=${ pi.currentPage+1 }&condition=${condition}&keyword=${keyword}">&raquo;</a></li>
			                    	</c:when>
			                    	<c:otherwise>
			                    		<li class="page-item"><a class="page-link" href="member.ad?currentPage=${ pi.currentPage+1 }">&raquo;</a></li>
			                    	</c:otherwise>
			                    </c:choose>
		                    </c:otherwise>
	                    </c:choose>
	                </ul>
	            
		
	            <br><br>
	        </article>
	        
	        
	        <script>
	        	$(function(){
	        		if("$(condition)" != ""){
	        			$("option[value=${condition}]").attr("selected", true);
	        		}
	        	})
	        </script>
	        <script>
	        	var memNo="";
	        	$(document).ready(function(){
	        		
	        	})
	        	
	        	function deleteMem(memNo){
	        		
	        		if(!confirm("해당 회원을 정말로 탈퇴처리 하시겠습니까?")){
	        			alert("취소하셨습니다.")
	        		}else{
	        			location.href="deleteMem.ad?memNo="+memNo;
	        			// 이렇게 넘겨준 다음에 원래 페이지로 돌아가게 해줘야함
	        		}
	        		//location.href="deleteMem.ad?mno="+memNo;
	        	}
	        </script>
	        
	        
		</c:if>
    </div>
</body>
</html>