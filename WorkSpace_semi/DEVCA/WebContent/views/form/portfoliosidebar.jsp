<%@page import="com.devca.model.dto.MEMBER"%>
<%@page import="org.apache.catalina.SessionListener"%>
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
<!-- START :: css -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="sessionLoginMember" value="${sessionScope.loginMember}"></c:set>
<c:set var="sessionLoginKakao" value="${sessionScope.loginKakao}"></c:set>
<c:set var="sessionLoginNaver" value="${sessionScope.loginNaver}"></c:set>
<!-- END :: set JSTL variable -->

</head>
<body>
	<aside>
		<div>
			<div>
				<a href="/DEVCA/portfolio/portfoliopage.do?member_code=${sessionLoginMember.MEMBER_CODE }">경력</a>
			</div>
			<div>
				<a href="/DEVCA/portfolio/sideprojectpage.do?member_code=${sessionLoginMember.MEMBER_CODE }">개인 프로젝트</a>
			</div>
			<div>
				<a href="/DEVCA/portfolio/sideskillpage.do?member_code=${sessionLoginMember.MEMBER_CODE }">주요기술</a>
			</div>
			<div>
				<a href="/DEVCA/portfolio/sidelanguagepage.do?member_code=${sessionLoginMember.MEMBER_CODE }">외국어</a>
			</div>
			<div>
				<a href="/DEVCA/portfolio/sideschoolpage.do?member_code=${sessionLoginMember.MEMBER_CODE }">학력</a>
			</div>
			<div>
				<a href="/DEVCA/portfolio/sideactionpage.do?member_code=${sessionLoginMember.MEMBER_CODE }">활동</a>
			</div>
			<div>
				<a href="/DEVCA/portfolio/sidecertificatepage.do?member_code=${sessionLoginMember.MEMBER_CODE }">수상경력/자격증</a>
			</div>
			<div>
				<a href="/DEVCA/portfolio/sideworkpage.do?member_code=${sessionLoginMember.MEMBER_CODE }">직종/연봉</a>
			</div>
		</div>
		<div>
			<div>
				<a href="#">로드맵</a>
			</div>
			<div>
				<a href="#">설문조사</a>
			</div>
		</div>
	</aside>
</body>
</html>