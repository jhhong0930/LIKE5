<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	/*예약관리부분*/
	.outer {
		width: 70% !important; 
		margin: auto !important;
		align-items:center;
		padding:10px 20px;
		border: 1px solid red;
	}
	.content-area{
		margin-left:150px;
		border: 1px solid lightgray;
	}
	.content-area3{
		/* border: 1px solid blue; */
		width:100%;
	}
	.content-area4{
		/* border: 1px solid green; */
		width:100%;
	}
	.content-area5{
		/* border: 1px solid blueviolet; */
		width:95%;
	}
	.content-area6{
		/* border: 1px solid blueviolet; */
		width:100%;
		margin-left:20px;
	}
	.content-area7{
		/* border: 1px solid blueviolet; */
		width:100%;
	}
	.content-area8{
		/* border: 1px solid blueviolet; */
		width:100%;
		margin:15px 0 5px 0
	}
	.content-area9{
		/* border: 1px solid blueviolet; */
		width:100%;
	}
	#tablelist{
		/* border: 1px solid black; */
		width:40%;
		margin:5px 0 5px 0
	}
	#tablelist2{
		/* border: 1px solid black; */
		width:60%;
		height:80px;
	}
	#tablelist3{
		/* border: 1px solid black; */
		width:25%;
		margin-left:20px;
		
	}
	#tablelist4{
		/* border: 1px solid black; */
		width:33%;
		margin-left:20px;
		
	}
	#tablelist5{
		/* border: 1px solid black; */
		width:33%;
		margin-left:20px;
		
	}
	#buttons2{
		/* border: 1px solid red; */
		width:30%;
		margin:10px 0 15px 0;
		margin-left:20px;
	}    
	
	/*사이드 바*/
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
	
	aside li a:hover:not(.active) {
		background-color: rgb(220, 53, 69);
		color: white;
		text-decoration: none;
	}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!--여기부터 예약 관리-->

<!--예약관리 버튼-->
<div class="outer">
	<div class="aside-title">
		<h3>통합관리</h3>
	</div>
	<aside>
		<ul>
		<li><a class="active" href="member.ad">회원관리</a></li>
		<li><a href="board.ad">게시글관리</a></li>
		<li><a href="customer.ad">고객센터</a></li>
		<li><a href="donation.ad">후원관리</a></li>
		<li><a href="list.bk">공간대여관리</a></li>
		<li><a href="space.bo">공간예약관리</a></li>
		</ul>
	</aside>

	
	<div class="content-area">    
		<!--예약내역-->
		<div class="content-area2" >
			<div class="content-area3">
					<h4><b>최빛나님 예약내역</b></h4>
			</div>   
			
				<hr>

			<div class="content-area4">
				<table id="tablelist">
						<tr>
							<td><b>예약번호</b></td>
							<td>${bi.bookingNo}</td>
						</tr>
						<tr>
							<td><b>예약신청일(결제일)</b></td>
							<td><input type="text" name="requestDate" value="${bi.requestDate}"></td>
						</tr>
				</table>
			</div>

				<hr>

			<div class="content-area5">
				<table id="tablelist2">
					<tr>
						<td><b>입주 시작일 :</b></td>
						<td><input type="text" name="startDate" value="${bi.startDate}"></td>
						<td><b>인원 수 :</b> ${bi.person}</td>
					</tr>
					<tr>
						<td><b>입주 마지막일 :</b></td>
						<td><input type="text" name="endDate" value="${bi.endDate}"></td>
					</tr>
				</table>
			</div>

				<hr>

			<div class="content-area6">
					<h4><b>요금 내역</b></h4><br>
			</div>

			<br>

			<div class="content-area7">
				<table id="tablelist3">
					<tr>
						<td><b>${bi.price} x 1일</b></td>
						<td><b>${bi.price}</b></td>
					</tr>
				</table>
			</div>

			<div class="content-area8">
				<table id="tablelist4">
					<tr>
						<td><b>수수료</b></td>
						<td><b>${bi.price*0.1}</b></td>
					</tr>
				</table>
			</div>

				<hr>

			<div class="content-area9">
				<table id="tablelist5">
					<tr>
						<td><b>총 합계</b></td>
						<td><b>${bi.price + bi.price*0.1}</b></td>
					</tr>
				</table>
			</div>
				
				<hr>

				<div id="buttons2">
					<button class="btn btn-danger btn-sm" onclick="history.back()">뒤로가기</button>
				</div>

		</div>

	</div>

</div>
</body>
</html>