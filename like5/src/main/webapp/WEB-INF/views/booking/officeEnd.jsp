<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /*전체 공간*/
    .reservation{
		width:100% !important;
		height:750px !important;
		margin:auto !important;
        position:relative !important;
		margin-top:50px !important;
		border:1px solid lightgray;
		padding:140px !important;
		align-items:center;
    }
    /*예약 정보 box*/
    .box{
        width:750px;
        height:300px;
        border:1px solid lightgray;
        padding:20px;
        margin:auto;
		position:relative;	
    }
    /*예약 가운데 선*/
    .updown{ 
        border:1px solid lightgrey; 
        width: 0.1px; 
        height: 250px; 
        margin-left:345px; 
        margin-top:-260px;
    }
    /*내 예약 정보*/
    .wrap{
        margin-left:25px;
    }
    /*결제 금액*/
    .wrap2{
        margin-left:410px; 
        margin-top:-255px;
    }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>	
    <!--예약 완료 페이지-->
    <div class="reservation">
        <span style="color:black;" align="center"><h2><b>예약요청이 정상적으로 완료되었습니다.</b></h2></span>

        <br><hr><br>

        <!--예약 부분 box-->
        <div class="box"> <br>

             <!--내 예약정보-->
            <div class="wrap">
                <b>내 예약정보</b> <br><br>
                <b>회원</b> ${ loginUser.memName } <br><br>
                <b>날짜</b> <br>
                ${ b.startDate } ~ ${ b.endDate }<br><br>
                <b>인원</b> <br>
                ${ b.person } 명
            </div>

            <br><br>

            <!--가운데 선-->
            <div class="updown"></div> <br>

            <!-- 결제 금액-->
            <div class="wrap2">
                <b>결제 금액</b>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <b>${ b.total } 원</b> <br><br>
                <b>1일</b> 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               	<div class="price">${ o.price } 원</div><br><br> 
                <b>부가세(10%)</b>
                &nbsp;&nbsp;&nbsp;&nbsp; 
                <div class="fee">${(o.price *0.1)} 원</div><br><br>
            </div>
        </div>
        <br><br>
        <div align="center">
        	<a type="button" href="bMain.bk" class="btn btn-danger">공간 대여 페이지로</a>
        </div>
        
    </div>
<jsp:include page="../common/footer.jsp"/>
<script>

</script>    
</body>
</html>    