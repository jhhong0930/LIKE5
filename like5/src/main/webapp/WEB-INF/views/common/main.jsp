<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LIKE5</title>

<style>
.header{border-bottom:none !important;}
/*div{border:1px solid black;}*/
.mainContent{
	background:linear-gradient(to bottom, rgba(211, 211, 211, 0.6) 0%,
			   rgba(211, 211, 211, 0.6) 100%), url("https://bit.ly/3itAEbV");
	background-position:center;
	background-repeat:no-repeat;
	background-attachment:scroll;
	background-size:cover;
	height:110vh;
	display:inline-flex;
	width:100%;
	margin-top:-75px;
	z-index:1;
}

#bigText{font-size:3rem;}
#smallText{font-size:0.9rem;}

@media(min-width:768px){
	#bigText{font-size:4.6rem; font-weight:bold;}
	#smallText{font-size:1.2rem;}
}

@media(max-width:1380px){ #bigText{font-size:4.2rem; font-weight:bold;} #smallText{font-size:1.2rem;} }
@media(max-width:1275px){ #bigText{font-size:3.9rem; font-weight:bold;} #smallText{font-size:1.2rem;}}
@media(max-width:1195px){ #bigText{font-size:3.7rem; font-weight:bold;} #smallText{font-size:1.2rem;} }
@media(max-width:1145px){ #bigText{font-size:3.5rem; font-weight:bold;} #smallText{font-size:1.2rem;} }
@media(max-width:1100px){ #bigText{font-size:3rem; font-weight:bold;} #smallText{font-size:1.0rem;} }

.divider{height:0.3rem; max-width:9rem; margin:1.5rem auto; background-color:rgb(220, 53, 69); border:0;}

.aboutSection{padding-bottom:5%;}

@media(max-width:768px){
	#main_bottom {padding-bottom:10%;}
}

#aboutUs{padding: 1% 3%; text-decoration:none;}

@media(prefers-reduced-motion:no-preference){
	:root{scroll-behavior:smooth;}
}
</style>
</head>

<body>
	<!-- 메뉴바 -->
	<jsp:include page="header.jsp"/>

	<!-- [한솔] 메인페이지 : 본문 반응형으로 제작 -->
	<!-- 메인페이지 상단부를 감싸는 div-->
	<div class="mainContent">
		<!-- 작업영역을 감싸는 div -->
		<div class="innerOuter">
			<div class="container px-4 px-lg-5 h-100 w3-animate-zoom">
				<div class="row gx-4 gx-lg-5 h-100 justify-content-center text-center">
					<div class="col-lg-8 align-self-end">
						<p class="font-weight-bold" id="bigText">Explain Like I'm 5</p>
						<hr class="divider" />
					</div>
					<div class="col-lg-8 align-self-baseline">
						<p class="mb-5"><b><i id="smallText">주니어 개발자를 위한 질문&답변 위주의 개발 커뮤니티</i></b></p>
						<a class="w3-button w3-red w3-round-xxlarge w3-hover-deep-orange" id="aboutUs" href="#about">About us</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- About Us -->
	<section class="aboutSection" id="about">
		<div class="container px-4 px-lg-5">
			<br><br><h2 class="text-center mt-5"><b>About Us</b></h2>
			<hr class="divider" /><br>

			<div class="w3-row-padding w3-center w3-section" id="main_bottom">
				<div class="w3-third">
					<div class="w3-card w3-container w3-margin-64" style="min-height: 300px">
						<br><br>
						<i class="fas fa-comments w3-margin-bottom w3-text-theme" style="font-size: 100px"></i>
						<br><br><h3><b>QnA</b></h3>
						<p id="explanation">
							개발자들과 다양한 질문을<br>
							자유롭게 주고 받아보세요
						</p>
						<a class="w3-button w3-red w3-round-xxlarge w3-hover-deep-orange" id="aboutUs" href="qnaList.bo">
							&nbsp;&nbsp;바로가기&nbsp;&nbsp;
						</a>
						<br><br><br>
					</div>
				</div>
				<div class="w3-third">
					<div class="w3-card w3-container" style="min-height: 300px">
						<br><br>
						<i class="fas fa-laptop-house w3-margin-bottom w3-text-theme" style="font-size: 100px"></i>
						<br><br><h3><b>공간대여</b></h3>
						<p id="explanation">
							프리미엄급 시설에서<br>
							다양한 모임을 가져보세요
						</p>
						<a class="w3-button w3-red w3-round-xxlarge w3-hover-deep-orange" id="aboutUs" href="bMain.bk">
							&nbsp;&nbsp;바로가기&nbsp;&nbsp;
						</a>
						<br><br><br>
					</div>
				</div>
				<div class="w3-third">
					<div class="w3-card w3-container" style="min-height: 300px">
						<br><br>
						<i class="fas fa-users w3-margin-bottom w3-text-theme" style="font-size: 100px"></i>
						<br><br><h3><b>커뮤니티</b></h3>
						<p id="explanation">
							같이 스터디를 꾸리거나,<br>
							함께 이야기를 나눠보세요
						</p>
						<a class="w3-button w3-red w3-round-xxlarge w3-hover-deep-orange" id="aboutUs" href="comList.bo">
							&nbsp;&nbsp;바로가기&nbsp;&nbsp;
						</a>
						<br><br><br>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 위로가기 아이콘 -->
	<a href="#header"><i class="fas fa-chevron-up" id="toTheTop">&nbsp;TOP</i></a>

	<!-- 푸터바 -->
	<jsp:include page="footer.jsp"/>

</body>
</html>