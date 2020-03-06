<%@page import="com.devca.model.dto.member.MEMBER"%>
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

	<aside class="col-md-2">
		<div class="card p-4 my-3 bg-white">
         	<div class="card-title">
	           	<h4>프로필</h4>
	         </div>
         
         <ul class="list-group">
         	<li class="list-group-item">
				<a href="/DEVCA/portfolio/portfoliopage.do?member_code=${sessionLoginMember.MEMBER_CODE }">경력</a>
         	</li>
         	<li class="list-group-item">
				<a href="/DEVCA/portfolio/sideprojectpage.do?member_code=${sessionLoginMember.MEMBER_CODE }">개인 프로젝트</a>
         	</li>
         	<li class="list-group-item">
				<a href="/DEVCA/portfolio/sideskillpage.do?member_code=${sessionLoginMember.MEMBER_CODE }">주요기술</a>
         	</li>
         	<li class="list-group-item">
				<a href="/DEVCA/portfolio/sidelanguagepage.do?member_code=${sessionLoginMember.MEMBER_CODE }">외국어</a>
         	</li>
         	<li class="list-group-item">
				<a href="/DEVCA/portfolio/sideschoolpage.do?member_code=${sessionLoginMember.MEMBER_CODE }">학력</a>
         	</li>
         	<li class="list-group-item">
				<a href="/DEVCA/portfolio/sideactionpage.do?member_code=${sessionLoginMember.MEMBER_CODE }">활동</a>
         	</li>
         	<li class="list-group-item">
				<a href="/DEVCA/portfolio/sidecertificatepage.do?member_code=${sessionLoginMember.MEMBER_CODE }">수상경력/자격증</a>
         	</li>
         	<li class="list-group-item">
         		<a href="/DEVCA/portfolio/sideworkpage.do?member_code=${sessionLoginMember.MEMBER_CODE }">직종/연봉</a>
         	</li>
         </ul>
         
         <ul class="list-group">
         	<li class="list-group-item">
				<a href="#">로드맵</a>
         	</li>
         	<li class="list-group-item">
				<a href="#">설문조사</a>
         	</li>
         </ul>

		</div>
	</aside>

</html>