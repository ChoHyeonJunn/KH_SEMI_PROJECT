<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	
	<!--Fontawesome CDN-->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
	
<!-- end bootstrap --!>


<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript" src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>


<!-- END :: JAVASCRIPT -->

</head>
<body>

	<section class="container">
		
			
		<div class="d-flex justify-content-end social_icon">
			<span>
				<a id="custom-login-btn" href="javascript:loginWithKakao()">
					<img src="${pageContext.request.contextPath}/kakaolink_btn_medium.png" width="100px;"/>
				</a>
				
				<a href="http://developers.kakao.com/logout">카카오로그아웃</a>
			</span>
			<span>
				<a id="naver_id_login"></a>
			</span>
		</div>			
			
		
	</section>
	
	<!-- START :: SNSLOGIN 시 실제 서버로 전송되는 form -->
	<form id="snsLoginHiddenForm" action="/DEVCA_SnsLogin/member/loginsns.do" method="post">
		<input type="hidden" name="snsType">
		<input type="hidden" name="nickname">
		<input type="hidden" name="account_email">
	
		<input type="hidden" name="SNS_ID">
		<input type="hidden" name="access_token">
	</form>
	<!-- END :: SNSLOGIN 시 실제 서버로 전송되는 form -->
</body>

<!-- START :: NAVER LOGIN -->
<script type="text/javascript">
//네이버 로그인 api 애서 제공해주는 Client ID(4TMLgJohpi36Z4ly6_NL), 
//네이버 로그인 api 에서 제공해주는 CallbackURL(http://localhost:8787/DEVCA_SnsLogin/navercallback.jsp)
var naver_id_login = new naver_id_login("4TMLgJohpi36Z4ly6_NL", "http://localhost:8787/DEVCA_SnsLogin/navercallback.jsp");
  	var state = naver_id_login.getUniqState();
  	/* 사용 가능한버튼 Option	버튼 색상 : white, green
  	크기 : 1(버튼형), 2(작은 배너), 3(큰 배너)
  	배너 및 버튼 높이 : 사용자 지정값 */
  	naver_id_login.setButton("green", 1, 100);
    // 도메인 주소
    naver_id_login.setDomain("http://localhost:8787/DEVCA_SnsLogin");
  	naver_id_login.setState(state);
  	//로그인 popup 형태로 설정
  	naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
</script>
<!-- END :: NAVER LOGIN -->

<!-- START :: KAKAO LOGIN -->
<script type="text/javascript">

/////////////// START :: 카카오 sns 연동

// 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('dde3d6a6f398e8afdf7600f84f211532');// 카카오 api 에서 제공해주는 javaScript 키

// 카카오 로그인 버튼을 생성합니다.
function loginWithKakao(){
    Kakao.Auth.login({
    	success: function(authObj) {
    	// 로그인 성공시 , API를 호출 합니다.
	    Kakao.API.request({
	    	url: '/v2/user/me', // 회원정보를 불러옴
	    	success: function(res){ // 성공했을때 res를 실행함
				
				//kakao id로 회원가입이 되어 있음	-> 로그인
				$("#snsLoginHiddenForm input[name='snsType']").val("KAKAO");
				$("#snsLoginHiddenForm input[name='SNS_ID']").val(res.id);
				$("#snsLoginHiddenForm input[name='nickname']").val(res.properties['nickname']);
				$("#snsLoginHiddenForm input[name='account_email']").val(res.kaccount_email);
				$("#snsLoginHiddenForm input[name='access_token']").val(authObj.access_token);
				$("#snsLoginHiddenForm").submit();
				// loginsns.do 에게 요청
				
	    	}
	    })
	  },
	  fail: function(err) {
	     alert(JSON.stringify(err)); // json 객체를 string으로 변환
	  }
	});
}
/////////////// END :: 카카오 sns 연동

</script>
<!-- END :: KAKAO LOGIN -->

</html>