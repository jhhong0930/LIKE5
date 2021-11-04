<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- flatpickr -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/material_red.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
<style>
	table {
	  margin: 32px 0;
	  min-width: 100%;
	}
	tbody{
		cursor:pointer;
	}
	.pagination {
	  justify-content: center;
	}
    .b-detail{
    	margin-top:60px;
        display: block;
        min-width: 100%;
        height: 100vh;
    }
    .sum-box{
        margin:32px 0;
        padding: 15px;
        border: 3px solid rgb(176, 176, 176);
        width: 100%;
    }
    .b-table{
        text-align: center;
    }
    .detail-page{
        display: none;
        padding-bottom:80px;
    }
    .detail-wrapper{
        display: flex;
    }
    .detail-content1{
        display: flex;
        justify-content: space-between;
        width:50%;
    }
    .detail-content2{
        justify-content: space-around;
        width: 50%;
    }
    .detail-content1 ul li{
        padding:8px;
    }
    select[name=person]{
    	width:100%;
    }
    .line1,.line2,.line3,.line4 {
	  display: flex;
	  justify-content: space-between;
	  height:50px;
}
	:is(.line1, .line2, .line3) ul {
	  list-style-type: none;
	  margin: 10px;
	  padding: 0;;
	  width: 100%;
	  text-align:left;
}

	:is(.line1, .line2, .line3) li {
	  align-items: center; 
	  height:50px;
}
    .price-tag{
        margin-left:20px;
        font-weight:600;
        padding: 10px;
    }
    .price{
        width: 40%;
        padding: 10px;
        text-align:right;
    }
    .border{
        margin:24px 0;
        width:100%;
    }
    .border-sm{
        width:90%;
        border:1px solid lightgray;
        margin:0;
        padding:0;
    }
    .button-box button[type=submit], .modal-footer button[type=button]{
        background-color: #eb3e3e;
        border:none;
        border-radius: 3px;
        color:#ffff;
        height: 40px;
        width: 120px;
    }
    .button-box button[type=button]{
        background-color: #ffff;
        border:1.5px solid #eb3e3e;
        border-radius: 3px;
        height: 40px;
        width: 120px;
        color:#eb3e3e;
    }
    .top-t{
        padding-right: 10px;
        font-size: 16px;
        font-weight: 400;
    }
    .refund-alert{
        font-size: 14px;
        color:rgb(113,113,113);
        margin-top:32px;
        padding:10px;
    }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
   <div class="innerOuter">
        <div class="b-detail">
            <div class="title-box">
                <h1>BOOKING LIST</h1>
            </div>
            <div class="sum-box">
                <span>${ loginUser.memName }님이 예약하신 내역입니다</span>
            </div>
            <div class="b-table">
                <table border="1">
	                <thead>
                    <tr>
                    	<th>예약번호</th>
                        <th>예약일</th>
                        <th>예약사무실</th>
                        <th>상태</th>
                        <th>옵션</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="b" items="${ list }">
	                    <tr>
	                    	<td>${ b.bookingNo }</td>
	                        <td>${ b.requestDate }</td>
	                        <td>${ b.typeName }</td>
	                        <c:choose>
	                        	<c:when test="${ b.status eq 'Y' }">
	                        		<td>대기</td>
	                        		<td><a class="changeb" onclick="showBookDetail(${b.bookingNo});">변경 또는 취소</a></td>
	                        	</c:when>
	                        	<c:when test="${ b.status eq 'N' }">
	                        		<td>취소</td>
	                        		<td><a data-toggle="modal" data-target="#modal-cancel" onclick="showBookDetail(${b.bookingNo});">취소영수증</a></td>
	                        	</c:when>
	                        	<c:otherwise>
	                        		<td>완료</td>
	                        		<td><a data-toggle="modal" data-target="#modal-receipt" onclick="showBookDetail(${b.bookingNo});">완료영수증보기</a></td>
	                        	</c:otherwise>
	                        </c:choose>
	                    </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
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
                    	<c:otherwise> 
	                    <li class="page-item">
	                        <a class="page-link" href="myBookList.bk?currentPage=${ pi.currentPage-1 }" aria-label="Previous">
	                        <span aria-hidden="true">&laquo;</span>
	                        </a>
	                    </li>
                    	</c:otherwise>
                    </c:choose>
                    
                    <c:forEach var="b" begin="${ pi.startPage }" end="${ pi.endPage }">
						<li class="page-item"><a class="page-link" href="myBookList.bk?currentPage=${ b }">${ b }</a></li>
                    </c:forEach>
                    
					<c:choose>
						<c:when test="${ pi.currentPage eq pi.maxPage }">
						<li class="page-item disabled">
	                        <a class="page-link" href="#" aria-label="Next">
	                        <span aria-hidden="true">&raquo;</span>
	                        </a>
	                    </li>
						</c:when>
						<c:otherwise>
						<li class="page-item">
	                        <a class="page-link" href="myBookList.bk?currentPage=${ pi.currentPage+1 }" aria-label="Next">
	                        <span aria-hidden="true">&raquo;</span>
	                        </a>
	                    </li>
						</c:otherwise>
					</c:choose>
                    </ul>
                </nav>
            </div>
