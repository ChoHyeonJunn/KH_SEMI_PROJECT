<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!-- END :: JAVASCRIPT -->
</head>
<body>
<script type="text/javascript">
	var naver_id_login = new naver_id_login("4TMLgJohpi36Z4ly6_NL", "http://localhost:8787/DEVCA_SnsLogin/navercallback.jsp");
	// 접근 토큰 값 출력
	
	// 네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
	      var uniqId = naver_id_login.getProfileData('id');
		  var email = naver_id_login.getProfileData('email');
		  var name = naver_id_login.getProfileData('name');
		  
		  
		//naver id로 회원가입이 되어 있음	-> 로그인
			$(opener.document).find("#snsLoginHiddenForm input[name='snsType']").val("NAVER");
			$(opener.document).find("#snsLoginHiddenForm input[name='SNS_ID']").val(uniqId);
			$(opener.document).find("#snsLoginHiddenForm input[name='nickname']").val(name);
			$(opener.document).find("#snsLoginHiddenForm input[name='account_email']").val(email);
			$(opener.document).find("#snsLoginHiddenForm").submit();
		close();
	}
</script>
</body>
</html>