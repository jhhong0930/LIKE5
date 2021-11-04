<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        #body{width:1200px; height:1000px; margin: auto;}
        #body>div{float: left;}

        #info{width: 100%; height: 4%;}
        #pageinfo{width:100%; height: 100%;}
        #pageinfo h3{margin:0; padding-top:10px; padding-left: 5px;}
        #line{width: 100%; height: 2px; background-color: lightgrey;}

        #content{width:85%; height: 95%;}
        #mem{width:100%; height: 20%;}
        #mem>div{float: left;}
        #meminfo{width:65%; height: 100%;}
        #meminfo>div{width: 80%; height: 80%; margin-top:15px; margin-left:67px; border: 3px solid lightgray;}
        #meminfo>div>div{width:100%;height: 33.4%; }
        #donate{width: 35%; height: 100%;}
        #donate>div{width: 80%; height: 80%;margin-top:15px; margin-left:40px; border: 3px solid lightgray;}
        #donate>div>div{width: 100%; height: 33.3%;}
        #post{width: 100%; height: 78%;}
        #post>div{width: 100%; height: 30%;margin-top: 2%;}
        #post>div>div{width: 100%; margin-bottom: 5px;}
        #search{margin-left: 180px;}
        #post table{width: 70%; height: 80%; margin-left:15%; text-align:center;}
        #change{background-color:rgb(220, 53, 69); color: white; border-radius:3px; border: none;}
        #calculate{background-color:rgb(220, 53, 69); color: white; border-radius:3px; border: none;}
        
        #pagination{}

    </style>
</head>
<body>
	
	<jsp:include page="../../common/header.jsp" />
	<br><br>
    <div id="body">
      		<div id="info">
		        <div id="pageinfo">
		            <h3>IT NEWS</h3>
		        </div>
		          <div id="line">
		        </div>
		      </div>
            <div id="post">
                <div>
                    <div id="search">
                        <form action="itNewsSearch.bo" style="float: left; margin-right: 300px;">
                        <c:choose>
                        	<c:when test="${ condition eq 'cun'}">
                        		<select name="condition" id="">
		                            <option value="all">전체</option>
		                            <option value="cun" selected>컨퍼런스</option>
		                            <option value="itT">IT트렌드</option>
		                          </select>
                        	</c:when>
                        	<c:when test="${ condition eq 'itT'}">
                        		<select name="condition" id="">
		                            <option value="all">전체</option>
		                            <option value="cun">컨퍼런스</option>
		                            <option value="itT" selected>IT트렌드</option>
		                          </select>
                        	</c:when>
                        	<c:otherwise>
                        		<select name="condition" id="">
		                            <option value="all" selected>전체</option>
		                            <option value="cun">컨퍼런스</option>
		                            <option value="itT">IT트렌드</option>
		                          </select>
		                	</c:otherwise>
                        </c:choose>
                          <button style="background-color:rgb(220, 53, 69); color: white; border-radius:3px; border: none;">조회</button> 
                        </form>
                        <c:choose>
                        	<c:when test="${ loginUser.userStatus eq 'Y' }">
                        		<button type="button" onclick="location.href='insertItNewsForm.bo'" style=" float: right;background-color:rgb(220, 53, 69); color: white; border-radius:3px; border: none; margin-right: 360px;">작성하기</button>
                        	</c:when>
                        </c:choose>
                    </div>
                    <div>
                    <table class="table">
                    <thead>
                      <tr>
                        <th>글번호</th>
                        <th>글머리</th>
                        <th>제목</th>
                        <th>작성일</th>
                        <th>조회수</th>
                      </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="itNews" items="${ itNews }">
		                      <tr onclick="location.href='itNewsDetail.bo?bno=${ itNews.bno }'">
		                        <td>${ itNews.bno }</td>
		                        <td>${ itNews.category }</td>
		                        <td>${ itNews.title }</td>
		                        <td><fmt:formatDate pattern="yyyy.MM.dd" value="${ itNews.enrollDate }"/></td>
		                        <td>${ itNews.count }</td>
		                      </tr>
                    	</c:forEach>
                    </tbody>
                  </table>
                  <div style="display:inline-block; margin:auto; width: 100%;">
                  <div id="pagingArea" style="display: table; margin-left: auto;  margin-right: auto;">
	                	<ul class="pagination" id="pagination">
		                	<c:choose>
		                		<c:when test="${ pi.currentPage eq 1 }">
			                    	<li class="page-item disabled"><a class="page-link"><</a></li>
			                    </c:when>
			                    <c:otherwise>
			                    	<c:choose>
			                    		<c:when test="${ !empty condition }">
			                    			<li class="page-item"><a class="page-link" href="itNewsSearch.bo?currentPage=${ pi.currentPage-1 }&condition=${condition}"><</a></li>
		                    			</c:when>
		                    			<c:otherwise>
		                    				<li class="page-item"><a class="page-link" href="itNews.bo?currentPage=${ pi.currentPage-1 }"><</a></li>
		                    			</c:otherwise>
		                    		</c:choose>
		                    	</c:otherwise>
		                    </c:choose>
	                    
	                    
	                    
		                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
		                    	<c:choose>
		                    		<c:when test="${ !empty condition }">
		                   				<li class="page-item"><a class="page-link" href="itNewsSearch.bo?currentPage=${ p }&condition=${condition}">${ p }</a></li>
		                   			</c:when>
		                   			<c:otherwise>
		                   				<li class="page-item"><a class="page-link" href="itNews.bo?currentPage=${ p }">${ p }</a></li>
		                   			</c:otherwise>
		                    	</c:choose>
		                    </c:forEach>
	                    
	                    
		                    <c:choose>
		                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
			                    	<li class="page-item disabled"><a class="page-link">></a></li>
			                    </c:when>
			                    <c:otherwise>
			                    	<c:choose>
			                    		<c:when test="${ !empty condition }">
				                    		<li class="page-item"><a class="page-link" href="itNewsSearch.bo?currentPage=${ pi.currentPage+1 }&condition=${condition}">></a></li>
				                    	</c:when>
				                    	<c:otherwise>
				                    		<li class="page-item"><a class="page-link" href="itNews.bo?currentPage=${ pi.currentPage+1 }">></a></li>
				                    	</c:otherwise>
				                    </c:choose>
			                    </c:otherwise>
		                    </c:choose>
	                	</ul>
            		</div>
            		</div>
            </div>
        </div>
        </div>
        </div>
        
	<jsp:include page="../../common/footer.jsp" />
	
</body>
</html>