<!-- ajax처리할 부분 -->
            <div class="detail-page">
                <form class="modifyBform" action="modifyMyBook.bk" method="post">
                <input type="hidden" name="bookNo">
                    <div class="title-box">
                        <h2>예약 변경하기</h2>
                    </div>
                    <div class="detail-wrapper">
                        <div class="detail-content1">
                            <div class="line1">
                                <ul>
                                    <li>오피스타입 : </li>
                                    <li><span class="officeType"></span></li>
                                    <li>인원수 : </li>
                                    <li>
                                        <select name="person">
                                            <option value="1">1 명</option>
                                            <option value="2">2 명</option>
                                            <option value="3">3 명</option>
                                        </select>
                                    </li>
                                </ul>
                            </div>
                            <div class="line2">
                                <ul>
                                    <li>체크인</li>
                                    <li><input type="text" id="myCheckIn" name="startDate"></li>
                                    <li>체크아웃</li>
                                    <li><input type="text" id="myCheckOut" name="endDate"></li>
                                </ul>
                            </div>
                        </div>
                        <div class="detail-content2">
                            <div class="line1">
                                <div class="price-tag">소계:</div>
                                <div class="price" id="total">￦80,000</div>
                            </div>
                            <div class="border-sm"></div>
                            <div class="line2">
                                <div class="price-tag">수수료:</div>
                                <div class="price" id="fee">￦8,000</div>
                            </div>
                            <div class="border-sm"></div>
                            <div class="line3">
                                <div class="price-tag">새로운 총계:</div>
                                <div class="price" id="newTotal">￦88,000</div>
                            </div>
                            <div class="border-sm"></div>
                            <div class="line4">
                                <div class="price-tag">차이:</div>
                                <div class="price" id="gap">￦8,000</div>
                            </div>
                        </div>
                    </div>
                    <div class="refund-alert">
                        취소한 금액은 카드사의 사정에 따라 7~15일 정도 소요됩니다.
                    </div>
                    <div class="border"></div>
                    <div class="button-box">
                        <button type="submit">변경 신청하기</button>
                        <button type="button" class="cancelBook">예약 취소하기</button>
                        <input type="hidden" id="tt">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- modal receipt -->
    <div class="modal" id="modal-receipt" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">영수증 보기</h2>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="receipt-top">  
                    <div class="b-no">
                    <span class="top-t">예약번호</span>
                    <span id="receiptBno">001</span>
                    </div>
                    <!-- <div class="b-no-result">001</div> -->
                    <div class="b-date">
                        <span class="top-t">결제일</span>
                        <span id="receiptRequestDay">2021-04-12</span>
                    </div>
                    <!-- <div class="b-date-result"></div> -->
                </div>
                <div class="border"></div>
                <div class="receipt-middle">
                    <div class="b-date">
                        <span class="checkIn" id="receiptStartDate">2021-07-12</span>
                        <span> ~ </span>
                        <span class="checkOut" id="receiptEndDate">2021-07-13</span>
                    </div>
                    <div class="person" id="receiptPerson">프라이빗 1 인</div>
                </div>
                <div class="border"></div>
                <div class="receipt-title">
                    <h3>요금내역</h3>
                </div>
                <div class="receipt-breakdown">
                    <div class="line1">
                        <div class="price-tag"><span id="receiptDayPrice">￦80,000 </span> X <span id="receiptDay"></span> 일</div>
                        <div class="price" id="receiptPrice">￦80,000</div>
                    </div>
                    <div class="line2">
                        <div class="price-tag">수수료</div>
                        <div class="price" id="receiptFee">￦8,000</div>
                    </div>
                    <div class="border"></div>
                    <div class="line3">
                        <div class="price-tag">총합계</div>
                        <div class="price" id="receiptTotal">￦88,000</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" data-dismiss="modal">닫기</button>
            </div>
            </div>
        </div>
    </div>

