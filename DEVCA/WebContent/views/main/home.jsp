<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- HEADER FORM -->
<%@ include file="/views/form/header.jsp"%>

<!-- START :: css -->
<style type="text/css">
section{
	width: 100%;
	height: 500px;
}
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

</script>
<!-- END :: JAVASCRIPT -->

<!-- START :: 회원이 잘못된 경로를 통해 접근했을 때 block -->
<c:if test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver}">
	<jsp:forward page="/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 회원이 잘못된 경로를 통해 접근했을 때 block -->

</head>
<body>
	
	<section>
		<!-- 비회원 전용 페이지 -->
		<div>			
			<div>
				<p>10년 후 인정받는 개발자가 되기 위해</p>
				<p>나의 어떤 스킬을 업그레이드 시켜야할까?</p>
				<p>나의 스킬에 맞는 정보를 찾아드립니다.</p>
			</div>
			<div>
				<button onclick="location.href='/DEVCA/main/survey.do'">스킬 체크해보기</button>
			</div>
		</div>
		
	</section>
	
	<!-- FOOTER FORM -->		
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>