<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#EnterpriseImg{
	width: 45px;
	height: 20px;
}
</style>
</head>
<body>
	<footer>
		<div class="bg-dark text-center font-weight-bold p-4 text-light">
			<div>KH정보교육원 &copy; all rights reserved...</div>
			
			<hr class="my-3 text-light gb-light">
			
			
			<!-- 제작 관련 사이트들의 아이콘 표시 -->
			<div>제작 관련...</div>
			<div class="d-flex justify-content-center mx-5 my-3 px-5">
				<!-- 사람인 -->
				<div class="mx-2">
					<img id="EnterpriseImg" alt="naver" src="../resources/images/crawlingSiteIcon/naver.png">
				</div>
				<div class="mx-2">
					<img id="EnterpriseImg" alt="kakao" src="../resources/images/crawlingSiteIcon/kakao.png">
				</div>
				<div class="mx-2">
					<img id="EnterpriseImg" alt="amchart" src="../resources/images/crawlingSiteIcon/amchart.png">
				</div>
				<div class="mx-2">
					iamport
				</div>
				<div class="mx-2">
					saramin
				</div>
				<div class="mx-2">
					programmers
				</div>
				<div class="mx-2">
					wiki
				</div>
				<div class="mx-2">
					summernote
				</div>
				<div class="mx-2">
					w3cSchool
				</div>
				<div class="mx-2">
					OLC CENTER
				</div>
				<div class="mx-2">
					Udemy
				</div>
			</div>
		</div> 
	</footer>
</body>
</html>