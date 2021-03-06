<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta property="og:title" content="DEVCA">
<meta property="og:description" content="10년 후 인정받는 개발자가 되기 위해 나의 어떤 스킬을 업그레이드 시켜야할까? 나의 스킬에 맞는 정보를 찾아드립니다.">
<meta property="og:image" content="https://devca.ca/wp-content/uploads/2019/09/devca2.png">

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
	
	<!-- 비회원 전용 페이지 -->
	<section>
		<div class="card p-4 my-3 mx-1 bg-dark" style="height: 100%;">
		
			<div class="text-center my-auto">
				<div class="font-weight-bold text-light py-3">
					<h5 class="py-1">10년 후 인정받는 개발자가 되기 위해</h5>
					<h5 class="py-1">나의 어떤 스킬을 업그레이드 시켜야할까?</h5>
					<h5 class="py-1">나의 스킬에 맞는 정보를 찾아드립니다.</h5>
				</div>
				<div>
					<button class="btn btn-lg" onclick="location.href='/DEVCA/main/survey.do'">스킬 체크해보기</button>
				</div>
			</div>
		</div>
	</section>
	
	<!-- FOOTER FORM -->		
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>