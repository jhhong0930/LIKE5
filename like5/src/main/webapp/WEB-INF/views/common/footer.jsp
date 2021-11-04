<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
#footer {
	background-color: #F8F9FA;
	text-align: center;
}

#footerTop {
	padding-top: 2vh;
}

#footerBottom {
	margin-bottom: 2vh;
	color: lightgrey;
}

.footerImg {
	width: 70px;
	height: 40px;
	opacity: 0.2;
	cursor: pointer;
}

.footerImg:hover {
	opacity: 0.6;
}
</style>
</head>

<body>
	<!-- [한솔] 푸터바 : 초기 버전 지우고 변경 -->
	<footer class="container-fluid">
		<div class="row" id="footer">
			<div class="col-12" id="footerTop">
				<!-- 약관3종, 소개 페이지 -->
				<a href="teamAskMe.me"><img src="https://i.imgur.com/vhEZ5DJ.png" class="footerImg"></a>
			</div>
		</div>
		<div class="row" id="footer">
			<div class="col-12" id="footerBottom">
				Copyrightⓒ 2021 LIKE5 AllRights Reserved
			</div>
		</div>
	</footer>
</body>
</html>