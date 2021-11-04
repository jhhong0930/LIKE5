<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[QnA] 게시글 상세보기</title>

<!-- qnaDetailView.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/qnaDetailView.css" />

<!-- i'mport library -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
	
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
			<!-- 페이지 상단 이름/질문하기 버튼 영역 -->
			<div class="qnaTop">
				<div class="qnaTop1"><h2><b>QnA</b></h2></div>
				<div class="qnaTop2">
					<c:choose>
						<c:when test="${!empty loginUser}">
							<button type="button" class="btn btn-danger"><a href="qnaEnrollForm.bo">질문하기</a></button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-danger" onClick="loginAlert()">질문하기</button>
						</c:otherwise>
					</c:choose>
				</div>
			</div><!-- 페이지 상단 이름/질문하기 버튼 영역 끝 -->
			
			<script>
			// 비로그인 시 질문하기 클릭 제한
			function loginAlert(){
				alertify.alert(" 로그인 후 이용해주세요. ")
			}
			</script>

			<!-- 페이지 중단 게시글 디테일 영역 -->
			<div class="qnaMiddle">
				<!-- 게시글 정보 영역 -->
				<div class="qnaInfo">
					<table>
						<tr class="qnaInfo1">
							<td class="tableBlank" rowspan="2"></td>
							<td class="qnaTitle"><!-- 게시글 제목 -->${ b.title }</td>
							<td class="qnaLike1"><i class="far fa-thumbs-up"></i></td>
							<td class="qnaLike2"><!--좋아요 수 데이터 값 -->${ b.like }</td>
							<td class="qnaReply1"><i class="far fa-comment-dots"></i></td>
							<td class="qnaReply2"><!--답변 수 데이터 값 -->${ b.reply }</td>
							<td class="qnaView1"><i class="far fa-eye"></i></td>
							<td class="qnaView2"><!--조회수 데이터 값 -->${ b.count }</td>
							<td class="tableBlank" rowspan="2"></td>
						</tr>
						<tr class="qnaInfo2">
							<td class="qnaTag">
								<c:choose>
									<c:when test="${ empty b.tag }">
										<p id="noTag">no tag attached</p>
									</c:when>
									<c:otherwise>
										<c:forTokens var="tags" items="${ b.tag }" delims=" ">
											<button class="w3-button w3-white w3-border w3-border-red w3-round-xxlarge w3-hover-red w3-tiny">
												<!-- 클릭 시 tagDatail 페이지로 이동 -->
												<a href="tagDetail.ad"><c:out value="${ tags }"/></a>
											</button>
										</c:forTokens>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="qnaUser1"><i class="far fa-user-circle"></i></td>
							<td class="qnaUser2" colspan="3">${ b.nickname }</td>
							<td class="qnaUser3" colspan="2">${ b.enrollDate }</td>
						</tr>
					</table>
				</div><!-- 게시글 정보 영역 끝 -->

				<!-- 게시글 상세 영역 -->
				<div class="qnaDetail">
					<!-- 좌측 게시글 본문 -->
					<div class="qnaContent">
						<div class="contentData">
							<div id="editor" style="display:none;">${b.content}</div>
                			<div id="viewer"></div>
						</div>
					</div><!-- 좌측 게시글 본문 끝 -->

			      <!--토스트 UI-->
		    	  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
		    
		    	  <script>
			    	 	 $(function(){
				        	ToView();
				        })
				        
				        /*토스트 UI */
			    		const content = [].join('\n');
			    	    const editor = new toastui.Editor({
				               el: document.querySelector('#editor'),
				           });
			    	    /*토스트 UI 뷰어 */	
				        const viewer = toastui.Editor.factory({
				            el: document.querySelector('#viewer'),
				            viewer: true,
				            height: '500px',
				            initialValue: content
				        });
		
				        function ToView(){
				            viewer.setMarkdown(editor.getHTML());
				        };
			        </script>
		    	

					<!-- 우측 아이콘 옵션 -->
					<div class="qnaIcon">
						<!-- 글 작성자와 로그인한 회원이 불일치할 경우 -->
						<c:choose>
							<c:when test="${ loginUser.memNo ne b.mno }">
								<table>
									<tr><td></td></tr>
									<c:choose>
										<c:when test="${!empty loginUser}">
											<tr>
												<td class="icon" onclick="likeAndScrap(1);"><i class="far fa-thumbs-up" id="like"></i>
													<i class="fas fa-thumbs-up" id="selected-like" style="display: none; color: rgb(220, 53, 69);"></i>
												</td>
											</tr>
											<tr><td class="iconName">좋아요</td></tr>
											<tr>
												<td class="icon" onclick="likeAndScrap(2);"><i class="far fa-bookmark" id="scrap"></i>
													<i class="fas fa-bookmark" id="selected-scrap" style="display: none; color: rgb(220, 53, 69);"></i>
												</td>
											</tr>
											<tr><td class="iconName">스크랩</td></tr>
											<tr>
												<td class="icon"><i class="far fa-thumbs-down" data-toggle="modal" data-target="#report-modal"></i></td>
											</tr>
											<tr><td class="iconName">신고하기</td></tr>
										</c:when>
										<c:otherwise>
											<!-- 비회원일 경우 -->
											<tr onClick="loginAlert()">
												<td class="icon"><i class="far fa-thumbs-up" id="like"></i></td>
											</tr>
											<tr><td class="iconName">좋아요</td></tr>
											<tr onClick="loginAlert()">
												<td class="icon"><i class="far fa-bookmark" id="scrap"></i></td>
											</tr>
											<tr onClick="loginAlert()"><td class="iconName">스크랩</td></tr>
											<tr onClick="loginAlert()">
												<td class="icon"><i class="far fa-thumbs-down"></i></td>
											</tr>
											<tr><td class="iconName">신고하기</td></tr>
										</c:otherwise>
									</c:choose>
									<!-- 서버 연동할 경우 그 후에 작업 (로컬로 url 파싱 불가) -->
									<tr><td class="icon"><i class="fas fa-share-alt" data-toggle="modal" data-target="#url-modal"></i></td></tr>
									<tr><td class="iconName">URL 공유</td></tr>
									<tr><td></td></tr>
								</table>
							</c:when>
							<c:otherwise>		
								<!-- 글 작성자와 로그인한 회원이 일치할 경우 -->
					            <table>
					              <tr><td></td></tr>
					              <tr onclick="postFormSubmit(1)"><td class="icon"><i class="fas fa-sync-alt"></i></td></tr>
					              <tr><td class="iconName">수정하기</td></tr>
					              <tr><td class="icon"><i class="fas fa-share-alt" data-toggle="modal" data-target="#url-modal"></i></td></tr>
					              <tr><td class="iconName">URL 공유</td></tr>
					              <tr><td class="icon"><i class="far fa-trash-alt" data-toggle="modal" data-target="#delete-modal"></i></td></tr>
					              <tr><td class="iconName">삭제하기</td></tr>
					              <tr><td></td></tr>
					            </table>
					    	</c:otherwise>
						</c:choose>
						
						<form id="postForm" action="" method="post">
							<input type="hidden" name="bno" value="${ b.bno }">
							<input type="hidden" name="qnaStatus" value="${ b.status }">
						</form>
						
						<script>
						function postFormSubmit(num){
							if(num == 1){ // 수정하기
								$("#postForm").attr("action", "qnaUpdateForm.bo").submit();
							}else{ // 삭제하기
								$("#postForm").attr("action", "qnaDelete.bo").submit();
							}
						}
						</script>
						
					</div><!-- 우측 아이콘 옵션 끝 -->
				</div><!-- 게시글 상세 영역 끝 -->
			</div><!-- 페이지 중단 게시글 디테일 영역 끝 -->
						
			<script>
			<%--좋아요 아이콘 클릭 시 아이콘 변경
			$('[class$=fa-thumbs-up]').click(function() {
				if ($('#selected-like').css('display') == 'none') {
					$('#selected-like').css('display', '');
					$('#like').css('display', 'none');
				} else {
					$('#selected-like').css('display', 'none');
					$('#like').css('display', '');
				}
			})
	
			//스크랩 아이콘 클릭 시 아이콘 변경
			$('[class$=fa-bookmark]').click(function() {
				if ($('#selected-scrap').css('display') == 'none') {
					$('#selected-scrap').css('display', '');
					$('#scrap').css('display', 'none');
				} else {
					$('#selected-scrap').css('display', 'none');
					$('#scrap').css('display', '');
				}
			})--%>
			
			// 좋아요(1), 스크랩(2) insert/delete js
			function likeAndScrap(num){
				if(num == 1){
					// 좋아요 버튼 클릭 시 like 테이블에 insert
					$("#like").click(function(){
						$.ajax({
							url: "likeAndScrap.bo",
							data: {
								bno: ${ b.bno },
								mno: ${ loginUser.memNo },
								condition: "like",
							}
							,success: function(status){
								if(status == "success"){
									alertify.alert("좋아요 성공!🎉");
									$('#selected-like').css('display', '');
                					$('#like').css('display', 'none');
								}
							}
						})
					})
					
					// 좋아요 비활성화 버튼 클릭 시 like 테이블에서 delete
					$("#selected-like").click(function(){
						$.ajax({
							url: "UnlikeAndUnScrap.bo",
							data: {
								bno: ${ b.bno },
								mno: ${ loginUser.memNo },
								condition: "like",
							}
							,success: function(status){
								if(status == "success"){
									alertify.alert("좋아요 해제😅");
									$('#like').css('display','');
            						$('#selected-like').css('display','none');
								}
							}
						})
					})
				}
				
				if(num == 2){
					// 스크랩 버튼 클릭 시 like 테이블에 insert
					$("#scrap").click(function(){
						$.ajax({
							url: "likeAndScrap.bo",
							data: {
								bno: ${ b.bno },
								mno: ${ loginUser.memNo },
								condition: "scrap",
							}
							,success: function(status){
								if(status == "success"){
									alertify.alert("스크랩 성공!🎉");
									$('#selected-scrap').css('display', '');
                					$('#scrap').css('display', 'none');
								}
							}
						})
					})
					
					// 스크랩 비활성화 버튼 클릭 시 like 테이블에서 delete
					$("#selected-like").click(function(){
						$.ajax({
							url: "UnlikeAndUnScrap.bo",
							data: {
								bno: ${ b.bno },
								mno: ${ loginUser.memNo },
								condition: "scrap",
							}
							,success: function(status){
								if(status == "success"){
									alertify.alert("스크랩 해제😅");
									$('#scrap').css('display','');
            						$('#selected-scrap').css('display','none');
								}
							}
						})
					})
				}
			}
			</script>
			
			
			<!-- 답변 갯수 안내 -->
			<div class="replyGuide"><b>${ b.reply }개의 답변</b></div>
			<!-- 페이지 하단 댓글 디테일 영역 -->
			<div class="qnaBottom" id="qnaBottom">
			</div><!-- 페이지 하단 댓글 디테일 영역 끝 -->
			
			<!-- 댓글 js -->
			<script>
			<%-- 페이지 로드 직후 곧바로 실행되도록 함 --%>
			$(function(){
				selectReplyList();
			})
			
			
			<%-- 댓글 리스트 --%>
	         function selectReplyList(){
	            
	            var repNo = [];
	            
	            $.ajax({
	               url: "rlist.bo",
	               data: {
	                  bno: ${ b.bno },
	               },
	               // 댓글 리스트 조회 성공 시
	               success: function(list){
	                  console.log(list);
	                  
	                  // 배열의 길이로 댓글 갯수 알아내기
	                  $("#rcount").text(list.length);
	                  
	                  // value에 담긴 값 초기화
	                  var value = "";
	                  /*
	                  var tt = list[0].repContent;
	                  
	                  const Editor3 = toastui.Editor;
	                  const viewer = Editor3.factory({
	                     el:document.querySelector("#test"),
	                     viewer:true,
	                     height:"300px",
	                     initialValue:tt
	                  })*/
	                  
	                  for(var i in list){
	                     const Editor3 = toastui.Editor;
	                     /*
	                      const editor3 = new Editor3({
	                           el: document.querySelector("#test"),
	                           height: '500px',
	                           previewStyle: 'vertical',
	                           language: 'ko',
	                           initialValue:  list[i].repContent
	                       });
	                      var content = editor3.getHTML();
	                     */

	                     // 원댓글 html
	                     value += 
	                        '<div class="replyLv1">'
	                        +   '<div class="replyInfo">'
	                        +      '<table>'
	                        +         '<tr class="replyInfo1" style="color:red;">'
	                        +         '<tr class="replyInfo1" style="color:red;">'
	                        +            '<td class="tableBlank" rowspan="2"></td>'
	                        +            '<td class="replyUser1" rowspan="2"><i class="far fa-user-circle"></i></td>'
	                        +            '<td class="replyUser2">' + list[i].nickname + '</td>'
	                        +            '<td class="replyAdoption" rowspan="2" colspan="2">';
	                        
	                     if(${loginUser.memNo} == ${b.mno}) {
	                        value +=      '<input type="hidden" value="' + list[i].repNo + '">'                        
	                              +            '<button type="button" class="btn text-muted btn-lg" id="adopModal" data-toggle="modal" data-target="#adoption-modal">'
	                              +                     '<i class="far fa-check-square text-muted"></i>&nbsp;&nbsp;&nbsp;채택하기'
	                              +             '</button>';
	                     }
	                        
	                     value +=         '</td>'
	                           +            '<td class="tableBlank" rowspan="2"></td>'
	                           +         '</tr>'
	                           +         '<tr class="replyInfo2">'
	                           +            '<td class="replyUser3">' + list[i].repEnrollDate + '</td>'
	                           +         '</tr>'
	                           +      '</table>'
	                           +   '</div>'
	                           +   '<div class="replyDetail">'
	                           +      '<div class="replyContent">'
	                           +         '<div class="replyContentData editor3">'
	                           +                    list[i].repContent
	                           +         '</div>'
	                           +      '</div>'
	                           +      '<div class="replyIcon">'
	                           +               '<table>'
	                           +                  '<tr><td class="rIcon"></td></tr>';
	                        
	                     if("${loginUser.memNo}" != "" )   {
	                        if(${loginUser.memNo} == list[i].memNo){
	                           value += '<tr><td class="rIcon"><i class="far fa-trash-alt" data-toggle="modal" data-target="#delete-modal"></i></td></tr>'
	                                 +                                     '<tr><td class="rIconName">삭제하기</td></tr>';
	                        }else{
	                           value += '<tr>'
	                                 +                                 '<td class="rIcon"><i class="far fa-heart" data-toggle="modal" data-target="#sponsorship-modal"></i></td>'
	                                 +                              '</tr>'
	                                 +                              '<tr><td class="rIconName">후원하기</td></tr>'
	                                 +                              '<tr>'
	                                 +                                 '<td class="rIcon"><i class="far fa-thumbs-down" data-toggle="modal" data-target="#report-modal"></i></td>'
	                                 +                              '</tr>'
	                                 +                              '<tr><td class="rIconName">신고하기</td></tr>';
	                        }
	                        
	                     }else{
	                        value += '<tr onClick="loginAlert()"><td class="rIcon"><i class="far fa-heart"></i></td></tr>'
	                              +                        '<tr><td class="rIconName">후원하기</td></tr>'
	                              +                        '<tr onClick="loginAlert()"><td class="rIcon"><i class="far fa-thumbs-down"></i></td></tr>'
	                              +                        '<tr><td class="rIconName">신고하기</td></tr>';
	                     }
	                        
	                     value += '<tr><td></td></tr>'
	                           +               '</table>'
	                           +      '</div><!-- 우측 아이콘 옵션 끝 -->'
	                           +   '</div><!-- 답변 상세 영역 끝 -->'
	                           +'</div><!-- 원댓글 영역 끝 -->';
	                     
	                        // [Array.prototype.push()] 배열의 끝에 하나 이상의 요소를 추가하고, 새로운 배열 길이 반환
	                        repNo.push(list[i].repNo);
	                  }
	                  
	                  // html 메소드를 이용해 id가 해당 값인 요소 안에 리스트 출력
	                  $("#qnaBottom").html(value);
	                    //ToView2();
	               },error: function(){
	                  // 리스트 조회 실패 시
	                  console.log(" 댓글 리스트 조회용 ajax 통신 실패 ");
	               }
	            })
	         }

	         function ToView2(){
	              viewer3.setMarkdown(editor3.getHTML());
	           }
			</script><!-- 댓글 js 끝 -->


			<!-- 답변을 작성할 수 있는 영역(항상 보여짐) -->
			<div class="writeReply">
				<!-- 답변 작성 안내 -->
				<div class="replyGuide">
					<div class="replyGuide1"><b>답변 달기</b></div>
					<div class="replyGuide2">⭐ 답변 작성 시 유의사항 안내 
						<span class="tooltiptext">
							LIKE5의 질문에 답변해주셔서 감사합니다 👍<br>
							답변을 달기 전, 아래의 유의사항을 확인해주세요!<br><br>
							＊ 질문과 관련된 답변인지 확인해주세요<br>
							＊ 답변이 정확한 정보인지 확인해주세요<br>
							＊ 답변이 등록되면 수정이 불가능해요<br>
							＊ 내용에 오·탈자가 없는지 확인해주세요
						</span>
					</div>
					<div class="replyGuide3"></div>
				</div><!-- 답변 작성 안내 끝 -->

				<!-- 로그인한 회원 정보 영역 -->
				<div class="userInfo">
					<table>
						<tr class="loginUserInfo">
							<td class="tableBlank"></td>
							<td class="userInfo1"><i class="far fa-user-circle"></i></td>
							<c:choose>
								<c:when test="${!empty loginUser}">
									<td class="userInfo2">${ loginUser.nickName }</td>
								</c:when>
								<c:otherwise>
									<td class="userInfo2">GUEST</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</table>
				</div><!-- 답변자 정보 영역 끝 -->

				<!-- 답변 상세 영역 -->
				<div class="userWrite1">
				
				
					<c:choose>
						<c:when test="${!empty loginUser}">
							<div>
								<!-- api 구현 끝나면 style 지우기 -->
								<div id="editor2"></div>
							</div>
						</c:when>
						<c:otherwise>
							<div>
								<textarea rows="5" id="userReply1" placeholder=" 로그인 후 이용해주세요. " disabled></textarea>
							</div>
						</c:otherwise>
					</c:choose>
					<!-- 댓글 토스트 UI -->
					<script>
					   const Editor2 = toastui.Editor;
				       const editor2 = new Editor2({
				            el: document.querySelector('#editor2'),
				            height: '400px',
				            previewStyle: 'vertical',
				            initialValue: '소중한 답변 감사합니다 😁 \n답변 작성 후 수정이 불가능하니 유의사항을 꼭 확인해주세요!',
				            language: 'ko',
				        });
					</script>
					
				</div><!-- 답변 상세 영역 끝  -->

				<!-- 답변달기 관련 하단부 -->
				<div class="userWrite2">
					<c:if test="${!empty loginUser}">
						<button class="btn btn-danger" onclick="addReply();">답변달기</button>
					</c:if>
				</div><!-- 답변달기 버튼 끝 -->
			</div><!-- 답변달기 관련 하단부 끝 -->
		</div><!-- 답변을 작성할 수 있는 영역(항상 보여짐) 끝 -->
		
		<script>
	      function addReply(){
	    	 
	    	  var content = editor2.getHTML();
	    	  
	         // 공백, 빈문자열 유효성 검사
	         if(content != null){
	            $.ajax({
	               url: "insertReply.bo",
	               data: {
	                  boaNo: ${b.bno},
	                  repContent: content,
	                  memNo: '${ loginUser.memNo }'
	                  // repNo 추가하기
	               }, success: function(status){
	                  // 성공적으로 insert했을 경우 db 호출하여 리스트 갱신 후 value값 초기화
	                  if(status == "success"){
	                     selectReplyList();
	                     editor2.setHTML("소중한 답변 감사합니다 😁");
	                  }
	               }, error: function(){
	            	  alert(" 댓글 내용 작성 후 등록을 요청해주세요. ");
	                  console.log(" 원댓글 작성용 ajax 통신 실패  ");
	               }
	            })
	         }else{
	            //빈 문자열로 등록을 요청했을 경우
	            alert(" 댓글 내용 작성 후 등록을 요청해주세요. ");
	         }
	      }
	      </script>


		<!-- 신고하기 모달창 -->
		<form action="report.bo" method="post">
			<!-- 신고하기 insert 시 넘겨줄 값 -->
            <input type="hidden" name="mno" value="${ loginUser.memNo }">
    	   	<input type="hidden" name="refNo" value="${ b.bno }">
      		<input type="hidden" name="category" value="${ b.category }">
			
			<div class="modal fade" id="report-modal">
				<div class="modal-dialog modal-dialog-centered modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">🚨 <b>신고하기</b></h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="report-user">&nbsp;<b>${ b.nickname }</b>님을 신고하시겠어요?</div>
							<div class="modal-choice">
								<table>
									<tr>
										<td style="font-size: 14px; padding-right: 10px;"><b>사유선택 :</b></td>
										<td rowspan="2" style="font-size: 13px; padding-bottom: 18px;">
											&nbsp;여러 사유에 해당되는 경우,<br>&nbsp;대표 사유를 선택해주세요.
										</td>
									</tr>
									<tr><td rowspan="5"></td></tr>
									<tr>
										<td><input type="radio" id="a-option" name="reason" value="홍보성 게시글">
											<label for="a-option">홍보성 게시글</label></td>
									</tr>
									<tr>
										<td><input type="radio" id="b-option" name="reason" value="욕설 및 비방">
											<label for="b-option">욕설 및 비방</label></td>
									</tr>
									<tr>
										<td><input type="radio" id="c-option" name="reason" value="명예훼손 및 사생활 침해">
											<label for="c-option">명예훼손 및 사생활 침해</label></td>
									</tr>
									<tr>
										<td><input type="radio" id="d-option" name="reason" value="기타">
											<label for="d-option">기타</label></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-danger btn-sm">신고하기</button>
							<button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
		</form><!-- 신고하기 모달창 끝 -->


		<!-- 후원하기 모달창 -->
		<div class="modal fade" id="sponsorship-modal">      		
			<div class="modal-dialog modal-dialog-centered modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">💌 <b>후원하기</b></h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body" style="text-align: center;">
						<br>답변이 마음에 드셨다면<br>해당 작성자에게 후원할 수 있습니다.<br>후원하시겠어요?
						<br><br>
						<p style="font-size: 9px;">(OK 버튼 클릭 시 결제창으로 이동합니다.)</p>
					</div>
					<div class="modal-footer" style="justify-content: center;">
						<button type="button" id="payment" class="btn btn-danger btn-block">OK</button>
					</div>
				</div>
			</div>
		</div><!-- 후원하기 모달창 끝 -->
		
		<!-- 후원하기 insert 시 넘겨줄 값 -->
		<form id="sponForm" action="sponInsert.me" method="post">
            <input type="hidden" name="memNo" value="${ loginUser.memNo }">
            <input type="hidden" name="smemNo" value="${ b.mno }">
            <input type="hidden" name="sponCategory" value="1">
            <input type="hidden" name="refBoaNo" value="${ b.bno }">
		</form>
		
		<script>
	    // 아임포트 결제 js
		$("#payment").click(function(){
	        var IMP = window.IMP;
	        IMP.init('imp33726702');
	        
	        IMP.request_pay({
	            pg : 'html5_inicis',
	            pay_method : 'card',
	            merchant_uid : 'merchant_' + new Date().getTime(),
	            name : 'QnA 답변 후원하기',
	            amount : 1000,
	            buyer_email : '${ loginUser.email }',
	            buyer_name : '${ loginUser.memName }',
	            buyer_tel : '010-1234-5678'
	        }, function (rsp) {
       			console.log(rsp);       			
	    		if ( rsp.success ) {
	    	    	jQuery.ajax({
	    	    		url: "/payments/complete",
	    	    		type: 'POST',
	    	    		dataType: 'json',
	    	    		data: {
	    		    		imp_uid : rsp.imp_uid
	    	    		}
	                }).done(function(data) {
	                    if ( everythings_fine ) {
	                    	console.log(data);
	                    } else {
	                        alert(' 결제가 진행되지 않았습니다. 다시 시도해주세요. ');
	                    }
	                });
            		$("#sponForm").submit();
	            } else {
	                var msg = ' 결제에 실패하였습니다. ';
	                msg += ' \n 에러 원인 : ' + rsp.error_msg;
	
	                alert(msg);
	            }
        	});
		});
	    </script>


		<!-- 채택하기 모달창 -->
		<div class="modal fade" id="adoption-modal">
			<div class="modal-dialog modal-dialog-centered modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">👍 <b>채택하기</b></h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body" style="text-align: center;">
						<br>답변이 마음에 드셨다면<br>해당 답변을 채택할 수 있습니다.<br>채택하시겠어요?
						<br><br>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger btn-sm" id="repAdop">채택하기</button>
						<button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div><!-- 채택하기 모달창 끝 -->
		
		<script>
		$(document).on("click", "#adopModal", function(){
			// 댓글의 채택하기 클릭 시 해당 댓글의 댓글번호 가져와 repNo 변수에 담음
			repNo = ($(this).prev().val());
			
			// 모달 내의 채택하기 버튼 클릭 시 insert 실행
			document.getElementById("repAdop").onclick = function(){
				location.href="adoptionReply.bo?repNo=" + repNo;
			}
		});
		</script>
		
		
		
		<!-- 삭제하기 모달창 -->
		<div class="modal fade" id="delete-modal">
			<div class="modal-dialog modal-dialog-centered modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">🚫 <b>삭제하기</b></h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body" style="text-align: center;">
						<br>해당 글을 삭제하게되면<br>질문에 대한 답변을 받을 수 없어요😥<br>정말 삭제하시겠어요?
						<br><br>
						<p style="font-size: 9px;">(삭제하기 버튼 클릭 시 글이 삭제됩니다.)</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger btn-sm" onclick="postFormSubmit(2)">삭제하기</button>
						<button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div><!-- 삭제하기 모달창 끝 -->
		
		<!-- URL 공유 모달창 -->
		<div class="modal fade" id="url-modal">
			<div class="modal-dialog modal-dialog-centered modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">📢 <b>URL 공유하기</b></h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body" style="text-align: center;">
						<table style="width:100%; margin:20px 0 20px 0;">
							<tr>
								<td>
									<a id="kakao-link-btn" href="javascript:kakaoShare()">
										<img src="https://imgur.com/q3uqpyF.png" style="width:50px; height:50px; cursor:pointer;">
									</a>
								</td>
								<td>
									<a id="clip-btn" href="javascript:clipboardShare()">
										<i class="fas fa-share-alt" style="font-size:35px; cursor:pointer;"></i>
									</a>
								</td>
							</tr>
							<tr>
								<td style="font-size:13px; color:gray;"><br>카카오톡 공유하기</td>
								<td style="font-size:13px; color:gray;"><br>URL 복사하기</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div><!-- URL 공유 모달창 끝 -->
		
		<!-- kakao sdk 호출 -->
		<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
		
		<script>
		<%-- 카카오톡 공유하기 --%>
		// SDK를 초기화
		Kakao.init('fd6e08bcf943e50c7edc130fc7617ac2');
		
		// SDK 초기화 여부를 판단
		console.log(Kakao.isInitialized());
		
		function kakaoShare() {
		  Kakao.Link.sendDefault({
		    objectType: 'feed',
		    content: {
		      title: 'LIKE5',
		      description: '${ b.title }',
		      imageUrl: 'https://imgur.com/undefined.png',
		      link: {
		        mobileWebUrl: 'http://localhost:8008/like5/qnaDetail.bo?bno=' + '${ b.bno }',
		        webUrl: 'http://localhost:8008/like5/qnaDetail.bo?bno=' + '${ b.bno }',
		      },
		    },
		    buttons: [
		      {
		        title: '웹으로 보기',
		        link: {
		          mobileWebUrl: 'http://localhost:8008/like5/qnaDetail.bo?bno=' + '${ b.bno }',
		          webUrl: 'http://localhost:8008/like5/qnaDetail.bo?bno=' + '${ b.bno }',
		        },
		      },
		    ],
		    // 카카오톡 미설치 시 카카오톡 설치 경로이동
		    installTalk: true,
		  })
		}
		
		
		<%-- 로컬 URL 복사 --%>
		//  클립보드 복사하기
		function clipboardShare() {
	   	    var tmpTextarea = document.createElement('textarea');
           tmpTextarea.value = "http://localhost:8008/like5/qnaDetail.bo?bno=" + "${ b.bno }";
           
           tmpTextarea.setAttribute('readonly', '');
           tmpTextarea.style.position = 'absolute';
           tmpTextarea.style.left = '-9999px';
           document.body.appendChild(tmpTextarea);
           
           // 해당 element의 value를 시스템 함수를 호출하여 복사
           tmpTextarea.select();
           tmpTextarea.setSelectionRange(0, 9999);
           var successChk = document.execCommand('copy');
           
           document.body.removeChild(tmpTextarea);
           
           // 클립보드 성공여부 확인
           if(!successChk){
           		alert(" 클립보드 URL 복사에 실패하였습니다. ");
           } else {
           		alert(" 클립보드에 URL 복사가 완료되었습니다. ");
           }
		}
		</script>

	</div><!-- 전체를 감싸는 div 끝 -->


	<!-- 위로가기 아이콘 -->
	<a href="#header"><i class="fas fa-chevron-up" id="toTheTop">&nbsp;TOP</i></a>

	
	<!-- 푸터바 -->
	<jsp:include page="../../common/footer.jsp" />
</body>
</html>