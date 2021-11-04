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
        #body{width:1200px; height:1000px; margin: auto;}
        #body>div{float: left;}

        #sidebar{width: 15%; height: 100%;}
        #sidmenu{height: 32%; width: 100%;border: 3px solid rgb(220, 53, 69); cursor:pointer;}
        #sidmenu>div{width: 100%; height: 25%; text-align:center; margin:0; padding-top:21px; font-size: 22px;}
        #sidmenu>div:hover{color:white; background-color:rgb(220, 53, 69) ; }
        #profile{height:23%; width: 100%;  margin-top: 15px; margin-left:3px;}
        #profile>img{width:150px; height:150px; border-radius: 70%; margin-left: 12px; margin-top: 12px;}
        #profile>div{width: 100%; height: 50px; font-size: 19px; text-align: center; margin-top:15px;}

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
        #post>div>div{width: 100%;}
        #post>div>div>div{margin-left: 150px; width: 100%;}
        #post button{background-color:rgb(220, 53, 69); color: white; border-radius:3px; border: none; float: right; margin-right:150px;}
        #post table{width: 70%; height: 80%;margin-top: 3.3%; margin-left:15%; text-align:center;}
        #change{background-color:rgb(220, 53, 69); color: white; border-radius:3px; border: none;}
        #calculate{background-color:rgb(220, 53, 69); color: white; border-radius:3px; border: none; float: right;}
        

    </style>
