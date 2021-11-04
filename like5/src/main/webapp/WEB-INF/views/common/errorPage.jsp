<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error Page</title>

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Tomorrow:wght@500&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- errorPage.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/errorPage.css" />  

<title>Error Page</title>
</head>
<body>
	<!-- [한솔] 에러페이지 -->
	<div class="text">
		<br><br><br><br><br><br><br>
		<h2>L I K E 5</h2>
		<br>
		<h1>ERROR</h1>
		<br>
		<p>${ errorMsg }<p>
		<div style="border-bottom:2px solid gray; margin-top:40px;"></div>
		<br><br>
		<button onclick="back()" class="btn btn-light" >&nbsp;Go Back&nbsp;</button>
	</div>
	
	<div class="astronaut">
	  <img src="https://images.vexels.com/media/users/3/152639/isolated/preview/506b575739e90613428cdb399175e2c8-space-astronaut-cartoon-by-vexels.png" alt="" class="src">
	</div>
	
	
	<!-- JS -->
	<script>
	// 화면 js
	document.addEventListener("DOMContentLoaded",function(){
		var body=document.body;
		 	setInterval(createStar,100);
		function createStar(){
			var right=Math.random()*500;
			var top=Math.random()*screen.height;
		    var star=document.createElement("div");
		 	
		    star.classList.add("star")
		  	body.appendChild(star);
		  	setInterval(runStar,10);
		    star.style.top=top+"px";
		    
		  	function runStar(){
		    	if(right>=screen.width){
		      		star.remove();
		    	}
			    right+=3;
			    star.style.right=right+"px";
			}
		} 
	})
	
	// 뒤로가기
	function back() {
		history.back();
	}
	</script>

</body>
</html>