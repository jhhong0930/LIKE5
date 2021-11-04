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
	.hide{
		display:none !important;
	}
	.search-result{
		display:flex;
		position:abolute;
		margin-top:12px;
		box-shadow: rgb(0 0 0 / 20%) 0px 6px 20px !important;
        padding: 20px 22px;
		justify-content: space-around;
		border-radius: 32px;
        background-color: #ffff;
        border:1px solid rgb(221,221,221);
        width: 300px;
	}
	
	.pop_keywords{
		position: relative;
		list-style: none;
		width:100%;
		margin: 0 -32px -8px !important;
        padding:8px 0;
	}
	.pop_keywords > li {
		display:flex;
		line-height:40px;
		margin:5px;
		cursor:pointer;
	}
    .outerbox{
        position: relative;
        background: linear-gradient(rgba(255,255,255, 0.5), rgba(255, 255, 255, 0.5)), url(resources/images/bg-1.jpg) center/cover no-repeat fixed;
        z-index: 0.8;
        height: 90vh;
        background-attachment:scroll;
    }
    /* .innerbox{
        position: absolute;
        border:1px solid black;
        top:50px;
        left:300px;
    } */

    form{
        max-width: 850px;
        margin: 0 auto;
        display: block;
        padding-top:100px;
    }

    .date{
    display: flex;
    justify-content: space-evenly;
    height:66px;
    width: 100%;
    align-items: center;
    box-shadow: 0px 16px 32px rgb(0 0 0 / 15%), 0px 3px 8px rgb(0 0 0 / 10%) !important;
    background-color: #FFFFFF !important;
    border-radius: 32px;
    }
    .branch, .checkIn, .checkOut, .person{
        width:100%;
        height:100%;
        overflow: auto;
        margin:-1px;
        padding: 14px 32px;
    }

    .date input, .branch select, .branch-select li:hover{
        border-radius: 32px;
        border: #FFFFFF;
        width:100%;
        height:100%;
        background-color: #FFFFFF !important;
    }

    .date input:hover{
        background-color: #F7F7F7 !important;
    }
    .box{
        display: flex;
        justify-content: space-between;
        position: absolute;
        margin-top:12px;
        box-shadow: rgb(0 0 0 / 20%) 0px 6px 20px !important;
        padding: 16px 32px;
        border-radius: 32px;
        background-color: rgb(255, 255, 255);
        margin:12px 0 0 -153px;
        width: 330px;
        right:0;
    }
    .text{
        font-size: 14px;
    }
    .stp{
        display: flex;
        justify-content: space-between;
        width:110px;
        height: 32px;
        align-self: center;
    }
    .stp .circle{
        display: inline-flex;
        border-radius: 50%;
        border: 1px solid rgb(176, 176, 176) !important;
        width: 32px;
        height: 32px;
        justify-content: center;
        color:rgb(113,113,113);
        background-color: transparent;
        align-items: center;
    }
    .howmany input{
        border: none;
        border-radius: 50%;
        width:32px;
        height:32px;
        text-align: center;
        justify-content: center;
        font-weight: 400;
        color:rgb(34,34,34);
    }

    .sicon{
        padding-right: 10px;
    }
    .sicon>button{
        border-radius: 50%;
        width: 48px;
        height:48px;
        background-color: #eb3e3e;
        border:none;
    }
    .sicon button i{
       color: #FFFFFF !important;
       }
    .desc-wrapper-1{
        display: flex;
        margin:0 60px;
        box-sizing: border-box;
        justify-content: space-around;
        align-items: stretch;
        padding-top: calc(50% / (16 / 9));
    }
    .desc-wrapper-2{
        display: flex;
        margin:0 60px;
        box-sizing: border-box;
        justify-content: space-around;
        align-items: stretch;
        padding-top: calc(50% / (16 / 9));
        padding-bottom: calc(50% / (16 / 9));
    }
    .desc-1, .desc-3{
        order:1;
        padding-left: 0;
        padding-right: 2rem;
        align-self: center;
    }
    .desc-img-1, .desc-img-3{
        order:2;
        
    }
    .desc-img-1 img, .desc-img-3 img{
        max-width:400px;
        max-height:40vw;
    }

    .desc-img-2 img{
        max-width: 600px;
        max-height: 40vw;
    }
    .desc-2{
        align-self: center;
        padding-left: 2rem;
    }
    .branch-select ul{
        position: relative;
        list-style: none;
        width:500px;
        margin: 0 -32px -8px !important;
        padding:8px 0;
    }
    .branch-select li{
        width: 100%;
        padding: 8px 16px 8px 32px !important;
        display: flex;
        cursor: pointer;
    }
    .marker{
        width:60px;
        height:48px;
        background-color: rgb(241, 241, 241);
        border-radius: 8px;
        margin-right:16px;
        display:flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
    }
    .region{
        width: 100%;
        text-align: center;
        justify-content: center;
        color:rgb(34,34,34);
    }
    .branch-select{
        position:absolute;
        margin-top:12px;
        box-shadow: rgb(0 0 0 / 20%) 0px 6px 20px !important;
        padding: 30px 32px;
        border-radius: 32px;
        background-color: #ffff;
        border:1px solid rgb(221,221,221)
    }
    #branch-modal{
        display: none;
    }
    #person-modal{
        display: none;
        position: relative !important;
    }
    .show-modal{
        display: block !important;
    }

