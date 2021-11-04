<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	  aside{
            float: left;
            margin-right: 30px;
        }
        .aside-title{
            padding: 30px 0px;
        }
        .outer{
            width: 1200px;
        }
        .outer {
            box-sizing: border-box;
        }
        .inner{width: 1200px; margin: auto;}
        #waitingReply{ color:rgb(141, 137, 137)}
        #doneReply{color: rgb(220, 53, 69); font-weight: bolder;}
        #csMemContent,#csAdminContent{width: 1100px; height: 400px; margin: auto;}
        .outer{
            width: 1200px;
        }
        .customerContent {
            margin: auto;
            text-align: center;
        }
        .adminContent{
            margin: auto;
            text-align: center;
        }
        .adminReply>form>button{margin: auto;}
        .customerContent,.adminContent{
            width: 1200px;
            box-sizing: border-box;
            margin: auto;
        }
        #answerBtn{
            background-color:  rgb(220, 53, 69);
            color: white;
            border: 1px solid  rgb(220, 53, 69);
            border-radius: 3px;
        }
        #updateBtn{
            border-radius: 3px;
            border: 1px solid lightgray;
        }
       #csT{font-size:22px;}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
	<Br>
	<c:if test="${ !empty loginUser }">
	<div class="innerOuter">
		<div class="outer">
	        <div class="aside-title">
	            <h3>1:1문의 </h3>
	        </div>
	        <br>
	        <div class="inner">
	            <table>
	                <tr style="height: 50px;">
	                    <td colspan="3"><b id="csT">${cs.csTitle }</b></td>
	                </tr>
	                <tr>
	                    <td style="width: 150px;"><b>작성자 : ${cs.memName }</b></td>
	                    <td style="width: 950px;"><b>작성일 : ${cs.regDate }</b></td>
	                    <c:choose>
	                    	<c:when test="${cs.status == 'Y' }">
	                    		<td id="doneReply">답변 완료</td>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<td id="waitingReply">대기중</td>
	                    	</c:otherwise>
	                    </c:choose>
	                </tr>
	            </table> 
	            <hr>
	            <br>
	            <div class="customerContent">
	                <input id="csMemContent" type="text" value="${cs.csContent }" readonly>
	            </div>
	            <br>
	            <B style="margin-left: 50px;">답변</B>
	            <br>
	            <div class="adminContent">
	            	<c:choose>
		            	<c:when test="${cs.status== 'Y' && cs.ansContent != null  }">
	            			<form action="updateCsAns.ad">
	            				<input type="hidden" value="${cs.csNo }" name="csNo">
		                        <input id="csAdminContent" name="ansContent" type="text" value="${cs.ansContent }" readonly >
		                        <br><br> 
		                        <c:if test="${ !empty loginUser && (loginUser.userStatus == 'Y') }">
		                        	<button id="updateBtn" type="button" onclick="updateCsAns();" >수정하기</button>
		                        	<button id="answerBtn" type="submit" class="btn-danger" style="display:none" >답변하기</button>
		                        </c:if>
		                    </form>
	            		</c:when>
	            		<c:otherwise>
	            			<form action="insertCsAns.ad">
	            				<input type="hidden" value="${cs.csNo }" name="csNo">
			                    <input id="csAdminContent" name="ansContent"  type="text" placeholder="관리자 분은 1:1문의 사항에 대해 답변 후 답변하기 버튼을 눌러주시면 됩니다.">
			                    <br><br> 
			                    <c:if test="${ !empty loginUser && (loginUser.userStatus == 'Y') }">
			                    	<button id="answerBtn" type="submit" class="btn-danger">답변하기</button>
			                    </c:if>
		                    </form>
	            		</c:otherwise>
	            		
	            	</c:choose>
	            	<script>
	            		// 답변하기 버튼이 문서 로딩과 동시에 사라져야함
						function updateCsAns(){
							// 수정하기 버튼은 사라지고
							$("#updateBtn").hide();
							// 답변하기 버튼이 나타남
							$("#answerBtn").removeAttr('style');
							// readOnly 속성이 사라져야함
							$("input[name='ansContent']").attr("readonly",false);
							
							
						}
	
	    			</script>
	                <!--관리자가 사용자에게 답변을 하기 전임(input에 아무런 값도 들어가 있지 않은경우로만 구분이 가능할까?)-->
	                <!--
	                    <form>
	                    <input id="csAdminContent" value="" type="text" placeholder="관리자 분은 1:1문의 사항에 대해 답변 후 답변하기 버튼을 눌러주시면 됩니다.">
	                    <br><br> 
	                    <button id="answerBtn" type="submit" class="btn-danger">답변하기</button>
	                    </form>
	                -->
	                <!--관리자가 답변을 달고 난 뒤에 보여지는 화면(관리자가 작성한 답변을 select해서 가져 와야함 )// 수정하기 버튼 클릭시 해당 form이 작성하기 하단에 폼으로 변경-->
	                <!--
	                   <form>
	                        <input id="csAdminContent" type="text" value="관리자가 작성한 답변이 보여질거야" readonly >
	                        <br><br> 
	                        <button id="updateBtn" type="submit" >수정하기</button>
	                    </form> 
	                -->
	                <!--수정할 때 보여지는 화면(사용자가 쓴 글이 불러와져야 하고 제출하면 update까지 되야함)-->
	                <!-- 
	                	<form>
	                    <input id="csAdminContent" type="text" value="사용자가 아까 작성했던 거 다시 select해와서 뿌릴거지">
	                    <br><br> 
	                    <button id="answerBtn" type="submit" class="btn-danger">수정완료</button>
	                    	//이걸 같은 id의 버튼으로 submit해도 되려남
	                    </form>
	                 -->
	                    
	            </div>
	
	        </div>
	    </div>
	    
	   
	
	<br><br><Br><br><br><Br>
	</div>
	</c:if>
	
	
	
	
</body>
</html>