<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공간 리스트 상세페이지</title>
    <!-- services와 clusterer, drawing 라이브러리 불러오기 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f2e27dda5cfdc6659ff812c6b423f97a&libraries=services,clusterer,drawing"></script>
    <!-- flatpickr -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/material_red.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>

<style>
   /*여기부터 메인 css*/

     /*전체 공간*/
    .reservationDetail{
        width:1200px !important;
        height:2000px !important;
        margin:auto !important;
        padding:0px 70px 0px 70px;
    }
    /*메인 이미지
    .reserveImg{
        width:900px;
        margin-top:-10px;
    }*/

    /*시설 안내*/
    .facility{
        margin-left:8px;
        border:1px solid lightgray;
        width:600px;
        height:250px;
        padding:20px;
    }
    .fa1{margin-top:-825px;}

    /*인터넷/wifi*/
    .wifi{margin-left:30px;}
    .wifi2{margin-left:23px;}

    /*프린트*/
    .print{margin-left:170px; margin-top:-92px;}
    .print2{margin-left:172px;}

    /*주차*/
    .car{margin-left:310px; margin-top:-95px;}
    .car2{margin-left:325px; margin-top:12px;}

    /*컴퓨터/pc*/
    .com{margin-left:450px; margin-top:-90px;}
    .com2{margin-left:445px; margin-top:13px;}

    /*bar*/
    .bar{padding:5px; margin-left:20px; margin-top:20px;}
    .bar2{margin-left:43px;}

    /*회의실*/
    .meeting{margin-left:175px; margin-top:-80px;}
    .meeting2{margin-left:170px; margin-top:10px;}

    /*냉/난방시설*/
    .wind{margin-left:310px; margin-top:-85px;}
    .wind2{margin-left:300px; margin-top:9px;}

    /*매니저*/
    .people{margin-left:459px; margin-top:-80px;}
    .people2{margin-left:460px; margin-top:10px;}

    /* 세부 공간 선택*/
    .space{margin-left:650px; margin-top:30px;}
    .space2{
        border:1px solid gray;
        width:400px;
        height:750px;
        margin-left:650px;
        background-color: lightgray;
    }
    .space3{
        border:1px solid gray;
        width:350px;
        height:500px;
        margin-left:22px;
        margin-top:30px;
        padding:15px;
        background-color: white;
    }
    .checkIn input, .checkOut input{
    	z-index:2;
    	border: 1px solid orange;
    }
    .checkOut input{
    	border:1px solid green;
    }
    .fas{color:lightgrey}

    /*별점*/
    span.star-prototype, span.star-prototype > * {
    height: 16px;
    background: url(http://i.imgur.com/YsyS5y8.png) 0 -16px repeat-x;
    width: 80px;
    display: inline-block;
	}

	span.star-prototype > * {
    background-position: 0 0;
    max-width:80px;
	}
	
	.carousel-item{
		width: 600px;
		height: 450px;
		object-fit: contain !important;
	};
	.fit{
		object-fit: contain !important;
	}
	
	/* 스크롤 이동
	html {scroll-behavior: smooth; /* 부드럽게 */}  */
	
	
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>

   <br><br>
   <!--예약 상세페이지-->
    <div class="reservationDetail">

        <!--공간 제목,별점-->
        <div class="wrap1">
            <h1><b>${o.branch}</b></h1>
            <c:forEach var="r" items="${ rv }">
            	<span class="star-prototype">${r.reviewStar}</span>
            </c:forEach>
            <div class="hz" id="section1">
            <a href="#section2"><h4>후기</h4></a>
            </div>
        </div>

        <br>

        <!--메인 사진-->
        <%--DB추가 완료 --%>
        <div class="reserveImg">
           <div id="demo" class="carousel slide" data-ride="carousel">

           <!-- Indicators -->
           <ul class="carousel-indicators">
           	 <li data-target="#demo" class="active"></li>	
             <li data-target="#demo" data-slide-to="0"></li>
             <li data-target="#demo" data-slide-to="1"></li>
             <li data-target="#demo" data-slide-to="2"></li>
             <li data-target="#demo" data-slide-to="3"></li>
           </ul>

           <!-- 슬라이드 부분 -->
		   <div class="carousel-inner">
			    <div class="carousel-item active">
			    	<img class="d-block w-100" src="${o.offImgPath}">
			    </div>
			    <c:forEach var="i" begin="0" end="${ fn:length(at)-1 }">
				    <div class="carousel-item">
				      <img class="d-block w-100" src="${at.get(i).filePath}">
				    </div>
				</c:forEach>

           </div>

           <!-- Left and right controls -->
           <a class="carousel-control-prev" href="#demo" data-slide="prev">
             <span class="carousel-control-prev-icon"></span>
           </a>
           <a class="carousel-control-next" href="#demo" data-slide="next">
             <span class="carousel-control-next-icon"></span>
           </a>

         </div>
        </div>
         

        <br><br>

        <!-- 세부 공간 선택-->
        <div class="space"><h3><b>세부 공간 선택</b></h3></div> <br>

        <div class="space2">
            <div class="space3">
                <b>호스트의 승인을 기다릴 필요 없이 <br>
                    지금 바로 예약하세요!</b><br><br>
                <form class="detailForm" action="paymentForm.bk" method="post">

                <b>${o.branch}</b> &nbsp;&nbsp;&nbsp;<b>${o.price} 원 / 1일 </b></b> <br><br><br>
                <b>체크인</b> <br>
                <%--flatpickr이용해서 날짜 선택할 수 있게 해주세요 --%>
                <div class="checkIn"><input type="text" class="startDate" name="startDate"></div>

                <b>체크아웃</b>
                <div class="checkOut"><input type="text" class="endDate" name="endDate"></div>
                 <br><br><br><br>

                <input type="hidden" name="officeNo" value="${ o.officeNo }">
                <button type="submit" class="btn btn-danger btn-block">예약 하기</button>
               </form>
            </div>
        </div>

        <!--시설 안내-->
   <div class="fa1"><h3><b>시설 안내</b></h3></div> <br>
   <div class="facility">

            <div class="wifi"><i id="wifiIcon" class='fas fa-wifi' style='font-size:48px;'></i></div> <br>
            <div class="wifi2"><b>인터넷/wifi</b></div>

            <div class="print"><i id="printcon" class='fas fa-print' style='font-size:48px'></i></div> <br>
            <div class="print2"><b>프린트</b></div>

            <div class="car"><i id="carcon" class="fas fa-car" style='font-size:60px'></i></div>
            <div class="car2"><b>주차</b></div>

            <div class="com"><i id="comcon" class="fas fa-laptop" style='font-size:48px'></i></div>
            <div class="com2"><b>PC/노트북</b></div> <br>

            <div class="bar"><i id="barcon" class="fas fa-coffee" style='font-size:48px'></i></div>
            <div class="bar2"><b>bar</b></div>

            <div class="meeting"><i id="meetcon" class="fas fa-microphone" style="font-size:48px"></i></div>
            <div class="meeting2"><b>회의실</b></div>

            <div class="wind"><i id="windcon" class='fas fa-wind' style='font-size:48px'></i></div>
            <div class="wind2"><b>냉/난방시설</b></div>

            <div class="people"><i id="peoplecon" class="fas fa-user" style='font-size:48px'></i></div>
            <div class="people2"><b>매니저</b></div>

        </div>

        <br><br>
        <!--위치(지도)-->
       <div><h3><b>위치</b></h3> <br>
        <div id="map" style="width:400px;height:400px;"></div> <br><br></div>

       <br>
        <!--후기-->
        <div id="section2"><h3><b>의견 및 소감</b></h3></div>

        <hr>
        

        <c:forEach var="r" items="${ rv }">
	        <div class="review">
	            <div class="hz" id="section2">
	            	<a href="#section1"></a>
	            </div>
	            <b>${r.reviewWriter}</b> <br>
	            ${r.createDate} <br>
	           	<span class="star-prototype">${r.reviewStar}</span><br>
	           	${r.reviewContent}
	        </div>

	        <hr>
		</c:forEach>

