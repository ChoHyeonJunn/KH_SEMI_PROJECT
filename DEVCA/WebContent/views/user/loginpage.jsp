<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- START :: CSS -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script type="text/javascript">

</script>

<!-- END :: JAVASCRIPT -->

</head>
<body>
	<section>
		<div>
			<h1><a href="/DEVCA/main/mainpage.do">DEVCA</a></h1>
		</div>
		<div>
			<h1>로그인</h1>
		</div>
		<div>
			<div>
				<a href="#">카카오</a>
			</div>
			<div>
				<a href="#">네이버</a>
			</div>
		</div>
		
		<div>
			<hr>
		</div>
		
		<form action="/DEVCA/member/login.do" method="post">
			<div>
				<div>
					<label for="email">이메일</label>
				</div>
				<div>
					<input id="email" type="email" name="MEMBER_EMAIL" required="required" placeholder="abc@abc.com" autocomplete="email">
				</div>
			</div>
			<div>
				<div>
					<label for="pw">비밀번호</label>
				</div>
				<div>
					<input id="pw" type="password" name="MEMBER_PW" required="required" placeholder="password">
				</div>
			</div>
			<div>
				<div>
					<div>			
						<input type="submit" value="로그인">
					</div>
					<div>
						아직 계정이 없으신가요?
						<a href="/DEVCA/member/joinpage.do">계정만들기></a>
					</div>
					<div>
						<ul>
							<li><a href="#">이용약관</a></li>
							<li><a href="#">개인정보 처리방침</a></li>
							<li><a href="#">FAQ/문의</a></li>
						</ul>
					</div>
				</div>
			</div>
		</form>
	</section>
</body>
</html>