</head>
<body>
	
	<jsp:include page="../common/header.jsp"/>

    <div id="body">
      
      <div id="info">
        <div id="pageinfo">
            <h3>MY PAGE</h3>
        </div>
          <div id="line">
        </div>
      </div>

      <div id="sidebar">
        <div id="profile">
        <c:choose>
	        <c:when test="${ empty memberInfor.memProfile }">
	         	 <img src="https://i.imgur.com/pO4OGIl.jpg" alt="">
	         </c:when>
	         <c:otherwise>
	         	<img src="${ memberInfor.memProfile }" alt="">
	         </c:otherwise>
	    </c:choose>
          <div>
            	${memberInfor.nickName} 님
          </div>
        </div>
        <div id="sidmenu">  
          <div id="" onclick="location.href='myPage.me?memNo=${ loginUser.memNo }'" style="color:white; background-color:rgb(220, 53, 69);">
                  	게시글
          </div>
          <div id="" onclick="location.href='donate.me?memNo=${ loginUser.memNo }'">
                  	후원
          </div>
          <div id="" onclick="location.href='inquiry.me?memNo=${ loginUser.memNo }'">
                  	1:1문의
          </div>
          <%-- 신원 수정 --%>
          <div onclick="location.href='myBookList.bk?memNo=${ loginUser.memNo }'">
                  	공간예약
          </div>
        </div>
    </div>
        
        <div id="content">
            <div id="mem">
                <div id="meminfo">
                    <div>
                        <div>
                            	${memberInfor.memName} 님
                            <button id="change" type="button" onclick="location.href='correctInfor.me'">정보수정</button>
                        </div>
                        <div>
                            	이메일 : ${memberInfor.email}
                        </div>
                        <div>
                            	닉네임 : ${memberInfor.nickName}
                        </div>
                    </div>
                </div>
                <div id="donate">
                    <div>
                        <div>
                            	총 후원받은 금액 : <fmt:formatNumber value="${ price }" pattern="#,###,###"/>
                            	<c:if test="${ settleable > 9999 }">
                            		<button id="calculate" type="button" data-toggle="modal" data-target="#MyModal">정산받기</button>
                            	</c:if>
                            	
                        </div>
                        <div>
                            	정산 가능한 금액 : <fmt:formatNumber value="${ settleable }" pattern="#,###,###"/>
                        </div>
                        <div>
                            	정산 계좌 : ${ memberInfor.bank } ${ memberInfor.accountNum }
                        </div>
                    </div>
                </div>
            </div>
            <div id="post">
                <div>
                  <div style="float: left;">
                    <div>
                        	최근 등록 게시물
                        <button onclick="location.href='memPostListDetail.me?memNo=${loginUser.memNo}'" style="float: right; margin-right: 300px;">
                        	전체보기
                      </button>
                    </div>
                  </div>
                    <table class="table">
                    <thead>
                      <tr>
                        <th>등록일자</th>
                        <th>제목</th>
                        <th>게시판</th>
                      </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="newlyList" items="${ newlyList }">
	                    	<c:choose>
	                    		<c:when test="${ newlyList.category eq '일상' || newlyList.category eq '스터디모집'}">
	                    			<tr onclick="location.href='comDetail.bo?bno=${ newlyList.bno }'">
		                    			<td><fmt:formatDate pattern="yy/MM/dd" value="${ newlyList.enrollDate }"/></td>
						                <td>${ newlyList.title }</td>
						                <td>${ newlyList.category }</td>
					          		</tr>
	                    		</c:when>
	                    		<c:when test="${ newlyList.category eq 'QNA' }">
	                    			<tr onclick="location.href='qnaDetail.bo?bno=${ newlyList.bno }'">
		                    			<td><fmt:formatDate pattern="yy/MM/dd" value="${ newlyList.enrollDate }"/></td>
						                <td>${ newlyList.title }</td>
						                <td>${ newlyList.category }</td>
						          	</tr>
	                    		</c:when>
	                    		<c:when test="${ newlyList.category eq '칼럼' }">
	                    			<tr onclick="location.href='colDetail.bo?bno=${ newlyList.bno }&mno=${ loginUser.memNo }'">
		                    			<td><fmt:formatDate pattern="yy/MM/dd" value="${ newlyList.enrollDate }"/></td>
						                <td>${ newlyList.title }</td>
						                <td>${ newlyList.category }</td>
						          	</tr>
	                    		</c:when>
	                    	</c:choose>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
                <div>  
                  <div style="float: left;">
                    <div>
                      	최근 임시 저장글
                      <button onclick="location.href='tempSaveListDetail.me?memNo=${loginUser.memNo}'" style="float: right; margin-right: 300px;">
                     	 전체보기
                      </button>
                    </div>
                  </div>
                  <table class="table">
                      <thead>
                        <tr>
                          <th>등록일자</th>
                          <th>제목</th>
                          <th>게시판</th>
                        </tr>
                      </thead>
                      <tbody>
	                  	<c:forEach var="tempSaveList" items="${ tempSaveList }">
	                  		<c:choose>
		                  		<c:when test="${ tempSaveList.category eq 'QNA' }">
			                      <tr onclick="location.href='qnaUpdateForm.bo?bno=${ tempSaveList.bno }'">
			                        <td><fmt:formatDate pattern="yy/MM/dd" value="${ tempSaveList.enrollDate }"></fmt:formatDate></td>
			                        <td>${ tempSaveList.title }</td>
			                        <td>${ tempSaveList.category }</td>
			                      </tr>
			                  	</c:when>
			                  	<c:when test="${ tempSaveList.category eq '칼럼' }">
			                  		<tr onclick="location.href='selectTemSave.bo?bno=${ tempSaveList.bno }'">
			                        	<td><fmt:formatDate pattern="yy/MM/dd" value="${ tempSaveList.enrollDate }"></fmt:formatDate></td>
			                        	<td>${ tempSaveList.title }</td>
			                        	<td>${ tempSaveList.category }</td>
			                      	</tr>
			                  	</c:when>
		                	</c:choose>
	                	</c:forEach>
                    </tbody>
                  </table>
                </div>
                <div>
                    <div style="float: left;">
                      <div>
                         	 최근 등록 댓글
                          <button onclick="location.href='ansListDetail.me?memNo=${loginUser.memNo}'" style="float: right; margin-right: 300px;">
                          	전체보기
                        </button>
                      </div>
                    </div>
                    <table class="table">
                        <thead>
                          <tr>
                            <th>등록일자</th>
	                        <th>내용</th>
	                        <th>게시판</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="ansList" items="${ ansList }">
	                          <c:choose>
			                  		<c:when test="${ ansList.board.category eq 'QNA' }">
				                      <tr onclick="location.href='qnaDetail.bo?bno=${ ansList.reply.boaNo }'">
				                        <td><fmt:formatDate pattern="yy/MM/dd" value="${ ansList.reply.repEnrollDate }"></fmt:formatDate></td>
				                        <td>${ ansList.reply.repContent }</td>
				                        <td>${ ansList.board.category }</td>
				                      </tr>
				                    </c:when>
				                    <c:when test="${ ansList.board.category eq '일상' || ansList.board.category eq '스터디모집' }">
				                      <tr onclick="location.href='comDetail.bo?bno=${ ansList.reply.boaNo }'">
				                        <td><fmt:formatDate pattern="yy/MM/dd" value="${ ansList.reply.repEnrollDate }"></fmt:formatDate></td>
				                        <td>${ ansList.reply.repContent }</td>
				                        <td>${ ansList.board.category }</td>
				                      </tr>
				                    </c:when>
				          	</c:choose>
                      	  </c:forEach>
                        </tbody>
                      </table>
                    </div>
            </div>
        </div>
            
            <%-- 신원 공간 추가 
            <div class="bookingSection">
            	<table class="table">
            		<thead>
            			<tr>
            				<th>예약번호</th>
            				<th>예약일</th>
            				<th>예약사무실</th>
            				<th>상태</th>
            			</tr>
            		</thead>
            		<tbody>
            		<c:forEach var="b" items="${ blist }">
            		 	<tr>
            				<td>${ b.bookingNo }</td>
            				<td>${ b.requestDate }</td>
	                        <td>${ b.typeName }</td>
	                        <td>${ b.status }</td>
            			</tr>
            		</c:forEach>
            		</tbody>
            	</table>
            </div>
        </div>
        --%>
        <!-- The Modal -->
        <div class="modal fade" id="MyModal">
        	
            <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
            
                <!-- Modal Header -->
                <div class="modal-header">
                <h4 class="modal-title">정산받기</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <form action="insertcalculate.me" method="post">
                <!-- Modal body -->
                <div class="modal-body" style="border: 2px solid lightgrey;">
                  <div  style="margin-left:80px;">
			                  안내 <br>
			                  1만원 이상부터 출금가능<br>
			                  출금시 총 신청금액에서 수수료 5% 제하고 입금<br><br>
                  <input id="calPrice" name="calPrice" type="text" placeholder="금액을 입력해주세요" style="width:70%; height:30px;">
                  <input id="memNo" name="memNo"  type="hidden" value="${ loginUser.memNo }">
                  <input id="memName" name="memName"  type="hidden" value="${ loginUser.memName }">
                  <input id="calBank" name="calBank"  type="hidden" value="${ loginUser.bank }">
                  <input id="calAccount"name="calAccount"  type="hidden" value="${ loginUser.accountNum }">
                  </div>
                </div>
                
                <!-- Modal footer -->
                <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" style="border: 2px solid rgb(220, 53, 69); background-color: white; color: rgb(220, 53, 69);">취소</button>
                <button type="submit" class="btn btn-secondary" style="background-color: rgb(220, 53, 69); color: white;">정산받기</button>
                </div>
                </form>
            </div>
            </div>
            
        </div>

    </div>
    
    <br><br>
    
    <jsp:include page="../common/footer.jsp"/>
    
</body>
</html>