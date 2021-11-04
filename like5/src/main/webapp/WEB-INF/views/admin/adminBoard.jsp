<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        aside{
            float: left;
            margin-right: 50px;
        }
        .aside-title{
            padding: 30px 10px;
        }
        aside ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            width: 130px;
            /* background-color: #f1f1f1; */
        }
        aside li{
            border: 1px lightgray solid;
        }

        aside li a {
            display: block;
            color: #000;
            padding: 8px 16px;
            text-decoration: none;
            text-align: center;
        }

        aside li a.active {
            background-color: rgb(220, 53, 69);
            color: white;
            text-decoration: none;
        }

        aside li a:hover:not(.active) {
            background-color: rgb(220, 53, 69);
            color: white;
            text-decoration: none;
        }

        .input-search{
            border: 1px solid #ced4da;
            border-radius: .25rem;
            height: 38px;
        }

        table{
            text-align: center;
        }
        form{
            display: flex;
        }
        tr{
            /*height: 40px;*/
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
<jsp:include page="../common/header.jsp"/>

<br>

<div class="innerOuter">

    <div class="aside-title">
        <h3>통합관리</h3>
    </div>

    <aside>
        <ul>
            <li>
                <a href="member.ad">회원관리</a>
            </li>
            <li>
                <a class="active" href="board.ad">게시글관리</a>
            </li>
            <li>
                <a href="customer.ad">고객센터</a>
            </li>
            <li>
                <a href="donation.ad">후원관리</a>
            </li>
            <li>
                <a href="list.bk">공간대여관리</a> <%--신원 루트 수정 --%>
            </li>
            <li>
            	<a href="space.bo">공간예약관리</a> <%--정빈 사이드 바 추가 --%>
            </li>
        </ul>
    </aside>

    <article>
        <form action="searchBoard.ad" method="get">
            <select class="selectpicker" name="condition">
                <option value="category" name="category">카테고리</option>
                <option value="title" name="title">제목</option>
                <option value="nickname" name="nickname">작성자</option>
            </select>
            <input type="text" class="form-control w-25" name="keyword" value="${keyword}">
            <button class="btn btn-outline-danger">검색</button>
        </form>
        <script>
            $(function(){
                if("${condition}" != ""){
                    $("option[value=${condition}]").attr("selected", true);
                }
            })
        </script>

        <br><br>

        <table class="table-bordered table-sm">
            <thead>
            <tr class="table-danger">
                <th>No</th>
                <th>게시판 이름</th>
                <th width="600">제목</th>
                <th width="70">작성자</th>
                <th width="110">작성일자</th>
                <th>삭제</th>
            </tr>
            </thead>
            <tbody>
                <c:forEach var="b" items="${list}">
                    <tr>

                        <td class="bno">${b.bno}</td>
                        <td>${b.category}</td>
                        <td id="title">
                            ${b.title}
                            <input type="hidden" id="mno" value="${b.mno}">
                            <input type="hidden" id="bno" value="${b.bno}">
                            <input type="hidden" id="category" value="${b.category}">
                        </td>
                        <td>${b.nickname}</td>
                        <td>${b.enrollDate}</td>
                        <td><button class="btn btn-outline-danger btn-sm" onclick="deleteBoard('${b.bno}')">삭제</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <script>
            $(document).on("click", "#title", function(){
                mno = ($(this).children('#mno').val());
                bno = ($(this).children('#bno').val());
                category = ($(this).children('#category').val());

                if(category === 'IT트렌드' || category === '컨퍼런스') {
                    location.href="itNewsDetail.bo?bno=" + bno;
                } else if(category === '일상' || category ===  '스터디모집') {
                    location.href="comDetail.bo?bno=" + bno;
                } else if(category === 'QNA') {
                    location.href="qnaDetail.bo?bno=" + bno;
                } else if(category === '칼럼'){
                    location.href="colDetail.bo?bno=" + bno + "&mno=" + mno;
                }

                console.log(mno);
            });
        </script>


        <script>

            function deleteBoard(bno){
                if(!confirm("해당 게시글을 삭제하시겠습니까?")){
                    alert("취소하셨습니다.")
                }else{
                    location.href="deleteBoard.ad?bno="+bno;
                }
            }
        </script>


    </article>

    <br><br>

    <!-- 페이징 바 -->
    <ul class="pagination justify-content-center">
        <c:choose>
            <c:when test="${pi.currentPage eq 1}">
                <li class="page-item disabled"><a class="page-link">&laquo;</a></li>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${!empty condition}">
                        <li class="page-item"><a class="page-link" href="searchBoard.ad?currentPage=${pi.currentPage - 1}&condition=${condition}&keyword=${keyword}">&laquo;</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item"><a class="page-link" href="board.ad?currentPage=${pi.currentPage - 1}">&laquo;</a></li>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>

        <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
            <c:choose>
                <c:when test="${!empty condition}">
                    <c:choose>
                        <c:when test="${pi.currentPage eq p}">
                            <li class="page-item active"><a class="page-link" href="searchBoard.ad?currentPage=${p}&condition=${condition}&keyword=${keyword}">${p}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="searchBoard.ad?currentPage=${p}&condition=${condition}&keyword=${keyword}">${p}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${pi.currentPage eq p}">
                            <li class="page-item active"><a class="page-link" href="board.ad?currentPage=${p}">${p}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="board.ad?currentPage=${p}">${p}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${ pi.currentPage eq pi.maxPage }">
                <li class="page-item disabled"><a class="page-link">&raquo;</a></li>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${ !empty condition }">
                        <li class="page-item"><a class="page-link" href="searchBoard.ad?currentPage=${pi.currentPage + 1}&condition=${condition}&keyword=${keyword}">&raquo;</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item"><a class="page-link" href="board.ad?currentPage=${pi.currentPage + 1}">&raquo;</a></li>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </ul>

    <br><br>


</div>


</body>
</html>