<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>
        
        div{
            box-sizing:border-box;
            
            font-family: 'Noto Sans KR', sans-serif;
        }
        #body{width:1200px; height:900px; margin: auto;}
        #body>div{float: left;}

        #post{width: 100%; height: 78%; float: left;}
        #title{margin-left: 180px; width: 100%; height: 40px;  float: left;}
        #title>div{float: left;}
        #line{width: 900px; height: 2px; background-color: lightgrey; margin-left: 180px; float: left;}
        
        

    </style>
</head>
<body>
	
	<jsp:include page="../../common/header.jsp" />
	<br><br><br><br><br>

    <div id="body">
      
            <div id="post">
                    <div id="title">
                      <div>
                        <h3>${ b.title }</h3>
                      </div>
                      <c:choose>
	                    		<c:when test="${ loginUser.userStatus eq 'Y' }">
			                        <button type="button" data-toggle="modal" data-target="#MyModal" style=" float: right; border: 2px solid rgb(220, 53, 69); background-color:rgb(220, 53, 69); color: white; border-radius:3px; margin-right: 300px; margin-top:10px;">삭제하기</button>
			                        <button type="button" onclick="location.href='upadateFormItNews.bo?bno=${ b.bno }'" style=" float: right; border: 2px solid rgb(220, 53, 69); background-color: white; color: rgb(220, 53, 69); border-radius:3px; margin-top:10px;">수정하기</button>
		                        </c:when>
                        </c:choose>
                    </div>
                    <div id="line"></div>
                    <div style="width: 900px; height: 600px; margin-left: 180px; margin-top: 10px;">
			        	<fmt:formatDate pattern="yyyy.MM.dd" value="${ b.enrollDate }"/><br><br><br>
			            ${ b.content }

                  </div>
                  <div id="line"></div>
            </div>
        </div>
        
        <!-- The Modal -->
        <div class="modal fade" id="MyModal">
            <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                
                <!-- Modal body -->
                <div class="modal-body">
                  <div  style="margin-left:160px;">
                    	정말 삭제하시겠습니까?
                  </div>
                </div>
                
                <!-- Modal footer -->
                <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" style="border: 2px solid rgb(220, 53, 69); background-color: white; color: rgb(220, 53, 69);">취소</button>
                <button type="button" onclick="location.href='deleteItnews.bo?bno=${ b.bno }'" class="btn btn-secondary" data-dismiss="modal" style="background-color: rgb(220, 53, 69); color: white;">삭제하기</button>
                </div>
                
            </div>
            </div>
        </div>
        
        <jsp:include page="../../common/footer.jsp" />
        
</body>
</html>