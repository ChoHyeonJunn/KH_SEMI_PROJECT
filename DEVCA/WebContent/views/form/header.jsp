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

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="sessionLoginMember" value="${sessionScope.loginMember}"></c:set>
<c:set var="sessionLoginKakao" value="${sessionScope.loginKakao}"></c:set>
<c:set var="sessionLoginNaver" value="${sessionScope.loginNaver}"></c:set>
<!-- END :: set JSTL variable -->

</head>
<body>
	<header>
		<nav class="content">
			<span id="home">
				<a href="/DEVCA/main/mainpage.do">HOME</a>
			</span>
			<span>
				드롭다운메뉴
			</span>
			<span id="search">
				<form action="lecture_search" method="post" style="display: inline;">
					<input type="text" name="search" placeholder="Ask 'What course do you need?'">
				</form>		
			</span>
			
			<span id="account">
				<c:choose>
					<c:when test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver}">
						<span>	
							<a href="/DEVCA/member/profilepage.do">프로필</a>
							<a href="/DEVCA/member/logout.do">로그아웃</a>
						</span>	
					</c:when>
					<c:otherwise>
						<span>
							<a href="/DEVCA/member/joinpage.do">회원가입</a>
						</span>
						<span>	
							<a href="/DEVCA/member/loginpage.do">로그인</a>
						</span>							
					</c:otherwise>
				</c:choose>
				
				
			</span>	
		</nav>	
	</header>
</body>
</html>