<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>team Ask Me</title>

<!-- teamAskMe.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/teamAskMe.css" />
	
</head>
<body>
	<!-- 메뉴바 -->
	<jsp:include page="header.jsp" />
	
	<!-- [한솔] footer.jsp에서 넘어오는 페이지 : 팀 소개 -->
	<div class="innerOuter">
		<!-- 전체를 감싸는 div -->
		<div class="aboutMain">
			<!-- 페이지 상단 -->
			<div class="pageTop"><h2><b>TEAM ASKME</b></h2></div>
			<!-- 페이지 상단 끝 -->

			<!-- 페이지 하단부 -->
			<div class="pageBottom">
				<!-- 좌측 사이드바 영역 -->
				<div class="pageLeft">
					<div class="sideBar">
						<!-- Team AskMe -->
						<div class="askMe">
						<a href="teamAskMe.me"><h4 class="barName">Team AskMe</h4></a></div>

						<div class="divider"></div>

						<!-- Legal Notice -->
						<div class="legal">
							<div><h4 class="barName">Legal Notice</h4></div>
							<ul>
								<li><a href="terms.me">이용약관</a></li>
								<li><a href="legal.me">법적고지</a></li>
								<li><a href="privacy.me">개인정보처리방침</a></li>
							</ul>
						</div>

						<div class="divider"></div>

						<!-- Contact Us -->
						<div class="contact">
							<div class="contactUs"><h4 class="barName">Contact Us</h4></div>	
								<ul>
									<li><a href="https://github.com/hansololiviakim/like5">GitHub</a></li>
								</ul>
						</div>
					</div>
				</div>
				<!-- 좌측 사이드바 영역 끝 -->

				<!-- 우측 본문 영역 -->
				<div class="pageRight">
					<!-- 본문 -->
					<div class="w3-search" id="teamContent">
						<!-- 본문 소개 영역 -->
						<div class="teamMem">
							<!-- 예약관리 파트 -->
							<div class="bkTeam">
								<div class="booking">BOOKING
									<table class="bkTable">
										<tr>
											<td rowspan="2"></td>
											<td class="imageCell">
												<img src="https://i.imgur.com/8MJHFPm.png" class="w3-round">
											</td>
											<td class="between" rowspan="2"></td>
											<td class="imageCell">
												<img src="https://i.imgur.com/T8MIDvR.png" class="w3-round">
											</td>
											<td rowspan="2"></td>
										</tr>
										<tr>
											<td class="memName">Jeongbin Park </td>
											<td class="memName">Sinwon Shin</td>
										</tr>
									</table>
								</div>
							</div>
							<!-- 예약관리 파트 끝-->

							<!-- 커뮤니티 파트 -->
							<div class="comTeam">
								<div class="community">COMMUNITY
									<table class="comTable">
										<tr>
											<td  rowspan="2"></td>
											<td class="imageCell">
												<img src="https://i.imgur.com/PUa5ltL.png" class="w3-round">
											</td>
											<td class="between" rowspan="2"></td>
											<td class="imageCell">
												<img src="https://i.imgur.com/SKbExpo.png" class="w3-round">
											</td>
											<td class="between" rowspan="2"></td>
											<td class="imageCell">
												<img src="https://i.imgur.com/IfWswRX.png" class="w3-round">
											</td>
											<td rowspan="2"></td>
										</tr>
										<tr>
											<td class="memName">Seongeun Kim</td>
											<td class="memName">Hansol Kim</td>
											<td class="memName">Donggyu Won</td>
										</tr>
									</table>
								</div>
							</div>
							<!-- 커뮤니티 파트 끝 -->

							<!-- 관리자 파트 -->
							<div class="adTeam">
								<div class="admin">ADMIN
									<table class="adTable">
										<tr>
											<td rowspan="2"></td>
											<td class="imageCell">
												<img src="https://i.imgur.com/6wHxHrj.png" class="w3-round">
											</td>
											<td class="between" rowspan="2"></td>
											<td class="imageCell">
												<img src="https://i.imgur.com/tm7MZsa.png" class="w3-round">
											</td>
											<td rowspan="2"></td>
										</tr>
										<tr>
											<td class="memName">Jaehwan Hong</td>
											<td class="memName">Jihyeon Han</td>
										</tr>
									</table>
								</div>
							</div>
							<!-- 관리자 파트 끝 -->
						</div>
						<!-- 본문 소개 영역 끝 -->
					</div>
					<!-- 본문 끝 -->
				</div>
				<!-- 우측 본문 영역 끝 -->
			</div>
			<!-- 페이지 하단부 끝 -->	
		</div>
		<!-- 전체를 감싸는 div 끝-->
	</div>
	<!--페이지 영역 끝 -->

	<!-- 푸터바 -->
	<jsp:include page="footer.jsp" />
</body>
</html>