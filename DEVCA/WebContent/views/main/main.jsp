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

<!-- START :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
<c:if test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver}">
	<jsp:forward page="/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->

</head>
<body>	
	<section>
		<!-- 회원 전용 페이지 -->
		<c:out value="${sessionLoginMember.MEMBER_NAME }"></c:out>
		
		<c:out value="${sessionLoginKakao.KAKAO_NICKNAME}"></c:out>
		<c:out value="${sessionLoginKakao.KAKAO_ID}"></c:out>
		
		<c:set var="access_token" value="${sessionScope.access_token}"></c:set>
		<c:out value="${access_token}"></c:out>
		<article id="roadmap">
			로드맵		
		</article>
		<article id="persnoal">
			<div>
				프로필 정보
			</div>
			<div>
				학습 플래너
			</div>		
		</article><article id="lecture-board">
			<div>
				추천 강의
			</div>
			<div>
				보관 강의
			</div>
			<div>
				같은 포지션 인기강의
			</div>
			<div>
				프론트앤드 인기강의
			</div>
			<div>
				백엔드 인기강의
			</div>
		</article>
		
	</section>
	
	<!-- FOOTER FORM -->	
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>