<%--
  Created by IntelliJ IDEA.
  User: jhhon
  Date: 2021-08-03
  Time: 오후 7:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .enrollForm{
            margin: 0 auto;
            width: 50%;
        }
        .question{
            width: 500px;
        }
        .answer{
            width: 500px;
            height: 250px;
        }
    </style>
</head>
<body>

    <jsp:include page="../common/header.jsp" />

    <div class="innerOuter">

        <br><br><br>

        <form action="insertFaq.ad" method="post" class="enrollForm">

            <select class="selectpicker" name="type">
                <option value="1" name="1">후원</option>
                <option value="2" name="2">공간대여</option>
                <option value="3" name="3">QnA</option>
            </select>
            <br><br>
            <input type="text" name="question" class="question" placeholder="Q">
            <br><br>
            <textarea name="answer" class="answer" placeholder="A"></textarea>
            <br><br>
            <button type="submit" class="btn btn-outline-danger">작성하기</button>

        </form>

    </div>

</body>
</html>
