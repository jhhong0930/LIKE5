<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Community</title>
  
<!-- comDetailView.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/comDetailView.css" />   
 
</head>
<body>

    <!--메뉴바-->
    <jsp:include page="../../common/header.jsp" />
    
    <div class="innerOuter" style="margin-top:50px;padding-left:50px">
        <!--댓글창까지 전체 감싸는 div-->
        <div class="talk-main-col">
            <div class="content-wrapper">
                <div class="TalkContentHeaderModule">
                    <div>
                        <h3><b>커뮤니티</b></h3><br>
                        <div class="content-header">
                            <div class="content-header-top">
                                <h4><b>${b.title}</b></h4>
                            </div>
                            <div class="content-header-bottom">
                                <div class="left-items">
                                    <span>${b.category} | </span>
                                    <span>${b.enrollDate} |</span>
                                    <span>${b.nickname}</span>
                                </div>
                                <div class="rigth-items">
                                    <span>조회 ${b.count }  </span>
                                    <c:choose>
                                    	<c:when test="${!empty loginUser }">
                                    	<span><a href="" class="aTags" data-toggle="modal" data-target="#report-modal"> | 🚨신고</a></span>
                                		</c:when>
                                	</c:choose>
                                </div>
                            </div>
                            <hr>
                        </div>
                        <!-- 첨부파일 유무 조건식으로 검사하기 -->
                        <div class="main-content" style="height:100%;">
                           <c:choose>
                       		<c:when test="${!empty b.imgPath}">
								<div>
									<img src="${b.imgPath}" style="width:300px;height:300px;">
								</div>
								${b.content}
                       		</c:when>
                       		<c:otherwise>
                       			<div style="height:500px">${b.content}</div>
                       		</c:otherwise>
                       		</c:choose>
                        </div>
                        
                        <!--글 작성자에게만 보여지는 수정 및 삭제 버튼-->
                        <c:choose>
                        	<c:when test="${loginUser.memNo eq b.mno}">
                        		<div class="content-footer" align="center">
	                           	 	<button type="button" class="btn btn-outline-danger btn-sm" onclick="postFormSubmit(1)">수정</button>
	                            	<button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#delete-modal" >삭제</button>
	                        	</div>
                        	</c:when>
                        </c:choose>
                        <hr>
                    </div>
                </div>
            </div>
            
            <!-- 수정/삭제시 필요한 값들을 form에 담아 원하는 url로 전송 -->
            <form id="postForm" action="" method="post">
				<input type="hidden" name="bno" value="${b.bno}">
				<input type="hidden" name="imgPath" value="${b.imgPath}">
				<input type="hidden" name="category" value="커뮤니티">
			</form>
					
			<script>
				function postFormSubmit(num){
					if(num==1){ 
						// 수정하기
						$("#postForm").attr("action","updateForm.bo").submit();
					}else{ // 삭제하기
						$("#postForm").attr("action","delete.bo").submit();
					}
				}
			</script>
            
            
           	<!-- 삭제하기 모달창 -->
               <div class="container">
                   <!-- The Modal -->
                   <div class="modal fade" id="delete-modal">
                       <div class="modal-dialog modal-dialog-centered modal-sm">
                           <div class="modal-content">
                           
                               <!-- Modal Header -->
                               <div class="modal-header" style="background-color: rgba(224, 224, 224, 0.24);">
                                   <h4 class="modal-title">🧺삭제하기</h4>
                                   <button type="button" class="close" data-dismiss="modal">&times;</button>
                               </div>
                               
                               <!-- Modal body -->
                               <div class="modal-body">
                                  		<p align="center"><b>${b.nickname}</b>님 안녕하세요!</p>
                                   <div class="modal-content" style="border:1px solid grey;width: 100%;height: 100%; border-radius: 5px;">
                                       <div>
                                           <div align="center">
                                           	삭제 후에는 복구가 불가능합니다.<br>
                                           	정말로 삭제하시겠어요? 🙃
                                           </div>
                                       </div>
                                   </div>
                               </div>
                               <!-- Modal footer -->
                               <div class="modal-footer" style="justify-content: center;">
                                   <div>
                                       <button type="button" class="btn btn-danger btn-sm" onclick="postFormSubmit(2)">삭제하기</button>
                                       <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">취소</button>
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>
            
		


            <form action="report.bo" method="post" style="margin-top: 0px;" >
                <!--신고하기 모달창-->
                <div class="container">
                    <!-- The Modal -->
                    <div class="modal fade" id="report-modal">
	                    <input type="hidden" name="mno" value="${loginUser.memNo}">
	            	   	<input type="hidden" name="refNo" value="${b.bno}">
	              		<input type="hidden" name="category" value="${b.category}">
                        <div class="modal-dialog modal-dialog-centered modal-sm">
                            <div class="modal-content">
                            
                                <!-- Modal Header -->
                                <div class="modal-header" style="background-color: rgba(224, 224, 224, 0.24);">
                                    <h4 class="modal-title">🚨신고하기</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                
                                <!-- Modal body -->
                                <div class="modal-body">
                                    <div class="modal-content" style="border:1px solid grey;width: 100%;height: 100%; border-radius: 5px;">
                                        <div>
                                            <b><span style="font-size: 15px;">사유 선택 : </span></b>
                                            <span>여러 사유에 해당되는 경우,</span>
                                            <div style="margin-left: 80px;">
                                                <span>대표적인 사유 1개를 선택해주세요.</span><br>
                                                
                                                <br>     
                                                <input type="radio" id="a-option" name="reason"  value="홍보성 게시글">
                                                <label for="a-option">홍보성 게시글</label>
                                                <br>

                                                <input type="radio" id="b-option" name="reason"  value="욕설 및 비방">
                                                <label for="b-option">욕설 및 비방</label>
                                                <br>                               

                                                <input type="radio" id="c-option" name="reason" value="명예훼손 및 사생활 침해">
                                                <label for="c-option">명예훼손 및 사생활 침해</label>
                                                <br> 
                                                
                                                <input type="radio" id="d-option" name="reason" value="기타">
                                                <label for="d-option" >기타</label>
                                                <br>

                                            </div>
                                        </div>
                                        <div style="background-color: pink;">
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Modal footer -->
                                <div class="modal-footer" style="justify-content: center;">
                                    <div>
                                        <button type="submit" class="btn btn-danger btn-sm">신고하기</button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">취소</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>   
            
            <!--댓글 전체 감싸는 영역-->
            <div class="talk-commentbox-wrapper" style="margin-bottom:50px">
                <div class="talk-comment-count-box"></div>
                <div class="talk-newcomment-box">
                    <div class="auto-heigth" style="box-sizing: border-box; height: auto;">
                         <div class="form-group">
                         <!-- 로그인한 사용자만 작성 가능-->
                         <label for="comment"><h5><b><span id="rcount"></span>개의 댓글</h5></b></label>
							<c:choose>
								<c:when test="${!empty loginUser}">
								 	<textarea class="form-control" rows="5" id="comment" style="resize:none"></textarea>
									<button type="button" class="btn-danger btn btn-sm"  style="float:right; margin-top: 10px;" onclick="insertReply();">댓글 작성</button>
								</c:when>
								<c:otherwise>
									 <textarea class="form-control" rows="5" style="resize:none" placeholder="로그인 후 이용 가능한 서비스입니다." disabled></textarea>
								</c:otherwise>
							</c:choose>
						</div>
                    </div>
                </div>
                <div class="talk-comment-lists">
                    <div class="TalkCommentModule" >
                        <div class="comment-box-wrapper">
		
							
							<div id="replyResult"></div>
							<div id="answerComment"></div>
							
                            <script >
                            
                            	// 댓글 조회
                            	$(function(){
                            		selectReplyList();
                            	})
						       	
                            	// Ajax로 댓글 조회
                            	function selectReplyList(){

                            		var repNo=[];
                            		
                            		$.ajax({
                            			url:"rlist.bo",
                            			data:{bno:${b.bno}},
                            			
                            			// 통신 성공했을 때
                            			success:function(list){
                            				
                            				$("#rcount").text(list.length);
                            				
                            				var value="";
                            				// reflevel이 1일 경우 댓글 | 2일경우 대댓글 
                            				for(var i in list){
                            					// 댓글 조회
                            					if(list[i].refLevel == 1){

                            						  value += 
                                                     '<div class="comment-wrapper_value" style="margin-top:50px">'
                                                    +  '<div class="comment-info">'
                                                    +      '<div class="info-wrapper">'
                                                    +          '<div class="user-info">'
                                                    +              '<div class="user-img">'
                                                    +                  '<i class="far fa-user fa-2x">'+'</i>'
                                                    +              '</div>'
                                                    +              '<div class="user-info" style="display: inline-block;width: 90%;">'
                                                    +                  '<div class="test">' 
                                                    +                      '<span>'+'<a href="" class="aTags">' + list[i].nickname + '</a>'+'</span>'
                                                    +                      '<span style="float: right;">'+'<a href="" class="aTags report" data-toggle="modal" data-target="#report-modal">'+'<img src="">'+"🚨신고"+'</a>'+'</span>'
                                                    +                   '</div>'
                                                    +                  '<div>' + list[i].repEnrollDate + '</div>'
                                                    +              '</div>'
                                                    +      	'</div>'
                                                    +         '<div class="comment-content">'
                                                    +              '<div>'+list[i].repContent+'</div>'
                                                    +          '</div>'
                                                    +      '</div>'
                                                    +  '</div>'
                                                    + '</div>'
                                                    + '<div class="comment-plus-icon-wrapper" align="center">'
                                                    +    '<div class="container">'
                                                    +        '<a href="#collapse'+list[i].repNo+'"class="btn btn-outline-secondary comments" data-toggle="collapse" style="margin-bottom: 10px;">'+"대댓글 달기"+'</a>'
                                                    +        '<div id="collapse'+list[i].repNo+'"class="collapse">'
                                                    +            '<div class="talk-newcomment-box">'
                                                    +                '<div class="auto-heigth" style="box-sizing: border-box; height: auto;">'
                                                    +                    '<textarea class="form-control" rows="5" id="insertReplies" style="resize:none">'+'</textarea>'
                                                    +					 '<input type="hidden" value="'+list[i].repNo+'">'
                                                    +                    '<button type="button" class="btn-danger btn btn-sm insert-comments" style="float:right; margin-top: 10px;">'+"대댓글 작성"+'</button>'
                                                    +                '</div>'
                                                    +            '</div>'
                                                    +        '</div>'
                                                    +   '</div>'
                                                    +'</div>'
                                                   
                                                	$("#replyResult").html(value);	
                                                    
                            						  repNo.push(list[i].repNo);
                                                    
                            					}else{
	                            						
	                           						 if(repNo.indexOf(list[i].refRepNo)!= -1){
	                            						value +=
	                            						'<div class="comments-wrapper_value" >' 
	                                                   + '<div class="comment-info">'
	                                                   +    '<div class="info-wrapper">'
	                                                   +         '<div class="user-info">'
	                                                   +            '<div class="user-img">'
	                                                   +                '<i class="far fa-user fa-2x"></i>'
	                                                   +             '</div>'
	                                                   +            '<div class="user-info" style="display: inline-block; width: 90%;">'
	                                                   +               ' <span>'+'<a href="" class="aTags">'+list[i].nickname+'</a>'+'</span>'
	                                                   +                 '<span style="float: right;">'+'<a href="" class="aTags report-re" data-toggle="modal" data-target="#report-modal"><img src="">'+'🚨신고'+'</a>'+'</span>'
	                                                   +                 '<div>'+list[i].repEnrollDate +'</div>'
	                                                   +             '</div>'
	                                                   +         '</div>'
	                                                   +         '<div class="comment-content">'
	                                                   +             '<div>'+list[i].repContent+'</div>'
	                                                   +			 '<input id="report-re" type="hidden" value="'+list[i].repNo+'">'
	                                                   +         '</div>'
	                                                   +     '</div>'
	                                                   + '</div>'
	                                                	+'</div>'
		                            						
	                                                	$("#replyResult").html(value);	
	                            					}
                            					}
                            				}
                            			}
                            		})
                            		}
                            	
	                            	// Ajax 댓글 작성하기
	                            	function insertReply(){
	                            		
	                            		if($("#comment").val().trim().length != 0){
	                            			// 댓글일때
	                            				$.ajax({
	                                				url:"insertReply.bo",
	                                				data:{
	                                					boaNo :${b.bno}
	                                					,repContent : $("#comment").val()
	                                					,memNo : '${loginUser.memNo}'
	                                				},success:function(status){
	                                					
	                        	      					if(status == "success"){
	                        	      						//  전체 댓글 리스트 갱신
	                        	      						selectReplyList();
	                        	      						// 작성해놓은 댓글 삭제
	                        	      						$("#comment").val("");
	                        	      					}
	                                				}
	                                			})
	                            		}
	                            	}
	                            	
	                               // Ajax 대댓글 작성하기
	                            	function insertReplies(repNo){
	                            		if($("#insertReplies").val().trim().length != 0){
	                            				// 대댓글일때
	                            				$.ajax({
	                                				url:"insertReplies.bo",
	                                				data:{
	                                					boaNo : ${b.bno}
	                                					,repContent : $("#insertReplies").val()
	                                					,memNo : '${loginUser.memNo}'
	                                					,refRepNo : repNo
	                                				},success:function(status){
	                        	      					if(status == "success"){
	                        	      						// 전체 댓글 리스트 갱신
	                        	      						selectReplyList();
	                        	      						// 작성해놓은 대댓글 삭제
	                        	      						$("#insertReplies").val("");
	                        	      					}
	                                				}
	                                			})
	                            		}
	                            	}
	                               
	                         	   /*대댓글 문구 변경*/
	                           	  $(document).on("click", ".comments", function(){
	                           		  var a = $(this).text();
	                           		  if(a=='취소하기'){
	                           			  $(this).text("대댓글 달기");
	                           		  }else{
	                           			  $(this).text("취소하기");
	                           		  }
	                             	 });
	                          	   
	                          	   /*원댓글 번호를 대댓글의 참조 댓글 번호로 가져오는 구문*/
	                           	   $(document).on("click",".insert-comments",function(){
	                          	      insertReplies($(this).prev().val());
	                          	   });
	                          	  
	                          	  /*신고시 해당 댓글 번호가 insert 됨*/
	                           	  $(document).on("click",".report",function(){
	                          	     $("#report-modal").children().eq(1).val($(".insert-comments").prev().val());
	                          	   });
	                          	  
	                           	  /*신고시 해당 대댓글 번호가 insert 됨*/
	                           	  $(document).on("click",".report-re",function(){
	                          	     $("#report-modal").children().eq(1).val($("#report-re").val());
	                          	   });
	                          	   
	                          	   
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    
	<!--푸터바-->
	<jsp:include page="../../common/footer.jsp" />

</body>
</html>