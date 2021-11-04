<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Column</title>
    
  	<!-- colDetailView.css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/colDetailView.css" />   
  
 	<!--토스트 UI-->
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.css" />
    
    <!-- i'mport library -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
  
</head>
<body>

     <!--메뉴바-->
     <jsp:include page="../../common/header.jsp" />   
    
    <div class="innerOuter" style="margin-top:50px; padding-left:50px">
        <!--칼럼, 제목, 작성자 닉네임, 작성일, 조회수-->
        <div class="column-header">
            <div class="content-header">
                <h3><b>칼럼</b></h3><br>
                <div class="content-header-top">
                    <h4><b>${b.title}</b></h4>
                </div>
                <div class="content-header-bottom">
                    <div class="left-items">
                        <span>${b.nickname}   | </span>
                        <span>${b.enrollDate} |</span>
                        <span>조회수 ${b.count} </span>
                    </div>
                </div>
                <hr>
            </div>
        </div>
        <!--내용, 좋아요, 스크랩, 후원하기, 작성자 프로필, 수정, 삭제-->
        <div class="column-conetent"  style="width: 900px; height: 800px; ">
            <div style="height: 100%;width: 100%;">
                <div>
                	<div id="editor" style="display:none;">${b.content}</div>
                	<div id="viewer"></div>
                </div>
            </div>
            
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

		        function ToView()
		        {
		            viewer.setMarkdown(editor.getHTML());
		        };
		    
		    </script>
		    
		    
            <!--좋아요 스크랩 후원하기-->
            <!-- 로그인한 사용자만 버튼 요소 보여지게하기 -->
            <c:choose>
            	<c:when test="${!empty loginUser }">
           	   <div>
	                <div class="like-scrap-sponsorship" style="display: flex; margin-left: 40%; " >
	                    <div class="like" onclick="likeAndScrap(1);">
	                    	<c:choose>
	                    		<c:when test="${!empty likes}">
			                        <i id="selected-like" class="fas fa-thumbs-up fa-2x"></i>
	                    		</c:when>
	                    		<c:when test="${!empty scrap && !empty likes}">
	                    			 <i id="selected-like" class="fas fa-thumbs-up fa-2x"></i>
	                    		</c:when>
	                    		<c:otherwise>
			                        <i id="like" class="far fa-thumbs-up fa-2x" ></i>
			                        <i id="selected-like" class="fas fa-thumbs-up fa-2x test" style="display:none;"></i>
			                        <i id="like" class="fas fa-thumbs-up fa-2x test" style="display:none;"></i>
	                    		</c:otherwise>
	                        </c:choose>
	                        <div>좋아요</div>
	                    </div>
	                    <div class="scrap" onclick="likeAndScrap(2);">
	                    	<c:choose>
	                    		<c:when test="${!empty scrap}">
	                    			<i id="selected-scrap" class="fas fa-bookmark fa-2x"></i>
	                    		</c:when>
	                    		<c:when test="${!empty scrap && !empty likes}">
	                    			<i id="selected-scrap" class="fas fa-bookmark fa-2x"></i>
	                    		</c:when>
	                    		<c:otherwise>
	                       			 <i id="scrap" class="far fa-bookmark fa-2x"></i>
	                       			 <i id="selected-scrap" class="fas fa-bookmark fa-2x" style="display:none;"></i>
	                       			 <i id="scrap" class="fas fa-bookmark fa-2x" style="display:none;"></i>
                       			</c:otherwise>
	                        </c:choose>
	                        <div>스크랩</div>
	                    </div>
	                    <div class="sponsorship"> 
	                        <!--기본으로 보여지는 아이콘-->
	                        <!--후원하기 클릭시 변경되는 아이콘-->
	                        <c:choose>
		                        <c:when test="${!empty sponsor}">
			                        <i id="selected-sponsorship" class="fas fa-heart fa-2x" disabled onclick="alertSponsor();"></i>
			                        <a data-toggle="modal" data-target="#sponsorship-modal"><i id="sponsorship" class="far fa-heart fa-2x" style="display:none;"></i></a>
		                        </c:when>
		                        <c:when test="${empty sponsor}">
		                        	<i id="selected-sponsorship" class="fas fa-heart fa-2x" style="display:none;"></i>
			                        <a data-toggle="modal" data-target="#sponsorship-modal"><i id="sponsorship" class="far fa-heart fa-2x"></i></a>
		                        </c:when>
	                        </c:choose>
	                        <div>후원하기</div>
	                    </div>
	               	</div>
            	</div><br><hr>
            	</c:when>
            </c:choose>
            
            <script>
            
            //중복 후원 방지를 위한 alert
            function alertSponsor(){
            	alertify.alert("😉 이미 후원한 게시글입니다.");
            }
            
            </script>
            
            <!--후원하기 모달창-->
            <!-- The Modal -->
            <form  id="" action="" method="post" style="margin-top: 0px;" >
                <input type="hidden" id="" name="" value="${loginUser}" >
                <input type="hidden" id="" name="" value="${loginUser}" >
                        
                <div class="modal fade" id="sponsorship-modal">
                    <div class="modal-dialog modal-dialog-centered modal-sm">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                        <h4 class="modal-title"><b>💌후원하기</b></h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <!-- Modal body -->
                        <div class="modal-body" style="text-align: center;">
				                            답변이 마음에 드셨다면 <br>
				                            해당 작성자에게 후원할 수 있습니다.<br>
				                            후원하시겠어요?
                            <p style="font-size: 9px;">
                                (OK 버튼 클릭 시 결제창으로 이동합니다.)
                            </p>
                        </div>
                        <!-- Modal footer -->
                        <div class="modal-footer"  style="justify-content: center;">
                            <button type="button" id="payment" class="btn btn-danger btn-block">OK</button>
                        </div>
                    </div>
                    </div>
                </div>
            </form>
            
            <!-- 후원하기 insert 시 넘겨줄 값 -->
			<form id="sponForm" action="sponInsert.me" method="post">
	            <input type="hidden" name="memNo" value="${ loginUser.memNo }">
	            <input type="hidden" name="smemNo" value="${ b.mno }">
	            <input type="hidden" name="sponCategory" value="2">
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
	    	            name : '칼럼 게시글 후원하기',
	    	            amount : 100,
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


                // 1 = 좋아요 | 2 = 스크랩
                function likeAndScrap(num){
                	if(num == 1){
                		$("#like").click(function(){
                			// 좋아요 활성화 버튼 클릭시 like 테이블에 insert 
                    		$.ajax({
                    			url:"likeAndScrap.bo"
                    			,data:{bno:${b.bno}
                    				 ,mno:${loginUser.memNo}
                    				 ,condition:"like"
                    				 }
                    			,success:function(status){
                    				if(status=="success"){
                    					alertify.alert("좋아요 성공!🎉");
                    					$('#selected-like').css('display','block');
                    					$('#like').css('display','none');
                    				}
                    			}
                    		})
                		})
                		
                		// 좋아요 비활성화 버튼시 like 테이블에 delete
                		$("#selected-like").click(function(){
                			$.ajax({
                    			url:"UnlikeAndUnScrap.bo"
                    			,data:{bno:${b.bno}
                    				 ,mno:${loginUser.memNo}
                    				 ,condition:"like"
                    				 }
                    			,success:function(status){
                    				if(status=="success"){
                    					alertify.alert("좋아요 해제😅");
                    					$('#like').css('display','block');
                    					$('#selected-like').css('display','none');
                    				}
                    			}
                    		})
                			
                		})
                	}
                	
                	if(num == 2){
                		// 스크랩 활성화 버튼 클릭시 scrap 테이블에 insert 
                		$("#scrap").click(function(){
	                		
	                		$.ajax({
	                			url:"likeAndScrap.bo"
	                			,data:{bno:${b.bno}
	                				 ,mno:${loginUser.memNo}
	                				 ,condition:"scrap"
	                				 }
	                			,success:function(status){
	                				if(status=="success"){
	                					alertify.alert("스크랩 성공!🎉");
	                				   $('#selected-scrap').css('display','block');
	                				   $('#scrap').css('display','none');
	                				}
	                			}
	                		})
                		})
                		// 스크랩 비활성화 버튼시 scrap 테이블에 delete
                		$("#selected-scrap").click(function(){
                			$.ajax({
	                			url:"UnlikeAndUnScrap.bo"
	                			,data:{bno:${b.bno}
	                				 ,mno:${loginUser.memNo}
	                				 ,condition:"scrap"
	                				 }
	                			,success:function(status){
	                				if(status=="success"){
	                					alertify.alert("스크랩 해제 😅");
	                				   $('#selected-scrap').css('display','none');
	                				   $('#scrap').css('display','block');
	                				}
	                			}
	                		})
                		})
                	}
                }
            </script>
            
            <!-- 좋아요와 스크랩  -->
          	<form id="insertForm" action="" method="post">
				<input type="hidden" name="bno" value="${b.bno}">
				<input type="hidden" name="mno" value="${loginUser.memNo}">
				<input type="hidden" name="condition" value="">
			</form>


            <!--프로필 이미지 닉네임 / 수정 / 삭제 -->
            <div class="columnWriter"  style="display: flex;">
                
                <!--프로필이미지-->
                <div class="user-img">
                    <i class="far fa-user fa-2x"></i>
                </div>

                <!--닉네임-->
                <div class="user"style="line-height: 250%;">
                    <p><b>${b.nickname}</b></p>
                </div>
                
                <!--로그인한 사용자에게만 보여지는 아이콘-->
                <c:choose>
                	<c:when test="${loginUser.memNo eq b.mno}">
	               	     <div style="height: 30px; margin-left: 65%;"  >
	                    	<button class="btn btn-outline-danger btn-sm" onclick="postFormSubmit(1)">수정하기</button>
	                   		<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#delete-modal" >삭제하기</button>
	               		</div> 
                	</c:when>
                </c:choose>

                <!--삭제하기 모달창-->
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
                                   <div class="modal-content" style="border:1px solid grey; width: 100%; height:40px ;border-radius: 5px;">
                                       <div >
                                           <div align="center" style="line-height:100%; margin-top:5px;">
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
        </div>         
      
      
      
             <!-- 필요한 키값 숨겨서 보내기--> 
            <form id="postFormSubmit" action="" method="post">
                <input type="hidden" name="bno" value="${b.bno}">
				<input type="hidden" name="imgPath" value="${b.imgPath}">
				<input type="hidden" name="category" value="칼럼">
            </form>
      		<!--선택된 요소에 액션값 부여하고, 바로 submit 시키기-->     
              <script>
	               function postFormSubmit(num){
	                   if(num==1){ // 수정하기
	                       $("#postFormSubmit").attr("action","updateForm.bo").submit();
	                   }else{ // 삭제하기
	                       $("#postFormSubmit").attr("action","delete.bo").submit();
	                   }
	               }
              </script>
	
	        <!--관심 있을 만한 컬럼-->
	        <div class="column-footer" style="margin-top: 300px; margin-bottom:50px">
	            <div style="margin-left: 10px; margin-bottom: 30px;">
	                <h4><b>관심 있을 만한 칼럼</b></h4>
	            </div>
	            <div id="likeCountTop4"></div>
	            <!--좋아요 수 TOP 4 썸네일 조회하기-->
	        </div>   
    </div>
    
    <script>
    
 		// 좋아요 가장 많은 Top4 게시글 조회로 이동
	   $(function(){
			topBoardList();
	
			$(document).on("click",".thumbnail",function(){
				location.href="colDetail.bo?bno="+$(this).children(".col-bno").val()+"&mno="+$(this).children(".mno").val();
			})
	
		})	
    	
    	// 좋아요 가장 많은 Top4 게시글 조회
    	function topBoardList(){
    		$.ajax({
    			url:"columnTop4.bo",
    			success:function(list){
    				var value=""
    				// 비회원이 게시글 클릭했을 경우 변수에 담아서 mno=0으로 보내기
   					var nUser = ${empty loginUser};
					
   					for(var i in list){
    					value+=
							'<div class="thumbnail">'
						   +   '<input type="hidden" class="mno" value="';
							if(nUser == true){
								value+= '0">';
							}else{
								value+= '${loginUser.memNo}">';
							}
						   value+=
						    	'<input type="hidden" class="col-bno" value="'+list[i].bno+'">'
		    	           +     '<div>'
		    	           +         '<img src="';
		    	           
		    	           if(list[i].imgPath == null){
		    	        	   value+="${pageContext.request.contextPath}/resources/images/common/default-img.jpg";
		    	           }else{
		    	        	   value+= list[i].imgPath;
		    	           }
		    	           value+= 
		    	           '" style="width:400px; height: 300px;">'
		    	           +         '<div style="margin-top: 10px;">'+'<b>'+ list[i].title + '</b>'+'</div>'
		    	           +     '</div>'
		    	           + '</div>';
    				}
    				$("#likeCountTop4").html(value);
    			}, error:function(){
    				console.log("AJAX 통신 실패");
    			}
    		})
    	}
    </script>

	<!--푸터바-->
	<jsp:include page="../../common/footer.jsp" />


    
</body>
</html>