<!-- modal cancel -->
<div class="modal" id="modal-cancel" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">영수증 보기</h2>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <div class="receipt-top">  
                <div class="b-no">
                <span class="top-t">예약번호</span>
                <span id="cancelBno">001</span>
                </div>
                <!-- <div class="b-no-result">001</div> -->
                <div class="b-date">
                    <span class="top-t">결제일</span>
                    <span id="cancelRequest">2021-04-12</span>
                </div>
                <!-- <div class="b-date-result"></div> -->
            </div>
            <div class="border"></div>
            <div class="receipt-middle">
                <div class="b-date">
                    <span class="checkIn" id="cancelStartDate">2021-07-12</span>
                    <span> ~ </span>
                    <span class="checkOut" id="cancelEndDate">2021-07-13</span>
                </div>
                <div class="person" id="cancelPerson">프라이빗 1 인</div>
            </div>
            <div class="border"></div>
            <div class="receipt-title">
                <h3>취소 내역</h3>
            </div>
            <div class="receipt-breakdown">
                <div class="line1">
                    <div class="price-tag">최초예약금액</div>
                    <div class="price" id="cancelTotal">￦80,000</div>
                </div>
                <div class="line2">
                    <div class="price-tag">취소 수수료</div>
                    <div class="price" id="cancelFee">￦8,000</div>
                </div>
                <div class="border"></div>
                <div class="line3">
                    <div class="price-tag">환불 금액</div>
                    <div class="price" id="refund">￦72000</div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" data-dismiss="modal">닫기</button>
        </div>
        </div>
    </div>
</div>

<script>

    $(function(){
        $(".changeb").click(function(){
            $(".detail-page").toggle();
        })

        $(".cancelBook").on("click", function(){
        	/*
		    	var bno = result.bookingNo
		    	console.log("안"+bno);
		    	location.href="cancelMyBook.bk?bno=" + bno;
		    */
        	location.href="cancelMyBook.bk?bno=" + $("#tt").val();
		    	
		   }) 
    })
    

    <%-- 예약 정보 --%>
    
    function showBookDetail(bookingNo){
    	
    	$("#tt").val(bookingNo);
    	
    	$.ajax({
    		url:"myDetail.bk",
    		data:{ bookingNo: bookingNo },
    		success:function(result){
    			<%-- 취소 및 변경 모달 --%>
    	    	console.log(result.startDate);
    			$("input[type=hidden]").val(result.bookingNo);
    			
    			$("#myCheckIn").val(result.startDate);
    			$("#myCheckOut").val(result.endDate);
    			$("#total").html("￦" + result.total);
    			$(".officeType").text(result.typeName);
    			$("select[name=person] option").each(function(){
    				if($(this).val() == result.person){
    					$(this).prop("selected", true);
    				}
    			});
    			$("#fee").text("￦" + Math.floor(result.total * 0.1));
    			$("#newTotal").text("￦" + Math.floor(result.total * 1.1));
    			$("#gap").text("￦" + Math.floor(result.total * 1.1 - result.total));
    			
    			<%-- 취소 영수증 --%>
    			$("#cancelBno").text(result.bookingNo);
    			$("#cancelRequest").text(result.requestDate);
    			$("#cancelStartDate").text(result.startDate);
    			$("#cancelEndDate").text(result.endDate);
    			$("#cancelPerson").text(result.typeName + " " + result.person + "인");
    			$("#cancelTotal").text("￦ "+result.total);
    			$("#cancelFee").text("￦ "+result.total * 0.1);
    			$("#refund").text("￦ "+(result.total - result.total*0.1));
    			
    			<%-- 완료 영수증 --%>
    			$("#receiptStartDate").text(result.startDate);
    			$("#receiptEndDate").text(result.endDate);
    			$("#receiptBno").text(result.bookingNo);
    			$("#receiptRequestDay").text(result.requestDate);
    			$("#receiptDayPrice").text("￦ "+result.price);
    			var days = result.endDate.substr(8,10) - result.startDate.substr(8,10)
    			$("#receiptDay").html(days);
    			$("#receiptPrice").text("￦ "+result.price * days)
    			$("#receiptFee").text("￦ "+result.price * days * 0.1);
    			$("#receiptTotal").text("￦ "+ Math.floor(result.price * days*1.1));
    			$("#receiptPerson").text(result.typeName + " " + result.person + "인");
    			
		    	flatpickr("#myCheckIn",{
		    	    locale:"ko",
		    	    altInput:true,
		    	    altFormat:"Y\\년 F d\\일",
		    	    dateFormat:"Y-m-d",
		    	    defaultDate: result.startDate
		    	});
		    	flatpickr("#myCheckOut",{
		    	    locale:"ko",
		    	    altInput:true,
		    	    altFormat:"Y\\년 F d\\일",
		    	    dateFormat:"Y-m-d"
		    	});
		    	
    		    
    		    	
    		}, error:function(){
    			console.log("ajax실패");
    		}
    	})
    	
    }

    $("table>tbody>tr").on("click", function(){
    	console.log("밖"+$(this).children().eq(0).text());
    })
    
   
    <%--$(".cancelBook").on("click", function(){
		    	var bno = $("table>tbody>tr").children().eq(0).text();
		    	console.log("안"+bno);
		    	location.href="cancelMyBook.bk?bno=" + bno;
		    	
		   }) --%>

</script>
</body>
</html>