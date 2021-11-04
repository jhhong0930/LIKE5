<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: jhhon
  Date: 2021-08-09
  Time: 오후 9:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .outer{
            height: 1080px;
        }
        #star{
            color: yellow;
            size: 6x;
        }
        .starIcon{
            position:absolute;
            margin-left: 50px;
        }
        #starIcon{
            margin-left: 0%;
        }
        #tagTable {
            width: 900px;
            text-align: center;
            vertical-align: middle;
        }
        .outer{width: 1200px;}
        .outer {
            margin: auto;
        }
        .inner{
            width: 1100px;
            box-sizing: border-box;

        }
        .inner {
            margin: auto;
        }
        .inner>table{
            margin: auto;
        }
        .pagination{
            text-align: center;
            margin: auto;
        }
        .pagination li a.page-link{
            color: rgb(220, 53, 69);
        }
        .pagination .active a {
            background-color: rgb(220, 53, 69) !important;
            border: 1px solid white !important;
        }
        .page-link:hover{
            color: white !important;
        }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<br>

<div class="outer">
    <!--폰트어썸 사용함-->
    <div class="starIcon">
        <i id="star" class="fas fa-star fa-stack-2x">TAGS</i>
        <i id="starBold" class="far  fa-star fa-stack-2x">TAGS</i>
    </div>
    <br>
    <hr>
    <br>
    <div class="inner">
        <h6><b>${tagName}</b> 태그가 걸린 모든 글을 확인해보세요!</h6><bR>
        <table class="table tagTable">
            <thead style="text-align: center;">
            <tr>
                <th>게시판</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            </thead>
            <tbody style="text-align: center;">
                <c:forEach var="b" items="${list}">
                    <tr>
                        <td>${b.category}</td>
                        <td>${b.title}</td>
                        <td>${b.nickname}</td>
                        <td>${b.enrollDate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <br>
    </div>
    <!-- 페이징 바 -->
    <ul class="pagination justify-content-center">
        <c:choose>
            <c:when test="${pi.currentPage eq 1}">
                <li class="page-item disabled"><a class="page-link">&laquo;</a></li>
            </c:when>
            <c:otherwise>
                <li class="page-item"><a class="page-link" href="tagDetail.ad?currentPage=${pi.currentPage - 1}&tagName=${tagName}">&laquo;</a></li>
            </c:otherwise>
        </c:choose>

        <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
            <c:choose>
                <c:when test="${pi.currentPage eq p}">
                    <li class="page-item active"><a class="page-link" href="tagDetail.ad?currentPage=${p}&tagName=${tagName}">${p}</a></li>
                </c:when>
                <c:otherwise>
                    <li class="page-item"><a class="page-link" href="tagDetail.ad?currentPage=${p}&tagName=${tagName}">${p}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${ pi.currentPage eq pi.maxPage }">
                <li class="page-item disabled"><a class="page-link">&raquo;</a></li>
            </c:when>
            <c:otherwise>
                <li class="page-item"><a class="page-link" href="tagDetail.ad?currentPage=${pi.currentPage + 1}&tagName=${tagName}">&raquo;</a></li>
            </c:otherwise>
        </c:choose>
    </ul>

</div>

<jsp:include page="../common/footer.jsp" />

</body>
</html>
