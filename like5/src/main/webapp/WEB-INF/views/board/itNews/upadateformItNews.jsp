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
            <h2><b>IT NEWS</b></h2>
            <hr>
        </div>

        <form id="" action="upadateItNews.bo" method="post">
        <input type="hidden" value="${b.bno}" name="bno" >
       		<c:choose>
            	<c:when test="${ b.category eq '컨퍼런스'}">
                	<select name="category" id="">
		                <option value="컨퍼런스" selected>컨퍼런스</option>
		                <option value="IT트렌드">IT트렌드</option>
		            </select>
            	</c:when>
            	<c:when test="${ b.category eq 'IT트렌드'}">
                	<select name="category" id="">
		                <option value="컨퍼런스">컨퍼런스</option>
		                <option value="IT트렌드" selected>IT트렌드</option>
		            </select>
            	</c:when>
            </c:choose>
       		
            <br>
            <div class="content-header">
                <div class="form-group">
                    <label for="content-title"><b>제목</b></label>
                    <input type="text" class="form-control" id="content-title" name="title" value="${ b.title }"  placeholder="5글자 이상을 입력해주세요.">
                    <div id="counting-title" style="float: right; font-size: 11px"></div>
                </div>
            </div>

            <div class="content-body">
                <div class="form-group">
                    <label for="content-content"><b>내용</b></label>
                    <textarea class="form-control" id="content-content" name="content" rows="10"  style="resize: none;" >${ b.content }</textarea>
                </div>
            </div>

            <br><br>

            <div style="display: flex;  justify-content: space-between; margin-bottom:50px;"  >
                <button type="reset" class="btn btn-outline-danger">취소</button>
                <button type="submit" class="btn btn-danger">수정하기</button>
            </div>
        </form>    

        <script>


            /*글자수 실시간 카운팅*/
            $('#content-title').keyup(function(e){
                var title = $(this).val();

                //공백제거
                if(title.trim() != 0){
                    $('#counting-title').html(title.length+" / 49");    //글자수 실시간 카운팅
                }else{
                    alert("공백이 입력되었어요 😊 다시 입력해주세요 ");
                    $('#counting-title').html(''); 
                }
                
                if (title.length > 49){
                    alert("최대 49자까지 입력 가능합니다.");
                    $(this).val(title.substring(0, 49));
                    $('#counting-title').html("49 / 49");
                }
            });
            
            
            $('#content-content').keyup(function(e){
                var content = $(this).val();
                
                if (content.length > 1000){
                    alert("최대 1000자까지 입력 가능합니다.");
                    $(this).val(title.substring(0, 1000));
                    $('#counting-content').html("1000 / 1000");
                }
            });
            

        </script>

    </div>
    
    <br><br><br><br><br><br><br>
    
    <!--푸터바-->
	<jsp:include page="../../common/footer.jsp" />

</body>
</html>