</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
    <div class="outerbox">
        <div class="innerbox">
            <!-- form태그로 묶긴했는데 안해도 되나?-->
            <form action="searchOffice.bk" method="post">
                <div class="date">
                    <div class="branch">
                        <input type="text" name="branch" id="branch" placeholder="위치">
                    </div>
                    <div class="checkIn">
                        <input class="fcheckIn" type="text" name="startDate" placeholder="체크인">
                    </div>
                    <div class="checkOut">
                        <input class="fcheckOut" type="text" name="endDate" id="" placeholder="체크아웃">
                    </div>
                    <div class="person">
                        <input type="text" name="person" id="pnum" placeholder="인원수">
                    </div>
                    <div class="sicon">
                        <button type="submit"><i class="fas fa-search"></i></button>
                    </div>
                </div>
        <!-- 지역 선택 박스 -->
                <div class="search-result">
                	<ul class="pop_keywords"></ul>
                </div>
        <!-- 인원수 체크 박스 -->
                <div id="person-modal">
                    <div class="box">
                        <div class="text">
                            <div class="tt">성인</div>
                            <div class="tdesc">만 13세 이상</div>
                        </div>
                        <div class="stp">
                            <button type="button" class='circle' onclick="minus();">
                                <span>-</span>
                            </button>
                            <div id="pp2" class="howmany">
                                <input type="text" id="num1" value="0">
                            </div>
                            <button type="button" class="circle" onclick="plus();">
                                <span>+</span>
                            </button>
                        </div>
                    </div>
                </div>
            </form>

        </div>
    </div>
    <div class="content innerOuter">
        <div class="desc-wrapper-1">
            <div class="desc-img-1"> <img src="resources/images/desc-1.jpg"></div>
            <div class="desc-1">
                <h2>더 생산성있는 업무 공간</h2>
                <p>
                   	다양한 개발자들과 만나서 일 할 수 있습니다.
                </p>
            </div>
        </div>
    
        <div class="desc-wrapper-1">
            <div class="desc-img-2"> <img src="resources/images/desc-2.jpg"></div>
            <div class="desc-2">
                <h2>충분한 휴식공간</h2>
                <p>
                  	충분한 휴식은 최대의 업무 효율을 낼 수 있습니다. like5에서 느껴보세요!
                </p>
            </div>
        </div>
    
        <div class="desc-wrapper-2">
            <div class="desc-img-3"> <img src="resources/images/desc-3.jpg"></div>
            <div class="desc-3">
                <h2>원하는 기간 만큼 자유롭게!</h2>
                <p>
                  	디지털 노마드의 꿈을 펼쳐보세요
                </p>
            </div>
        </div>
    </div>
<jsp:include page="../common/footer.jsp"/>
<script>

const checkInput = () => {
    const beforeInput = $("#branch").val();
    timer(beforeInput);
};
$("#branch").on("keyup", function(){
	console.log("!!");
	$(".search-result").removeClass("hide");
})

