<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 공간예약관리</title>
<style>
	/*예약관리부분*/

		.content-area{
			margin-left:150px;
		}
        .outer {
            width: 70% !important; 
            margin: auto !important;
            align-items:center;
            padding:10px 20px;
        }
        #report-list {
			padding : 0;
            text-align: center;
            border: 1px solid lightgray;
            width: 90%;
            font-size: 13px;
            background-color: white;
        }
        .buttons{
            width: 100%;
            padding-left: 84%;;
            margin-bottom: 10px;
        }    
        #pagingArea{
		width: 100%;
        padding-left: 30%;
    }
    /*사이드 바*/
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

    aside li a:hover:not(.active) {
        background-color: rgb(220, 53, 69);
        color: white;
        text-decoration: none;
    }
</style>
<!-- 체크 삭제 기능 -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript">
		$(function(){
			var chkObj = document.getElementsByName("RowCheck");
			var rowCnt = chkObj.length;
			
			$("input[name='allCheck']").click(function(){
				var chk_listArr = $("input[name='RowCheck']");
				for (var i=0; i<chk_listArr.length; i++){
					chk_listArr[i].checked = this.checked;
				}
			});
			$("input[name='RowCheck']").click(function(){
				if($("input[name='RowCheck']:checked").length == rowCnt){
					$("input[name='allCheck']")[0].checked = true;
				}
				else{
					$("input[name='allCheck']")[0].checked = false;
				}
			});
		});
		function deleteValue(){
			var url = "delete";    // Controller로 보내고자 하는 URL
			var valueArr = new Array();
		    var list = $("input[name='RowCheck']");
		    for(var i = 0; i < list.length; i++){
		        if(list[i].checked){ //선택되어 있으면 배열에 값을 저장함
		            valueArr.push(list[i].value);
		        }
		    }
		    if (valueArr.length == 0){
		    	alert("선택된 글이 없습니다.");
		    }
		    else{
				var chk = confirm("정말 삭제하시겠습니까?");				 
				$.ajax({
				    url : url,                    // 전송 URL
				    type : 'POST',                // POST 방식
				    traditional : true,
				    data : {
				    	valueArr : valueArr        // 보내고자 하는 data 변수 설정
				    },
	                success: function(jdata){
	                    if(jdata = 1) {
	                        alert("삭제에 성공하셨습니다.");
	                        location.replace("space.bo") //list 로 페이지 새로고침
	                    }
	                    else{
	                        alert("삭제 실패");
	                    }
	                }
				});
			}
		}
		
		$(function(){
    		$("#report-list>tbody>tr>td").click(function(){
    			//location.href="Space2.bo?bno=" + $(this).children(".bno").text();
    			location.href="Space2.bo?bno=" + $(this).parent().children().eq(0).find("input").val();
    			
    		})
    	})
	</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	
	<!--예약관리 버튼-->
    <div class="outer">
        <div class="aside-title">
            <h3>통합관리</h3>
        </div>
		<aside>
			<ul>
				<li><a class="active" href="member.ad">회원관리</a></li>
				<li><a href="board.ad">게시글관리</a></li>
				<li><a href="customer.ad">고객센터</a></li>
				<li><a href="donation.ad">후원관리</a></li>
				<li><a href="list.bk">공간대여관리</a></li>
				<li><a href="space.bo">공간예약관리</a></li>
			</ul>
		</aside>

        <div class="content-area">    
            <h4><b>예약관리</b></h4> 
            <div class="buttons">
                <input type="button" value="취소하기" class="btn btn-primary btn-sm" onclick="deleteValue();">
            </div>

			<div class="table">
				<table id="report-list">
					<thead>
						<tr class="table-default">
							<th width="50px"><input id="allCheck" type="checkbox" name="allCheck"/></th>
							<th width="150px">예약번호</th>
							<th width="130px">지점</th>
							<th width="100px">예약자</th>
							<th width="100px">오피스타입</th>
							<th width="100px">예약일</th>
							<th width="80px">상태</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="list" items="${list}">
							<tr>
								<th><input name="RowCheck" type="checkbox" value="${ list.bookingNo }"></th>
								<td>${ list.bookingNo }</td>
								<td>${ list.branch }</td>
								<td>${ list.memName }</td>
								<td>${ list.typeName }</td>
								<td>${ list.requestDate }</td>
								<c:choose>
		                        	<c:when test="${ list.status eq 'Y' }">
		                        		<td>대기</td>
		                        	</c:when>
		                        	<c:when test="${ list.status eq 'N' }">
		                        		<td>취소</td>
		                        	</c:when>
		                        	<c:otherwise>
		                        		<td>완료</td>
		                        	</c:otherwise>
	                        	</c:choose>
							</tr>
						</c:forEach>	
					</tbody>
				</table>
			</div>
            
            <br><br><br>

            <!-- 페이징 바 -->
            <div id="pagingArea">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
	                    	<li class="page-item disabled"><a class="page-link">&laquo;</a></li>
	                    </c:when>
	                    <c:otherwise>
	                    	<li class="page-item"><a class="page-link" href="space.bo?currentPage=${ pi.currentPage-1 }">&laquo;</a></li>
                    	</c:otherwise>
                    </c:choose>
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                    	<li class="page-item"><a class="page-link" href="space.bo?currentPage=${ p }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
	                    	<li class="page-item disabled"><a class="page-link">&raquo;</a></li>
	                    </c:when>
	                    <c:otherwise>
	                    	<li class="page-item"><a class="page-link" href="space.bo?currentPage=${ pi.currentPage+1 }">&raquo;</a></li>
	                    </c:otherwise>
	                </c:choose>    
                </ul>
            </div>
		</div>
    </div>   
</body>
</html>