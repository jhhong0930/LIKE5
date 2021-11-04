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
        
        #detailDo{
            background-color:  rgb(220, 53, 69);
            color: white;
            border: 1px solid  rgb(220, 53, 69);
            border-radius: 3px;
            width: 85px;
        }
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<c:if test="${ !empty loginUser && (loginUser.userStatus == 'Y') }">
		<div class="innerOuter">
			<div class="aside-title">
		        <i class="fi fi-spinner-cog fi-spin"></i>
		        <i class="fi fi-acrobat-reader"></i>
		        
		        <h3>통합관리</h3>
		       
		    </div>
		
		    <aside>
		     	<ul>
		              <li>
		                  <a href="member.ad">회원관리</a>
		              </li>
		              <li>
		                  <a href="board.ad">게시글관리</a>
		              </li>
		              <li>
		                  <a href="customer.ad">고객센터</a>
		              </li>
		              <li>
		                  <a class="active" href="donation.ad">후원관리</a>
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
		        <form id="searchBar" action="searchDona.ad" method="POST">
		            <select class="selectpicker" name="condition">
	                    <option value="all" name="all">전체</option>
	                    <option value="memName" name="memName">회원명</option>
	                    <option value="nickName" name="nickName">닉네임</option>
	                  </select>
		            <input type="text" class="form-control w-25" name="keyword" value="${ keyword }">
		            <button type="submit" class="btn btn-outline-danger">검색</button>
		        </form>
				<script>
		        	$(function(){
		        		if("$(condition)" != ""){
		        			$("option[value=${condition}]").attr("selected", true);
		        		}
		        	})
		        </script>
		        <br><br>
		
		        <table class="table-bordered table-sm" id="donationTable">
		            <thead>
		                <tr class="table-danger">
		                    <th >회원번호</th>
		                    <th width=80px;>회원명</th>
		                    <th width=100px;>닉네임</th>
		                    <th width=200px;>이메일</th>
		                    <th width=160px;>총 후원받은 금액</th>
		                    <th width=90px;>후원상세</th>
		                    <th width=150px;>회원계좌명</th>
		                    <!-- 이거 정산받은 계좌가 아니라 회원계좌(정산받을계좌)로 명칭 바꿔야 할 듯..? -->
		                </tr>
		            </thead>
		            <tbody><!-- 여기서 onclick시에는 해당 회원(smem_no)번호를 함께 넘겨줘야해! 매개변수로 넘겨주던지 ?smemNo = 으로 넘겨주던지!!! -->
		                <c:forEach var="sp" items="${list}">
		                	<tr>
			                    <td class="smemNo" id="smemNo">${sp.smemNo }
			                    	<input type="hidden" value="${sp.smemNo }" name="smemNo">
			                    </td>
			                    <td>${sp.memName }</td>
			                    <td>${sp.nickName }</td>
			                    <td>${sp.email }</td>
			                    <td>${sp.sponFee }</td>
			                    <td><button id="detailDo" type="button" onclick="detailDonation(${sp.smemNo});">상세조회</button></td>
			                    <td>${sp.accountNum }</td>
		                	</tr>
		                </c:forEach>
		            </tbody>
		        </table>
				<script>
			        var smemNo= "";
			        $(document).ready(function(){
		        		
		        	})
			       	function detailDonation(smemNo) {
			       			//location.href="donaDetailOne.ad?smemNo=" + smemNo;
			       			//console.log(smemNo);
			        	location.href="donaDetailOne.ad?smemNo=" + smemNo;
			        	
			       	}
			    </script>
		        <br><br>
		            
				<ul class="pagination justify-content-center">
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
	                    	<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
	                    </c:when>
	                    <c:otherwise>
	                    	<c:choose>
	                    		<c:when test="${!empty condition }">
	                    			<li class="page-item"><a class="page-link" href="searchDona.ad?currentPage=${pi.currentPage-1 }&condition=${condition}&keyword=${keyword}">&laquo;</a></li>
	                   			</c:when>
	                    		<c:otherwise>
	                    			<li class="page-item"><a class="page-link" href="donation.ad?currentPage=${pi.currentPage -1 }">&laquo;</a></li>
	                    		</c:otherwise>
	                    	</c:choose>
	                    </c:otherwise>
               		</c:choose>
	                <!-- 반복문으로  -->
	                    	
	                <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage }">
	                	<c:choose>
	                		<c:when test="${!empty condition }">
	                			<li class="page-item"><a class="page-link" href="searchDona.ad?currentPage=${ p }&condition=${condition}&keyword=${keyword}">${ p }</a></li>
	                		</c:when>
	                		<c:otherwise>
	                			<li class="page-item"><a class="page-link" href="donation.ad?currentPage=${ p }">${ p }</a></li>
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
		                    		<li class="page-item"><a class="page-link" href="searchDona.ad?currentPage=${ pi.currentPage+1 }&condition=${condition}&keyword=${keyword}">&raquo;</a></li>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<li class="page-item"><a class="page-link" href="donation.ad?currentPage=${ pi.currentPage+1 }">&raquo;</a></li>
		                    	</c:otherwise>
		                    </c:choose>
	                    </c:otherwise>
                    </c:choose>
                </ul>
		        <br><br>
		
		
		    </article>
		</div>
	    
	
	</c:if>
</body>
</html>