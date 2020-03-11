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
<!-- HEADER FORM -->
<%@ include file="/views/form/header.jsp"%>

<!-- START :: css -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet"
	type="text/css">
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	
</script>

<!-- END :: JAVASCRIPT -->

<style type="text/css">
</style>
</head>
<body>

	<section>

		<!-- 질문을 누르면 답변창이 펼쳐지는 FAQ 페이지-->
		<!-- 기본 형식 -->
		<!--
	
		<div class="card p-4 my-3 mx-1" id="question0"
	 	 onclick="if(answer0.style.display=='none'){answer0.style.display='';} 
		 else{answer0.style.display='none';}">
			<h3>Q. 질문 내용</h3>
		
		
			<div class="card p-4 my-3 mx-1" id="answer0" style="display: none; color: white; background-color: #862d86">
				<h3>A. 답변 내용</h3>
			</div> 
		</div> 
		-->

		<div class="card p-4 my-3 mx-1 bg-dark" style="height: 100%;">
			<div class="card p-4 my-3 mx-1" id="question1"
				onclick="if(answer1.style.display=='none'){answer1.style.display='';} 
		 else{answer1.style.display='none';}">
				<h3>Q. DEVCA 구독 비용은 얼마인가요?</h3>
				<div class="card p-4 my-3 mx-1" id="answer1"
					style="display: none; color: white; background-color: #862d86">
					<h3>A. DEVCA 구독 비용은 한달에 100원입니다.</h3>
				</div>
			</div>

			<div class="card p-4 my-3 mx-1" id="question2"
				onclick="if(answer2.style.display=='none'){answer2.style.display='';} 
			else{answer2.style.display='none';}">
				<h3>Q. DEVCA 계정 정보를 변경하려면 어떻게 해야 하나요?</h3>
				<div class="card p-4 my-3 mx-1" id="answer2"
					style="display: none; color: white; background-color: #862d86">
					<h3>
						A. <a href="/DEVCA/member/privacyprofilepage.do" style="color: white; text-decoration: underline;">여기</a>에서
						회원 정보를 변경할 수 있습니다.<br /> &nbsp;&nbsp;&nbsp; 로그인 상태가 아니라면 먼저 <a
							href="/DEVCA/member/loginpage.do" style="color: white; text-decoration: underline;">로그인</a>을 하신 후 회원 정보를 변경할 수
						있습니다.

					</h3>
				</div>
			</div>
		</div>
	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>