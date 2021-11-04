<%--
  Created by IntelliJ IDEA.
  User: jhhon
  Date: 2021-07-29
  Time: 오후 8:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <style>
        .title{
            float: left;
            margin-right: 74px;
        }
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
            height: 40px;
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

  <div class="innerOuter">

      <div class="aside-title">

          <h3 class="title">통합관리</h3>
          <div class="tab-area">
              <button onclick="location.href='customer.ad'" class="btn btn-outline-danger active">신고내역</button>
              <button onclick="location.href='csTwo.ad'" class="btn btn-outline-danger ">1:1문의</button>
          </div>

      </div>

      <aside>
          <ul>
              <li>
                  <a href="member.ad">회원관리</a>
              </li>
              <li>
                  <a href="board.ad">게시글관리</a>
              </li>
              <li>
                  <a class="active" href="customer.ad">고객센터</a>
              </li>
              <li>
                  <a href="donation.ad">후원관리</a>
              </li>
              <li>
                  <a href="list.bk">공간대여관리</a>
              </li>
              <li>
            	  <a href="space.bo">공간예약관리</a> <%--정빈 사이드 바 추가 --%>
              </li>
          </ul>
      </aside>

      <article>

          <form action="searchReport.ad" method="get">
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
                      <th>신고자 아이디</th>
                      <th width="500">신고 게시글 제목</th>
                      <th width="100">게시판 이름</th>
                      <th width="180">신고 사유</th>
                      <th>신고 날짜</th>
                      <th>삭제</th>
                  </tr>
              </thead>
              <tbody>
                  <c:forEach var="r" items="${list}">
                      <tr>
                          <td class="rno">${r.rno}</td>
                          <td>${r.nickname}</td>
                          <td>${r.title}</td>
                          <td>${r.category}</td>
                          <td>${r.reason}</td>
                          <td>${r.reportDate}</td>
                          <td><button class="btn btn-outline-danger btn-sm" onclick="deleteReport('${r.rno}')">삭제</button></td>
                      </tr>
                  </c:forEach>
              </tbody>
          </table>

          <script>

              function deleteReport(rno){
                  if(!confirm("해당 게시글을 삭제하시겠습니까?")){
                      alert("취소하셨습니다.")
                  }else{
                      location.href="deleteReport.ad?rno="+rno;
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
                          <li class="page-item"><a class="page-link" href="searchReport.ad?currentPage=${pi.currentPage - 1}&condition=${condition}&keyword=${keyword}">&laquo;</a></li>
                      </c:when>
                      <c:otherwise>
                          <li class="page-item"><a class="page-link" href="customer.ad?currentPage=${pi.currentPage - 1}">&laquo;</a></li>
                      </c:otherwise>
                  </c:choose>
              </c:otherwise>
          </c:choose>

          <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
              <c:choose>
                  <c:when test="${!empty condition}">
                      <c:choose>
                          <c:when test="${pi.currentPage eq p}">
                              <li class="page-item active"><a class="page-link" href="searchReport.ad?currentPage=${p}&condition=${condition}&keyword=${keyword}">${p}</a></li>
                          </c:when>
                          <c:otherwise>
                              <li class="page-item"><a class="page-link" href="searchReport.ad?currentPage=${p}&condition=${condition}&keyword=${keyword}">${p}</a></li>
                          </c:otherwise>
                      </c:choose>
                  </c:when>
                  <c:otherwise>
                      <c:choose>
                          <c:when test="${pi.currentPage eq p}">
                              <li class="page-item active"><a class="page-link" href="customer.ad?currentPage=${p}">${p}</a></li>
                          </c:when>
                          <c:otherwise>
                              <li class="page-item"><a class="page-link" href="customer.ad?currentPage=${p}">${p}</a></li>
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
                          <li class="page-item"><a class="page-link" href="searchReport.ad?currentPage=${pi.currentPage + 1}&condition=${condition}&keyword=${keyword}">&raquo;</a></li>
                      </c:when>
                      <c:otherwise>
                          <li class="page-item"><a class="page-link" href="customer.ad?currentPage=${pi.currentPage + 1}">&raquo;</a></li>
                      </c:otherwise>
                  </c:choose>
              </c:otherwise>
          </c:choose>
      </ul>

      <br><br>

  </div>

</body>
</html>
