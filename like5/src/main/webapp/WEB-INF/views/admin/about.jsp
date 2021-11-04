<%--
  Created by IntelliJ IDEA.
  User: jhhon
  Date: 2021-07-28
  Time: 오후 4:01
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
        img{
            width: 250px;
            height: 250px;
            margin: 15px;
        }
        td{

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
        <br><br><br><br><br><br>
        
        <div class="image-area" align="center">
            <table>
                <tr>
                    <td>
                        <a href=""><img src="${pageContext.request.contextPath}/resources/images/about/like5.jpg"></a>
                    </td>
                    <td>
                        <a href="qnaList.bo"><img src="${pageContext.request.contextPath}/resources/images/about/QNA.jpg"></a>
                    </td>
                    <td>
                        <a href="bMain.bk"><img src="${pageContext.request.contextPath}/resources/images/about/place.jpg"></a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="comList.bo"><img src="${pageContext.request.contextPath}/resources/images/about/study.jpg"></a>
                    </td>
                    <td>
                        <a href="colList.bo"><img src="${pageContext.request.contextPath}/resources/images/about/column.jpg"></a>
                    </td>
                    <td>
                        <a href="itNews.bo"><img src="${pageContext.request.contextPath}/resources/images/about/itnews.jpg"></a>
                    </td>
                </tr>
            </table>
        </div>

    </div>

    <br><br><br><br><br><br><br><br><br><br>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>
