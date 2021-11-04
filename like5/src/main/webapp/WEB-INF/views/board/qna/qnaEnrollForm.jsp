<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[QnA] 질문 작성하기</title>

<!-- qnaDetailView.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/qnaEnrollForm.css" />

<!--토스트 UI-->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.css" />	

</head>

<body>
	<!-- 메뉴바 -->
	<jsp:include page="../../common/header.jsp" />
	
	<!-- [한솔] QnA 게시글 상세 페이지 -->
	<div class="innerOuter">
		<!-- 전체를 감싸는 div -->
		<div class="qnaMain">
			<!-- 본문 상단 영역 -->
			<div class="qnaTop"><h2><b>QnA / 질문하기</b></h2></div>
	
			<!-- 본문 하단 영역 -->
			<div class="qnaBottom">
				<!-- 좌측 글쓰기 영역 -->
				<div class="qnaBottomLeft">
					<!-- 제목, 태그, 본문 작성 영역
						 [novalidate] <form>이 유효성검사(검사 후 경고 안내문 출력)를 하지 않도록 지정 -->
					<form class="qnaWrite"  id="enrollForm" method="post" action="qnaInsert.bo" enctype="multipart/form-data" novalidate>
						<!-- 작성자, 카테고리 -->
						<input class="form-group" id="qWriter" name="mno" value="${ loginUser.memNo }" hidden></input>
						<input class="form-group" id="qCategory" name="category" value="QNA" hidden></input>
						<input type="hidden" name="content" value="">
						<!-- 제목 영역 -->
						<div class="form-group">
							<label for="qTitle">
								<button type="button" class="btn btn-secondary" disabled>제목</button>
								&nbsp;&nbsp;제목은 50자 이내로 입력해주세요!
							</label>
							<input type="text" class="form-control" id="qTitle" name="title"
								placeholder="다른 사람들이 자세히 알 수 있도록 구체적으로 제목을 작성해주세요." required>
							<div class="valid-feedback">제목이 입력되었습니다.</div>
							<div class="invalid-feedback">제목을 작성해주세요.</div>
						</div>
						<!-- 제목 영역 끝 -->
	
						<!-- 태그 영역 -->
						<div class="form-group">
							<label for="qTag">
								<button type="button" class="btn btn-secondary" disabled>태그</button>
								&nbsp;&nbsp;해시태그(#)와 태그 이름을 입력한 후 띄어쓰기로 구분해주세요!&nbsp;&nbsp;<i>ex)#JAVA #AWS ...</i>
							</label>
							<input type="text" class="form-control" id="qTag"
								placeholder="첨부 가능한 태그 확인 후 관련있는 태그를 입력해주세요. 입력 양식과 일치하지 않을 경우 태그가 보여지지 않아요." name="tag" required>
							<div class="valid-feedback">태그가 입력되었습니다.</div>
							<div class="invalid-feedback">태그를 입력해주세요.</div>
						</div>
						<!-- 태그 영역 끝 -->
	
						<!-- 본문 영역 --> 
						<div class="form-group">
							<label for="qContent">
								<button type="button" class="btn btn-secondary" disabled>본문</button>
								&nbsp;&nbsp;질문하고 싶은 내용을 입력해주세요!
							</label>
							<!-- 토스트 UI-->
							<div id="editor" onkeyup="keyevent(this);" class="form-control" ></div>
							<!-- 본문 유효성 검사 로직 확인 후 수정하기 -->
							<!-- 0816 : 글이 작성 되지 않아도, insert 됨 -->
							<textarea class="form-control" id="qContent" name="content" rows="5"  style="display:none;"></textarea>
							<div class="valid-feedback">본문이 입력되었습니다.</div>
							<div class="invalid-feedback">본문을 작성해주세요.</div>
						</div>
						<!-- 본문 영역 -->
						
						<!--토스트 UI-->
		  			  	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
						
						<script>
					 	 //토스트 UI에 작성된 내용을 form태그 안에 있는 name="content"인 요소에 value값으로 지정
				        function keyevent(){
				        	var content = editor.getHTML();
				        	$("#enrollForm").children().eq(2).attr("value",content);
				        }
						</script>
						
						<!-- 작성 주의사항 -->
						<div class="alert alert-danger alert-dismissible">
							<button type="button" class="close" data-dismiss="alert">&times;</button>
							<b>주의!</b>&nbsp;&nbsp;답변이 달린 질문은 수정/삭제가 불가하니 내용을 다시 한 번 확인해주세요!
						</div>
	
						<!-- 검사 체크 영역 -->
						<div class="form-group form-check">
							<label for="agree" class="form-check-label">
								<input class="form-check-input" type="checkbox" name="agree" id="agree" required>
									&nbsp;(필수) 상단의 안내사항을 확인하였습니다.
								<div class="valid-feedback">안내사항에 동의하셨습니다.</div>
								<div class="invalid-feedback">질문을 등록하시려면 안내 확인에 체크해주세요.</div>
							</label>
						</div>
						<!-- 검사 체크 영역 끝 -->
	
						<!-- 버튼 영역 -->
						<div class="w3-container w3-right-align w3-margin-top">
							<button type="button" onclick="storage()" class="w3-button w3-white w3-border w3-border-gray w3-round">임시저장</button>
							<button type="submit" class="btn btn-danger" id="submitButton">작성하기</button>
						</div><!-- 버튼 영역 끝 -->
					</form><!-- 제목, 태그, 본문 작성 영역 끝 -->
				</div><!-- 좌측 글쓰기 영역 끝 -->
				
				<script>
				// 작성하기 버튼 클릭 시 유효성 검사
				(function() {
					'use strict';
					window.addEventListener('load', function() {
						var forms = document.getElementsByClassName('qnaWrite');
						var validation = Array.prototype.filter.call(forms, function(form) {
							form.addEventListener('submit', function(event) {
								if (form.checkValidity() === false) {
									event.preventDefault();
									event.stopPropagation();
								}
								form.classList.add('was-validated');
							}, false);
						});
					}, false);
				})();
				
				// 임시저장 클릭 시 qnaStorageInsert.bo로 값 제출
				function storage(){
					$("#enrollForm").attr("action", "qnaStorageInsert.bo").submit();
				}

				// 사용자가 입력한 태그 데이터 검사
				
				
			   //토스트 UI 에디터
		        const Editor = toastui.Editor;
		        const editor = new Editor({
		            el: document.querySelector('#editor'),
		            height: '600px',
		            previewStyle: 'vertical',
		            initialValue: '🙋‍♂️어떻게 질문하는지 궁금하다면? <br> 오른쪽의 ⭐좋은 질문을 작성하는 팁⭐을 이용해주세요.',
		            language: 'ko',
		        });
			       
			        
				
				</script>
	
				<!-- 우측 설명 영역 & 팁 아코디언 -->
				<div class="qnaBottomRight">
					<!-- 태그 검색 -->
					<div class="tagList" style="width:100%; height:150px; overflow:auto">
						<div class="tipName">
							<b>⭐ 첨부 가능한 태그 보기 ⭐</b>
						</div>
						<!-- tag DB에 등록된 리스트 정렬 -->
						<table class="w3-table w3-striped w3-bordered w3-centered" id="tagTable">
							<c:forEach var="t" items="${ tagList }">
								<tr>
									<td hidden>${ t.tagNo }</td>
									<td>${ t.tagName }</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<!-- 태그 검색 끝 -->
					
					<!-- 팁 아코디언 -->
					<div class="tipName" style="margin-top:10%;">
						<b>⭐ 좋은 질문을 작성하는 팁 ⭐</b>
					</div>
					<button onclick="explanation('Tip1')" class="w3-button w3-block w3-white w3-center-align" id="tip">
						1. 구체적으로 작성해주세요&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="badge badge-light">click!</span>
					</button>
					<div id="Tip1" class="w3-hide w3-container">
						<p>
							＊&nbsp;문제를 어떻게 재현할 수 있는지<br>
							&nbsp;&nbsp;&nbsp;&nbsp;
							자세하게 설명해주세요.<br><br>
							＊&nbsp;사용하는 언어나 프레임워크가 있다면<br>
							&nbsp;&nbsp;&nbsp;&nbsp;
							태그를 선택하여 첨부해주시고,<br>
							&nbsp;&nbsp;&nbsp;&nbsp;
							사용 중인 툴과 버전 등을<br>
							&nbsp;&nbsp;&nbsp;&nbsp;
							명시하는 것도 도움이 됩니다.
						</p>
					</div>
					<hr class="tipLine">
					<button onclick="explanation('Tip2')" class="w3-button w3-block w3-white w3-center-align" id="tip">
						2. 에러메세지를 알려주세요&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="badge badge-light">click!</span>
					</button>
					<div id="Tip2" class="w3-hide w3-container">
						<p>
							＊&nbsp;오류메세지가 있다면 같이 적어주세요.<br>
							&nbsp;&nbsp;&nbsp;&nbsp;
							답변 작성자에게 많은 도움이 될거에요.
						</p>
					</div>
					<hr class="tipLine">
					<button onclick="explanation('Tip3')" class="w3-button w3-block w3-white w3-center-align" id="tip">
						3. 소스 코드를 첨부해주세요&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="badge badge-light">click!</span>
					</button>
					<div id="Tip3" class="w3-hide w3-container">
						<p>
							＊&nbsp;되도록 소스코드는 스크린샷이 아닌,<br>
							&nbsp;&nbsp;&nbsp;&nbsp;
							마크다운을 이용해 첨부해주세요.<br><br>
							＊&nbsp;질문을 쉽게 파악할 수 있도록<br>
							&nbsp;&nbsp;&nbsp;&nbsp;
							관련 내용의 핵심 코드만 올려주세요.
						</p>
					</div>
					<hr class="tipLine">
					<!-- 팁 아코디언 끝-->
					
					<script>
					// 팁 아코디언
					function explanation(id) {
						var x = document.getElementById(id);
						if (x.className.indexOf("w3-show") == -1) {
							x.className += " w3-show";
							x.previousElementSibling.className = 
							x.previousElementSibling.className.replace("w3-white", "w3-red");
						} else { 
							x.className = x.className.replace(" w3-show", "");
							x.previousElementSibling.className = 
							x.previousElementSibling.className.replace("w3-red", "w3-white");
						}
					}
					
				 
					
					</script>
					
				</div>
				<!-- 우측 설명 영역 끝 -->
			</div>
			<!-- 본문 하단 영역 끝 -->
		</div>
		<!-- 전체를 감싸는 div 끝 -->
	</div>
	<!-- 본문 끝 -->

	<!-- JS -->
	<script>		
		// 테이블 내 일치하는 필드값 검색
		function tagSearch() {
			var input, filter, table, tr, td, i;
			input = document.getElementById("tagInput");
			filter = input.value.toUpperCase();
			table = document.getElementById("tagTable");
			tr = table.getElementsByTagName("tr");
			for (i = 0; i < tr.length; i++) {
				td = tr[i].getElementsByTagName("td")[0];
				if (td) {
					txtValue = td.textContent || td.innerText;
					if (txtValue.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else {
						tr[i].style.display = "none";
					}
				}
			}
		}
	</script>
	
	<!-- 푸터바 -->
	<jsp:include page="../../common/footer.jsp" />
</body>
</html>