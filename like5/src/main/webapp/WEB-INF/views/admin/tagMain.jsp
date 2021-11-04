<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: jhhon
  Date: 2021-08-04
  Time: 오후 7:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .innerOuter{
            height: 1065px;
        }
        #star{
            color: yellow;
            size: 6px;
        }
        .starIcon{
            display: block;
            margin-left: 50px;
        }
        .tag-area{
            /*display: flex;*/
            border: 1px solid lightgrey;
            padding: 20px;
            border-radius: 10px;
            background: #F3F3F3;
            margin: 0 150px;
            display: block;
            line-height: 45px;

        }
        .tag{
            text-decoration: none;
            background: #96E1EB;
            color: #4D99A4;
            border-radius: 5px;
            padding: 3px;
            margin: 5px;
        }
        .tag:hover{
            text-decoration: none;
        }
    </style>
</head>
<body>

  <jsp:include page="../common/header.jsp" />

  <br><br>

  <div class="innerOuter">

      <div class="starIcon">
          <i id="star" class="fas fa-star fa-stack-2x">TAGS</i>
          <i id="starBold" class="far  fa-star fa-stack-2x">TAGS</i>
      </div>

      <br><br><br>

      <div class="tag-area">
          <c:forEach var="t" items="${list}">
              <a class="tag" href="tagDetail.ad?tagName=${t.tagName}">${t.tagName}</a>
          </c:forEach>
      </div>

      <br>

      <c:if test="${ !empty loginUser && (loginUser.userStatus == 'Y') }">

          <div class="button-area" align="center">
              <button class="btn btn-outline-danger" onclick="location.href='tagAdmin.ad'">관리하기</button>
          </div>

      </c:if>

  </div>

  <jsp:include page="../common/footer.jsp" />

</body>
</html>
