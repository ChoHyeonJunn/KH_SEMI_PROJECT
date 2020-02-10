<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- START :: css -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">

<style type="text/css">
section{
	width: 100%;
	height: 500px;
}
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="sessionLoginMember" value="${sessionScope.loginMember}"></c:set>
<c:set var="sessionLoginKakao" value="${sessionScope.loginKakao}"></c:set>
<c:set var="sessionLoginNaver" value="${sessionScope.loginNaver}"></c:set>
<!-- END :: set JSTL variable -->

<!-- START :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
<c:if test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver}">
	<jsp:forward page="/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->

</head>
<body>
	<%@ include file="/views/Form/header.jsp"%>
	
	<section>
		<!-- 회원 전용 페이지 -->
		<c:out value="${sessionLoginMember.MEMBER_NAME }"></c:out>
		<c:out value="${sessionLoginKakao.KAKAO_NICKNAME}"></c:out>
		<c:out value="${sessionLoginKakao.KAKAO_ID}"></c:out>
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
	<%@ include file="/views/Form/footer.jsp"%>
</body>
</html>