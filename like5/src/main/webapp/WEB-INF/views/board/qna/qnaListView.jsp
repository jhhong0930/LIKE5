<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[QnA] 게시글 리스트 보기</title>

<!-- qnaListView.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/qnaListView.css" />

</head>

<body>
	<!-- 메뉴바 -->
	<jsp:include page="../../common/header.jsp"/>

	<!-- [한솔] QnA 게시글 리스트 페이지 -->
	<div class="innerOuter" id="innerOuter">
		<!-- 전체를 감싸는 div -->
		<div class="qnaMain" id="qnaMain">

			<!-- 게시판 제목이 들어갈 부분 -->
			<div class="qnaMain_top1" id="top_name"><h2><b>QnA</b></h2></div>

			<!-- 게시판 기타 기능이 들어갈 부분 (최신순, 검색기능 등) -->
			<div class="qnaMain_top2">
				<!-- 정렬 리스트를 나누는 div -->
				<div class="qnaList">
					<div class="qnaList_new"><a href="">최신순</a></div>
					<div class="qnaList_like"><a href="">좋아요순</a></div>
					<div class="qnaList_reply"><a href="">답변순</a></div>
					<div class="qnaList_view"><a href="">조회순</a></div>
				</div> <!-- 정렬 리스트를 나누는 div 끝-->

				<!-- 중간 배열 div -->
				<div class="qnaMiddle"></div>

				<!-- 검색, 질문하기를 나누는 div -->
				<div class="qnaSearch">
					<div class="qnaSearch_tip">⭐ 검색 팁!
						<!-- hover 시 나타나는 검색 툴팁 -->
						<span class="tooltiptext">
							＊ 일반 단어 입력 후 검색 시 <br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							'키워드' 검색이 가능해요! <br>
							＊ 단어에 해시태그(#)를 붙이고 검색 시 <br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							'태그' 검색이 가능해요!
						</span>
					</div>
					<div class="qnaSearch_retrieve">
						<input type="text" class="searchArea" placeholder="검색어를 입력해보세요">
						<button><i class="fas fa-search"></i></button>
					</div>
					<div class="qnaSearch_question">
						<c:choose>
							<c:when test="${!empty loginUser}">
								<button type="button" class="btn btn-danger"><a href="qnaEnrollForm.bo">질문하기</a></button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-danger" onClick="loginAlert()">질문하기</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div> <!-- 검색, 질문하기를 나누는 div 끝 -->
			</div> <!-- 게시판 기타 기능이 들어갈 부분 끝-->
			
			<script>
			// 비로그인 시 질문하기 클릭 제한
			function loginAlert(){
				alertify.alert(" 로그인 후 이용해주세요. ")
			}
			</script>

			<!-- 게시판 중/하단 모두를 감싸는 div -->
			<div class="qnaContent">
				<!-- 게시글 리스트가 들어갈 부분 -->
				<div class="qnaBoard_main">
					<table class="w3-table w3-bordered w3-hoverable">

						<!-- 게시글 리스트 시작 -->
						<thead><tr><th colspan="5"></th></tr></thead>
						<c:forEach var="q" items="${ qnaList }">
							<tr>
								<!-- 좋아요 시작 -->
								<td class="qnaLike">
									<!-- 좋아요 상/중/하단 나누는 div-->
									<div id="qnaLike_1"></div>
									<div id="qnaLike_2">
										<!-- 좋아요 좌/우 나누는 div-->
										<div id="qnaLike_4"><i class="far fa-thumbs-up"></i></div>
										<div id="qnaLike_5">${ q.like }</div>
										<!-- 좋아요 좌/우 나누는 div 끝-->
									</div>
									<div id="qnaLike_3">좋아요</div> <!-- 좋아요 상/중/하단 나누는 div 끝-->
								</td> <!-- 좋아요 끝 -->
	
								<!-- 답변 시작 -->
								<td class="qnaReply">
									<!-- 답변 상/중/하단 나누는 div-->
									<div id="qnaReply_1"></div>
									<div id="qnaReply_2">
										<!-- 답변 좌/우 나누는 div-->
										<div id="qnaReply_4"><i class="far fa-comment-dots"></i></div>
										<div id="qnaReply_5">${ q.reply }</div>
										<!-- 답변 좌/우 나누는 div 끝 -->
									</div>
									<div id="qnaReply_3">답변</div>
									<!-- 답변 상/중/하단 나누는 div 끝-->
								</td> <!-- 답변 끝 -->
	
								<!-- 조회수 시작 -->
								<td class="qnaView">
									<!-- 조회수 상/중/하단 나누는 div-->
									<div id="qnaView_1"></div>
									<div id="qnaView_2">
										<!-- 조회수 좌/우 나누는 div-->
										<div id="qnaView_4"><i class="far fa-eye"></i></div>
										<div id="qnaView_5">${ q.count }</div>
										<!-- 조회수 좌/우 나누는 div 끝-->
									</div>
									<div id="qnaView_3">조회수</div>
									<!-- 조회수 상/중/하단 나누는 div 끝-->
								</td> <!-- 조회수 끝 -->
	
								<!-- 게시글 시작 -->
								<td class="qnaContent">
									<!-- 게시글 상/하단 나누는 div -->
									<div class="qnaTitle" id="qnaTitle">
										<!--a href="qnaDetail.bo">${ q.title }</a-->
										<p style="cursor:pointer;">${ q.title }</p>
										<input type="hidden" class="qCategory" name="category" value="QNA"></input>
										<input type="hidden" class="qBno" value="${ q.bno }">
									</div>
									<div id="qnaTag">
										<c:choose>
											<c:when test="${ empty q.tag }">
												<p id="noTag">no tag attached</p>
											</c:when>
											<c:otherwise>
												<c:forTokens var="tags" items="${ q.tag }" delims=" ">
													<button class="w3-button w3-white w3-border w3-border-red w3-round-xxlarge w3-hover-red w3-tiny">
														<!-- 클릭 시 tagDatail 페이지로 이동 -->
														<a href="tagDetail.ad"><c:out value="${ tags }"/></a>
													</button>
												</c:forTokens>
											</c:otherwise>
										</c:choose>
									</div> <!-- 태그영역 끝 -->
								</td> <!-- 게시글 끝 -->
	
								<!-- 작성자 시작 -->
								<td class="qnaUser">
									<!-- 작성자 상/중/하단 나누는 div-->
									<div id="qnaUser_1"></div>
									<div id="qnaUser_2">
										<!-- 작성자 좌/우 나누는 div-->
										<div id="qnaUser_4"><i class="far fa-user-circle"></i></div>
										<div id="qnaUser_5">
											<c:choose>
												<c:when test="${!empty loginUser}">
													<!-- 작성자 닉네임 데이터값, 클릭 시 프로필로 이동 / 로그인 후 확인 가능 -->
													<a href="memProfile.me">${ q.nickname }</a>
												</c:when>
												<c:otherwise>
													<p>${ q.nickname }</p>
												</c:otherwise>
											</c:choose>
										</div>
										<!-- 작성자 좌/우 나누는 div 끝-->
									</div>
									<div id="qnaUser_3">${ q.enrollDate }</div>
									<!-- 작성자 상/중/하단 나누는 div 끝-->
								</td> <!-- 작성자 끝 -->
							</tr> <!-- 게시글 리스트 끝 -->
						</c:forEach>
					</table>
				</div> <!-- 게시글 리스트가 들어갈 부분 끝 -->
				
				
				<script>
				// 게시글 제목 클릭 시 상세 페이지로 이동
				$(function(){
					$(".qnaContent>.qnaTitle").click(function(){
						location.href="qnaDetail.bo?bno=" + $(this).children(".qBno").val();
					})
				})
				</script>


				<!-- 페이지네이션 스타일 수정 예정 -->
				<div class="pagingArea">
					<div class="nullArea"></div>
					<ul class="pagination">
						<c:choose>
							<c:when test="${ pi.currentPage eq 1 }">
								<li class="page-item disabled"><a class="page-link">&laquo;</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a class="page-link" href="qnaList.bo?currentPage=${ pi.currentPage-1 }">&laquo;</a>
								</li>
							</c:otherwise>
						</c:choose>
						
						<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
							<li class="page-item">
								<a class="page-link" href="qnaList.bo?currentPage=${ p }">${ p }</a>
							</li>
						</c:forEach>
								
						<c:choose>
							<c:when test="${ pi.currentPage eq pi.maxPage }">
								<li class="page-item disabled"><a class="page-link">&raquo;</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a class="page-link" href="qnaList.bo?currentPage=${ pi.currentPage+1 }">&raquo;</a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
					<div class="nullArea"></div>
				</div> <!-- 페이지네이션 끝 -->
			</div> <!-- 게시판 중/하단 모두를 감싸는 div 끝 -->
		</div> <!-- 전체를 감싸는 div 끝-->
	</div> <!-- innerOuter 끝 -->

	<!-- 푸터바 -->
	<jsp:include page="../../common/footer.jsp"/>
</body>
</html>