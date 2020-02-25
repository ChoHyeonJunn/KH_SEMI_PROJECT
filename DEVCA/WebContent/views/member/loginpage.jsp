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
<script type="text/javascript" src="../resources/js/RSA/rsa.js"></script>
<script type="text/javascript" src="../resources/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="../resources/js/RSA/prng4.js"></script>
<script type="text/javascript" src="../resources/js/RSA/rng.js"></script>

<script type="text/javascript" src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>


<script type="text/javascript">
$(function(){
	var rsa = new RSAKey();
	rsa.setPublic("${modulus}", "${exponent}");
	
	$("#loginForm").submit(function(e){
		e.preventDefault();

		$("#login_check").text("");
		$("#login_check").attr("style","color:red");
		
		var MEMBER_EMAIL = $(this).find("#email").val();
		var MEMBER_PW = $(this).find("#pw").val();
		
		$("#hiddenForm input[name='MEMBER_EMAIL']").val(
				rsa.encrypt(MEMBER_EMAIL));
		$("#hiddenForm input[name='MEMBER_PW']").val(
				rsa.encrypt(MEMBER_PW));
		
		// 임시 출력 alert!!//////////////////////////////////////
		alert("userid : "
				+ $("#hiddenForm input[name='MEMBER_EMAIL']")
						.val()
				+ "\n"
				+ "password : "
				+ $("#hiddenForm input[name='MEMBER_PW']")
						.val() + "\n");
		//////////////////////////////////////////////////////
		$.ajax({
			type: "POST",
			url: "/DEVCA/member/login.do",
			data: {
				MEMBER_EMAIL : $("#hiddenForm input[name='MEMBER_EMAIL']").val(),
				MEMBER_PW : $("#hiddenForm input[name='MEMBER_PW']").val()
			},
			dataType: "JSON",
			success: function(msg){
				if(msg.result == 0){
					$("#login_check").text("EMAIL, PW를 확인해주세요.");
					$("#login_check").attr("style","color:red");
				}else{
					location.href='/DEVCA/main/mainpage.do';
				}
			},
			error : function() {
				alert("통신 실패");
			}
		})
	})

})
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
				<a id="kakao-login-btn">카카오</a>
			</div>
			<div>
				<a id="naver_id_login"></a>
			</div>
		</div>
		
		<div>
			<hr>
		</div>
		
		<!-- 실제 서버로 전송되는 FORM -->
		<form id=hiddenForm action="/DEVCA/member/login.do" method="post">
			<input type="hidden" name="MEMBER_EMAIL" /> 
			<input type="hidden" name="MEMBER_PW" />
		</form>
		
		<form id="loginForm" action="/DEVCA/member/login.do" method="post">
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
			
			<div id="login_check"></div>
			
			<div>
				<div>
					<div>			
						<input type="submit" value="로그인">
					</div>
				</div>
			</div>
		</form>
		
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
	</section>
	
	<!-- START :: SNSJOIN 팝업창으로 전송되는 form -->
	<form id="snsHiddenForm" action="" method="post">
		<input type="hidden" name="snsType">
		<input type="hidden" name="SNS_ID" /> 
		<input type="hidden" name="SNS_NICKNAME" /> 			
		<input type="hidden" name="SNS_EMAIL" />
		<input type="hidden" name="access_token" />
	</form>
	<!-- END :: SNSJOIN 팝업창으로 전송되는 form -->
	
	<!-- START :: SNSJOIN 시 실제 서버로 전송되는 form -->
	<form id="snsJoinHiddenForm" action="/DEVCA/member/snsjoin.do" method="post">
		<input type="hidden" name="snsType">
		
		<input type="hidden" name="MEMBER_NAME">
		<input type="hidden" name="MEMBER_EMAIL">
		<input type="hidden" name="MEMBER_PHONE">
			
		<input type="hidden" name="SNS_ID" /> 
		<input type="hidden" name="SNS_NICKNAME" /> 	
		<input type="hidden" name="access_token" />
	</form>
	<!-- END :: SNSJOIN 시 실제 서버로 전송되는 form -->
	
	<!-- START :: SNSLOGIN 시 실제 서버로 전송되는 form -->
	<form id="snsLoginHiddenForm" action="/DEVCA/member/loginsns.do" method="post">
		<input type="hidden" name="snsType">
	
		<input type="hidden" name="SNS_ID">
		<input type="hidden" name="access_token">
	</form>
	<!-- END :: SNSLOGIN 시 실제 서버로 전송되는 form -->
