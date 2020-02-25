<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

</head>
<body>
	<aside>
		<div>			
			<div>
				<a href="/DEVCA/member/privacyprofilepage.do">계정관리</a>
			</div>
			<!-- sns 계정 은 pw 가 존재하지 않기 때문에 비밀번호 설정에 들어가지 못한다. -->
			<c:if test="${not empty sessionScope.loginMember }">
				<div>
					<a href="/DEVCA/member/privacypasswordpage.do">비밀번호</a>
				</div>
			</c:if>			
			<div>
				<a href="/DEVCA/member/privacypaymentpage.do">결제관리</a>
			</div>
		</div>
	</aside>
</body>
</html>