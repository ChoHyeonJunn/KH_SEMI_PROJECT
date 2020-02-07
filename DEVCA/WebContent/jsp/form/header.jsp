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

<style type="text/css">
header {
	background-color: white;
	hieght: auto;
	border: 1px dotted red;
}

footer {
	background-color: white;
	height: auto;
	text-align: center;
	line-height: 30px;
	border: 1px dotted red;
}

a {
	text-decoration: none;
}

nav > div{
	display: inline;
	float: left;
	margin: 10px;
}
</style>
</head>
<body>
	<header>
		<nav class="content">
			<div id="home">
				<a href="main">HOME</a>
			</div>
			<div id="search">
				<form action="lecture_search" method="post">
					<input type="text" name="search" placeholder="Ask 'What course do you need?'">
				</form>				
			</div>
			
			<div id="account">
				<a href="main">회원가입</a>
				<a href="main">로그인</a>	
			</div>	
		</nav>	
	</header>
</body>
</html>