<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: jhhon
  Date: 2021-07-29
  Time: 오후 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .main-content{
            display: flex;
            justify-content: center;
        }
        .main-content a{
            text-decoration: none;
            color: rgb(220, 53, 69);
        }
        .main-content i{
            font-size: 70px;
            margin: 0 10px;
        }
        .blank{
            width: 180px;
        }
        .question{
            width:800px;
            height:40px;
            padding-left: 10px;
            line-height:40px;
            border-radius:10px;
            border:1px solid rgb(220, 53, 69);
            cursor:pointer;
        }
        .answer{
            border:1px solid lightgray;
            width:800px;
            height:40px;
            margin-top:5px;
            border-radius:10px;
            padding:10px;
            box-sizing:border-box;
            display:none;
        }
        .question, .answer{
            margin-bottom: 5px;
            text-align: left;
        }
        .answer a{
            text-decoration: none;
            color: rgb(220, 53, 69);
        }
        .answer a:hover{
            text-decoration: none;
            color: rgb(220, 53, 69);
        }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<br><br><br>

<div class="innerOuter">

    <div class="main-content">

        <a href="about.ad"><i class="fas fa-home"></i></a>
        <div>
            <b style="color: rgb(220, 53, 69);">About</b><br>
            LIKE5의 다양한 기능과<br>
            각 게시판에 대해서 알아보세요
        </div>

        <span class="blank"></span>

        <a href="faq.ad"><i class="fas fa-info"></i></a>
        <div>
            <b style="color: rgb(220, 53, 69);">FAQ</b><br>
            자주 묻는 질문을<br>
            볼 수 있어요
        </div>

        <span class="blank"></span>

        <a href="tags.ad"><i class="fab fa-tumblr"></i></a>
        <div>
            <b style="color: rgb(220, 53, 69);">Tags</b><br>
            태그가 첨부된 모든 게시글을<br>
            클릭 한 번으로 확인할 수 있어요
        </div>

    </div>

    <br><br>

    <c:if test="${loginUser.userStatus == 'Y'}">
        <div class="button-area" align="center">
            <button class="btn btn-outline-danger" onclick="location.href='enrollForm.faq'">작성하기</button>
        </div>

        <br>
    </c:if>

    <div class="faqArea" align="center">

        <c:forEach var="f" items="${list}">
            <div class="question">Q [
                <c:choose>
                    <c:when test="${f.type == 1}">
                        후원
                    </c:when>
                    <c:when test="${f.type == 2}">
                        공간대여
                    </c:when>
                    <c:otherwise>
                        QnA
                    </c:otherwise>
                        </c:choose>
                ] ${f.question}
            </div>
            <p class="answer">
                A ${f.answer}
                <c:if test="${loginUser.userStatus == 'Y'}">
                    <a href="updateForm.faq?fno=${f.fno}">수정</a>
                    <a href="#" onclick="deleteFaq(${f.fno});">삭제</a>
                </c:if>
            </p>
        </c:forEach>

        <script>
            $(function(){
                $("div").click(function(){
                    var $p = $(this).next();
                    if($p.css("display") == "none"){
                        $(this).siblings("p").slideUp();
                        $p.slideDown();
                    }else{
                        $p.slideUp();
                    }
                })
            })
        </script>

        <script>
            var fno="";
            $(document).ready(function(){

            })
            function deleteFaq(fno){

                if(!confirm("해당 게시글을 정말로 삭제 하시겠습니까?")){
                    alert("취소하셨습니다.");
                }else{
                    location.href="deleteFaq.ad?fno="+fno;
                }
            }
        </script>

    </div>

</div>

<br><br>

<jsp:include page="../common/footer.jsp" />

</body>
</html>