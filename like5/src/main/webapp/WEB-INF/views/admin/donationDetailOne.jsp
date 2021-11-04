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
            margin-right: 58px;
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
	
		<div class="aside-title">
	
	        <h3 class="title">통합관리</h3>
	        
	        <div class="tab-area">
	            <button class="btn btn-outline-danger active" onclick="location.href='donaDetailOne.ad?smemNo=' + ${spMem.smemNo};">후원내역</button>
	            <button class="btn btn-outline-danger" onclick="location.href='donaDetailTwo.ad?smemNo=' + ${spMem.smemNo};">정산내역</button>
	        </div>
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
	        
	        <div class="donationMem">
	            <table id="memInfo">
	                <tr>
	                    <td width="500px"><h5><b style="text-align: left; font-size: 25px;">${spMem.memName}</b>님의 후원 받은 내역</h5></td>
	                    <td width="400px"><h5 style="text-align: center;">총 후원금 : <b style="color: rgb(220, 53, 69)  ;">${spMem.sponFee }</b>원</h5> </td>
	                </tr>
	            </table>
	        </div>
	
	        <br>
	        <div>
	        	계좌명 : <b style="margin-right:10px">${spMem.bank }</b> 계좌번호 : <b>${spMem.accountNum }</b>
	        </div>
			<br>
	        <table class="table-bordered table-sm" width="850px">
	            <thead>
	                <tr  class="table-danger">
	                    <th width="50">No</th>
	                    <th >후원한 회원명</th>
	                    <th>후원한 회원의 닉네임</th>
	                    <th>후원받은 금액</th>
	                    <th>후원받은 날짜</th>
	                    <th >후원자 은행명</th>
	                    <th width="180">후원자 계좌</th>
	                    
	                </tr>
	            </thead>
	            <!--반복문으로 뿌릴 때 제목을 클릭하면 해당 게시글로 넘어갈 수 있도록 해줘야해! 그럼 게시글 제목에 input-hidden으로 게시글 번호를 넣어줘야겠지 아마두-->
	            <tbody>
                	<c:forEach var="m" items="${list2 }">
		                <tr ><!-- 이렇게 해도 되나...? -->
			                    <td>${m.sponNo }</td>
			                    <td>${m.memName }</td>
			                    <td>${m.nickName }</td>
			                    <td><a>${m.sponFee }</a></td>
			                    <td>${m.sponDate }</td>
			                    <td >${m.bank }</td>
			                    <td >${m.accountNum }</td>
			                    
		                </tr>
                    </c:forEach>
	            </tbody>
	        </table>
		
	    	<br><Br>
			<ul class="pagination justify-content-center">
               	<c:choose>
               		<c:when test="${ pi.currentPage eq 1 }">
                    	<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
                    </c:when>
                    <c:otherwise>
                    			<li class="page-item"><a class="page-link" href="donaDetailOne.ad?currentPage=${pi.currentPage -1 }&smemNo=${spMem.smemNo}">&laquo;</a></li>
                    </c:otherwise>
              		</c:choose>
               
                <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage }">
                			<li class="page-item"><a class="page-link" href="donaDetailOne.ad?currentPage=${ p }&smemNo=${spMem.smemNo}">${ p }</a></li>
                </c:forEach>
                    
                    	
                <c:choose>
                   	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    	<li class="page-item disabled"><a class="page-link">&raquo;</a></li>
                    </c:when>
                    <c:otherwise>
	                    		<li class="page-item"><a class="page-link" href="donaDetailOne.ad?currentPage=${ pi.currentPage+1 }&smemNo=${spMem.smemNo}">&raquo;</a></li>
	                </c:otherwise>
                   </c:choose>
               </ul>
	    </article>
	
	    <br><br><br>
	    
	    
	    <br><br>
	    
</body>
</html>