</body>

<!-- START :: NAVER LOGIN -->
<script type="text/javascript">
	var naver_id_login = new naver_id_login("irD1NHw9tD2Loycjai2X", "http://localhost:8090/DEVCA/views/member/navercallback.jsp");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("green",3,48);
  	naver_id_login.setDomain("http://localhost:8090/DEVCA");
  	naver_id_login.setState(state);
  	naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
</script>
<!-- END :: NAVER LOGIN -->

<!-- START :: KAKAO LOGIN -->
<script type="text/javascript">

/////////////// START :: 카카오 sns 연동

// 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('dde3d6a6f398e8afdf7600f84f211532');

// 카카오 로그인 버튼을 생성합니다.
Kakao.Auth.createLoginButton({
  container: '#kakao-login-btn',
  success: function(authObj) {
    /* alert(JSON.stringify(authObj)); */
    Kakao.API.request({
    	url: '/v1/user/me',
    	success: function(res){
    		/* alert(JSON.stringify(res)); */
			console.log(res.id);
    		console.log(res.properties['nickname']);
			console.log(res.kaccount_email);				
			console.log(authObj.access_token);
			
			// 가입된 이메일이 존재하는지 체크
			$.ajax({
				type : "POST",
				url : "/DEVCA/member/issnsmember.do",
				data : {
					SNS_ID : res.id, 
					snsType : "KAKAO"
				},
				dataType : "JSON",

				success : function(msg) {
					/* alert(msg.iskakao); */
					
					if(msg.issns > 0){
						//kakao id로 회원가입이 되어 있음	-> 로그인
						$("#snsLoginHiddenForm input[name='snsType']").val("KAKAO");
						$("#snsLoginHiddenForm input[name='SNS_ID']").val(res.id);
						$("#snsLoginHiddenForm input[name='access_token']").val(authObj.access_token);
						$("#snsLoginHiddenForm").submit();
					}else{
						//kakao id로 회원가입이 안되어 있음 -> 회원가입
						
						// 히든 폼에 set
						$("#snsHiddenForm input[name='snsType']").val("KAKAO");
						$("#snsHiddenForm input[name='SNS_ID']").val(res.id);
						$("#snsHiddenForm input[name='SNS_NICKNAME']").val(res.properties['nickname']);
						$("#snsHiddenForm input[name='SNS_EMAIL']").val(res.kaccount_email);
						$("#snsHiddenForm input[name='access_token']").val(authObj.access_token);
						
						// 팝업 생성
						var url = "/DEVCA/views/member/snsjoin.jsp";
						var title = "JOIN DEVCA";
						var prop = "top=200px,left=600px,width=500px,height=500px";
							
						window.open(url, title, prop);
					}
				},

				error : function(request, status, error) {
					alert("통신 실패");
					alert("code : " + request.status
						+ "\n" + "message : "
						+ request.responseText
						+ "\n" + "error : " + error);
				}
			})

    	}
    })
  },
  fail: function(err) {
     alert(JSON.stringify(err));
  }
});

// kakao logout 
function klogout(){
	Kakao.Auth.logout(function(){
		setTimeout(function(){
			location.href="/DEVCA/main/mainpage.do"
		}, 1000);
	})
}

/////////////// END :: 카카오 sns 연동

</script>
<!-- END :: KAKAO LOGIN -->

</html>