</div>
       <br><br><br><br><br><br>
      <jsp:include page="../common/footer.jsp"/>

<script>

<%-- 날짜 가져오기 --%>
var startDate = localStorage.getItem("startDate");
var endDate = localStorage.getItem("endDate");
console.log(startDate);
$.when($.ready).then(function(){
   $("input[name=startDate]").val(startDate);
   $("input[name=endDate]").val(endDate);
   
   flatpickr(".startDate",{
	    locale:"ko",
	    altInput:true,
	    altFormat:"Y F d\\일",
	    minDate:"today",
	    dateFormat:"Y-m-d"
	});

	flatpickr(".endDate",{
	    locale:"ko",
	    clickOpens: true,
	    altInput:true,
	    altFormat:"Y F d\\일",
	    minDate:"today",
	    dateFormat:"Y-m-d"
	});
})



<%--시설 안내 관련 if문 --%>
<c:if test="${ fn:contains(o.facility, '와이파이') }">
   $("#wifiIcon").css("color","red");
</c:if>
<c:if test="${ fn:contains(o.facility, '프린트') }">
   $("#printcon").css("color","red");
</c:if>
<c:if test="${ fn:contains(o.facility, '주차') }">
   $("#carcon").css("color","red");
</c:if>
<c:if test="${ fn:contains(o.facility, 'PC/노트북') }">
   $("#comcon").css("color","red");
</c:if>
<c:if test="${ fn:contains(o.facility, 'bar') }">
   $("#barcon").css("color","red");
</c:if>
<c:if test="${ fn:contains(o.facility, '회의실') }">
   $("#meetcon").css("color","red");
</c:if>
<c:if test="${ fn:contains(o.facility, '냉/난방시설') }">
   $("#windcon").css("color","red");
</c:if>
<c:if test="${ fn:contains(o.facility, '매니저') }">
   $("#peoplecon").css("color","red");
</c:if>

<%--별점 관련 function--%>
$.fn.generateStars = function() {
    return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*16));});
};

// 숫자 평점을 별로 변환하도록 호출하는 함수
$('.star-prototype').generateStars();

<%--스크롤 이동--%>
/*
 $(document).ready(function(){
    $("#reviewScroll").on('click', function(event) {
      if (this.hash !== "") {
        event.preventDefault();
        var hash = this.hash;
        $('html, body').animate({
          scrollTop: $(hash).offset().top
        }, 800, function(){
          window.location.hash = hash;
        });
      }
    });
  }); 
*/
<%-- kakao map --%>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
   mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
         };

// 지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${ o.address }', function(result, status) {

// 정상적으로 검색이 완료됐으면
   if (status === kakao.maps.services.Status.OK) {

var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
console.log(coords);
// 결과값으로 받은 위치를 마커로 표시합니다
var marker = new kakao.maps.Marker({
    map: map,
    position: coords
});

// 인포윈도우로 장소에 대한 설명을 표시합니다
var infowindow = new kakao.maps.InfoWindow({
    content: '<div style="width:150px;text-align:center;padding:6px 0;">${o.branch}</div>'
});
infowindow.open(map, marker);

// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
map.setCenter(coords);
   }
});
</script>
</body>
</html>
