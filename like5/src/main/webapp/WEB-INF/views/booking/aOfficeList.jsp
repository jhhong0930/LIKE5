<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
<%-- aside --%>
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

	.innerOuter{ display:flex;}
	.admin-box,
	.office-box {
	  display: flex;
	  align-self: center;
	  flex-direction: column;
	  margin:0 0 100px 0;
	  min-width: 80%;
	  margin-top:60px;
	}
	.button-box {
	  float: right;
	  margin-bottom:10px;
	}
	table {
	  margin: 32px 0;
	  min-width: 100%;
	  text-align:center;
	 
	}
	table tbody{
		cursor:pointer;
	}
	.pagination {
	  justify-content: center;
	}
</style>
<body>
<jsp:include page="../common/header.jsp"/>
    <div class="innerOuter">
    
    <div class="sideBar">
        <div class="aside-title"><h3>통합관리</h3></div>
	    <aside>
	        <ul>
	            <li><a href="member.ad">회원관리</a></li>
	            <li><a href="board.ad">게시글관리</a></li>
	            <li><a href="customer.ad">고객센터</a></li>
	            <li><a href="donation.ad">후원관리</a></li>
	            <li><a href="list.bk">공간대여관리</a></li>
	            <li><a href="space.bo">공간예약관리</a></li>
	        </ul>
	    </aside>
    </div>

        <div class="admin-box">
            <div class="admin-title">
                <h1>공간관리</h1>
            </div>
            <form action="deleteOffices.bk" method="post">
            <div class="admin-content">
                <div class="button-box">
                    <button class="btn btn-primary btn-sm" type="button"><a href="insertForm.bk">추가하기</a></button>
                    <button class="btn btn-warning btn-sm" type="button" id="deleteOffice">삭제하기</button>
                </div>
                <table class="table table-hover" id="officeList">
                	<thead>
                	<tr>
                        <th>#</th>
                        <th>오피스번호</th>
                        <th>오피스타입</th>
                        <th>주소</th>
                        <th>매니저</th>
                    </tr>
                	</thead>
					<tbody>
					<c:forEach var="o" items="${ list }">
					<tr>
                        <td><input type="checkbox" name="officeNos" value="${ o.officeNo }"></td>
                        <td class="ono">${ o.officeNo }</td>
                        <td>${ o.typeName }</td>
                        <td>${ o.address }</td>
                        <td>${ o.manager }</td>
                    </tr>
                    </c:forEach>
					</tbody>
                </table>
                <div class="pagination">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                        <c:choose>
                        	<c:when test="${ pi.currentPage eq 1 }">
	                        <li class="page-item disabled">
	                            <a class="page-link" href="#" aria-label="Previous">
	                            <span aria-hidden="true">&laquo;</span>
	                            </a>
	                        </li>
                        	</c:when>
                        	<c:when test="${ empty condition }">
	                        <li class="page-item">
	                            <a class="page-link" href="list.bk?currentPage=${ pi.currentPage-1 }" aria-label="Previous">
	                            <span aria-hidden="true">&laquo;</span>
	                            </a>
	                        </li>
                        	</c:when>
                        	<c:otherwise>
                        	<li class="page-item">
	                            <a class="page-link" href="list.bk?currentPage=${ pi.currentPage-1 }&condition=${condition}&keyword=${keyword}" aria-label="Previous">
	                            <span aria-hidden="true">&laquo;</span>
	                            </a>
	                        </li>
                        	</c:otherwise>
                        </c:choose>
                        
                        <c:forEach var="o" begin="${ pi.startPage }" end="${ pi.endPage }">
                        	<c:choose>
                        		<c:when test="${ empty condition }">
                        		<li class="page-item"><a class="page-link" href="list.bk?currentPage=${ o }">${ o }</a></li>
                        		</c:when>
                        		<c:otherwise>
                        		<li class="page-item"><a class="page-link" href="list.bk?currentPage=${ o }&condition=${condition}&keyword=${keyword}">${ o }</a></li>
                        		</c:otherwise>
                        	</c:choose>
                        </c:forEach>
                        
                        <c:choose>
                        	<c:when test="${ pi.currentPage eq pi.maxPage }">
	                        <li class="page-item disabled">
	                            <a class="page-link" href="#" aria-label="Next">
	                            <span aria-hidden="true">&raquo;</span>
	                            </a>
	                        </li>
                        	</c:when>
                        	<c:when test="${ empty condition }">
	                        <li class="page-item">
	                            <a class="page-link" href="list.bk?currentPage=${ pi.currentPage+1 }" aria-label="Next">
	                            <span aria-hidden="true">&raquo;</span>
	                            </a>
	                        </li>
                        	</c:when>
                        	<c:otherwise>
                        	<li class="page-item">
	                            <a class="page-link" href="list.bk?currentPage=${ pi.currentPage+1 }&condition=${condition}&keyword=${keyword}" aria-label="Next">
	                            <span aria-hidden="true">&raquo;</span>
	                            </a>
	                        </li>
                        	</c:otherwise>
                        </c:choose>
                        </ul>
                    </nav>
                </div>
            </div>
            </form>

        </div>
    </div>

<script>
	$(function(){
		$("#officeList tbody tr").click(function(){
			location.href="detail.bk?ono=" + $(this).children().eq(1).text();
		})
		
		//eventBubbling
		$("input:checkbox").click(function(event,error){
    		event.stopPropagation();
   		});
		
		var checked = [];
		//check된것의 officeNo들 다 모으기
		$("input:checkbox").click(function(){
			checked.push($(this).parent().next().text());
			console.log(checked);
		});
		//삭제하기 버튼 이벤트
		$("#deleteOffice").click(function(){
			var result = confirm("are you sure??");
			if(result){
				$("form").submit();
			} else {
				location.reload();
			}
		})
	})
</script>
</body>
</html>