const timer = (beforeInput) => {
    setTimeout(() => {
        if ($("#branch").val() === beforeInput) {
            console.log("잠깐멈춤??");
            loadData($("#branch").val());
            checkInput();
        } else {
            console.log("다시입력시작");
            checkInput();
        }
        if ($("#branch").val() === "") {
            $(".search-result").addClass("hide");
        }
    }, 500);
};

const loadData = (input) =>{
    $.ajax({
    	url:"autoBranch.bk",
    	data: {searchKeyword: input},
    	type: "GET",
    	success:function(list){
    		console.log(list);
    		var result = "";
    		if(list!=null){
    			for(var i=0; i<list.length; i++){
    			result += 
                    "<li>"
                    +    "<div class='marker'><i class='fas fa-map-marker-alt'></i></div>"
                    +    "<div class='region'>"+ list[i].branch + "</div>"
                   +"</li>"
    			};
    			$(".pop_keywords").html(result);
    		} else {
    			$(".pop_keywords").html("<li>" + "검색결과가없습니다" + "</li>");
    		}
    		
    		<%-- 지역 선택 --%>
    		for(let i=0; i<regions.length; i++){
    		    regions[i].addEventListener('click', function(){
    		        branch.value = regions[i].innerHTML
    		    })
    		}
    		
    	}, error:function(){
    		console.log("ajax실패");
    	}
    })
};

checkInput();

<%--
$("#branch").on("keydown", function autoComplete(){
    $.ajax({
    	url:"autoBranch.bk",
    	data: {searchKeyword: $("#branch").val()},
    	type: "GET",
    	success:function(list){
    		console.log(list);
    		var result = "";
    		if(list!=null){
    			for(var i=0; i<list.length; i++){
    			result += 
                    "<li>"
                    +    "<div class='marker'><i class='fas fa-map-marker-alt'></i></div>"
                    +    "<div class='region'>"+ list[i].branch + "</div>"
                   +"</li>"
    			};
    			$(".branch-select ul").html(result);
    		} else {
    			$(".branch-select ul li").text("검색결과가없습니다");
    		}
    		
    	}, error:function(){
    		console.log("ajax실패");
    	}
    })
}); --%>
const outerbox = document.querySelector(".outerbox");
const pmodal = document.querySelector("#person-modal");//인원수 모달
let pp = document.querySelector("#pnum"); //인원수 input
let branch = document.querySelector("#branch"); //지점 선택 input
const bmodal = document.querySelector(".search-result"); //지점 모달
let pp2 = document.querySelector("#num1");
let regions = document.getElementsByClassName("region");
<%--
branch.onclick = () => {
    bmodal.classList.add('show-modal');
}--%>
bmodal.onclick = () => {
    bmodal.classList.add('hide');
} 
pp.onclick = () =>{
    pmodal.classList.add('show-modal');
}
window.onclick = (e) => {
    e.target === outerbox ? bmodal.classList.remove('show-modal') : false
    e.target === outerbox ? pmodal.classList.remove('show-modal') : false
}

<%-- 지역 선택 --%>
for(let i=0; i<regions.length; i++){
    regions[i].addEventListener('click', function(){
        branch.value = regions[i].innerHTML
    })
}

<%-- 인원수 선택 --%>
    function minus(){
        
        if(pp2.value > 0){
            pp2.value = Math.abs(Number(pp2.value)-1);
        }
        pp.value = pp2.value;
    }

    function plus(){
        
        pp2.value = Number(pp2.value)+1;
        pp.value = pp2.value;
    }

    const checkIn = document.querySelector('.fcheckIn');
    const checkOut = document.querySelector('.fcheckOut');
    flatpickr(checkIn,{
        locale:"ko",
        altInput:true,
        altFormat:"Y F d\\일",
        minDate:"today",
        //mode: "range",
        dateFormat:"Y-m-d"
    });

    flatpickr(".fcheckOut",{
        locale:"ko",
        altInput:true,
        altFormat:"Y F d\\일",
        minDate:"today",
        //mode: "range",
        dateFormat:"Y-m-d"
    });
    


</script>
</body>
</html>