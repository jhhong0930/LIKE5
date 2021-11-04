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
    
<!-- comEnrollForm.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/comEnrollForm.css" />    

</head>
<body>
	 
	 <!--메뉴바-->
    <jsp:include page="../../common/header.jsp" /> 

    <div class="innerOuter"style="margin-top:50px;padding-left:50px">
        <div class="flex-box">
            <h2><b>커뮤니티</b></h2>
            <h6><b>질문은 QnA게시판을 이용해주세요.</b> </h6>
            <hr>
        </div>

        <form action="update.bo" method="post" enctype="multipart/form-data">
        	<input type="hidden" value="${b.bno}" name="bno">
            <!--카테고리 시작-->
            <!--작성자 아이디, 카테고리, 제목, 내용, 첨부파일-->
            <div class="community-header"> 
                <div class="sidebar-item-wrapper" >
                    <div class="category-tag-header-wrapper" style="margin-top: 10px; padding-top: 10px;" >
                        <h6 class="item-header"><b>카테고리 📚</b></h6>
                        <select class="selectpicker radius" name="category">
                            <option value="일상">📕일상</option>
                            <option value="스터디모집">📕스터디모집</option>
                        </select>
                    </div>
                </div>
            </div>
            <br>

            <div class="content-header">
                <div class="form-group">
                    <label for="usr"><b>제목</b></label>
                    <input type="text" class="form-control" id="content-title" name="title"  placeholder="${b.title}">
                    <div id="counting-title" style="float: right; font-size: 11px"></div>
                </div>
            </div>

            <div class="content-body">
                <div class="form-group">
                    <label for="comment"><b>내용</b></label>
                    <textarea class="form-control" id="comment" name="content" rows="10"  style="resize: none;" >${b.content}</textarea>
                </div>
            </div>
            <div class="file-upload" style="padding: 0px;">
            
                <div class="image-upload-wrap">
                <input class="file-upload-input"  name="reupfile" type='file' onchange="readURL(this);" accept="image/*" />
                <div class="drag-text">
                    <p>업로드하고 싶은 파일을 드래그 해보세요😜</p>
                </div>
                </div>

                <div class="file-upload-content">
	                <c:choose>
	                	<c:when test="${!empty b.imgPath}">
	                		<img class="file-upload-image" src="${b.imgPath}" alt="your image" />
	                	</c:when>
	                	<c:otherwise>
			                <img class="file-upload-image" src="#" alt="your image" />
	                	</c:otherwise>
	                </c:choose>
	                <div class="image-title-wrap">
	                    <button type="button" onclick="removeUpload()" class="remove-image"><span class="image-title"></span>를 수정하시겠어요?</button>
	                </div>
                </div>
            </div>

            <div class="content-footer">
                <div class="container-fluid" style="background-color: rgba(224, 224, 224, 0.3);">
                        Like5에 멋진 글을 작성해주셔서 감사드립니다 🧡<br>
                        청결한 게시판을 위해 
                        욕설이나 비방, 모욕, 선정성이 존재하는 사진이나 게시글은 업로드하지 말아주세요.
                </div>
            </div>
            <br><br>

            <div id="comEnrollbtn" style="display: flex; justify-content: space-between; margin-bottom:50px;" >
                <button type="reset" class="btn btn-outline-danger">취소</button>
                <button type="submit" class="btn btn-danger" disabled>등록</button>
            </div>
        </form>    

        <script>


            /*커뮤니티-제목-글자수 실시간 카운팅*/
            $('#content-title').keyup(function(e){
                var title = $(this).val();

                //공백제거
                if(title.trim() != 0){
                    $('#counting-title').html(title.length+" / 49");    //글자수 실시간 카운팅
                }else{
                	alertify.alert("공백이 입력되었어요 😊 다시 입력해주세요 ");
                    $('#counting-title').html(''); 
                }
                if (title.length > 49){
                	alertify.alert("최대 49자까지 입력 가능합니다.");
                    $(this).val(title.substring(0, 49));
                    $('#counting-title').html("49 / 49");
                }
            });
            
            // 제목 글자수 제한 (5글자 이상에만 작성 버튼 활성화)
            $(function(){
            	
            	var $titleInput = $("#content-title");
            	
            	$titleInput.keyup(function(){
            		if($titleInput.val().length>=5){
            			$("#comEnrollbtn :submit").attr("disabled",false);
            		}
            	})
            	
            });
            

            // 첨부파일 업로드
            function readURL(input) {
	            if (input.files && input.files[0]) {
	
	                var reader = new FileReader();
	
	                reader.onload = function(e) {
	                $('.image-upload-wrap').hide();
	
	                $('.file-upload-image').attr('src', e.target.result);
	                $('.file-upload-content').show();
	
	                $('.image-title').html(input.files[0].name);
	                };
	                reader.readAsDataURL(input.files[0]);
	            } else {
	                removeUpload();
	            }
            }
            
            // 업로드한 파일 수정 = 제거
            function removeUpload() {
	            $('.file-upload-input').replaceWith($('.file-upload-input').clone());
	            $('.file-upload-content').hide();
	            $('.image-upload-wrap').show();
            }
            
            $('.image-upload-wrap').bind('dragover', function () {
                    $('.image-upload-wrap').addClass('image-dropping');
                });
                $('.image-upload-wrap').bind('dragleave', function () {
                    $('.image-upload-wrap').removeClass('image-dropping');
            });

            // 작성 시 입력된 카테고리 표시 (일상 or스터디모집)
            $(function(){
          		if("${b.category}" != ""){
          			$("option[value=${b.category}]").attr("selected",true);
          		}
          		
          		// 기존 첨부파일이 있었을 경우 해당 이미지 표시
          		if("${b.imgPath}"!=""){
          			
          			 $('.image-upload-wrap').hide();
                 	
 	                $('.file-upload-image').attr('src',"${b.imgPath}");
 	                $('.file-upload-content').show();
 	
 	                $('.image-title').html("해당 게시글(을)");
          		}
          	})
        </script>
    </div>
    
    <!--푸터바-->
	<jsp:include page="../../common/footer.jsp" />

</body>
</html>