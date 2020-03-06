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
</head>
<body>

	<section>
	
	<!-- 질문을 누르면 답변창이 펼쳐지는 FAQ 페이지-->
	<!-- 기본 형식 -->
	<!--
	
		<div id="question0"
	 	 onclick="if(answer0.style.display=='none'){answer0.style.display='';} 
		 else{answer0.style.display='none';}">
			Q. 질문 내용
		</div> 
		
		<div id="answer0" style="display: none">
			A.	답변 내용
		</div> 
		--> 
		

		<div id="question1"
		 onclick="if(answer1.style.display=='none'){answer1.style.display='';} 
		 else{answer1.style.display='none';}">
			Q. 질문 1
		</div>
		<div id="answer1" style="display: none">
			A. 답변 1
		</div> 
		
		<div id="question2"
			onclick="if(answer2.style.display=='none'){answer2.style.display='';} 
			else{answer2.style.display='none';}">
			Q. 질문 2
		</div>
		<div id="answer2" style="display: none">
			A. 답변 2
		</div>

	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>