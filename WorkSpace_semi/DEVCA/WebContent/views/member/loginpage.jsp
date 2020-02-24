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
<script type="text/javascript" src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>

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
				<a id="kakao-login-btn">카카오</a>
			</div>
			<div>
				<!-- 네이버아이디로로그인 버튼 노출 영역 -->
				<a id="naverIdLogin"></a>
				<!-- //네이버아이디로로그인 버튼 노출 영역 -->
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

	/* (2) LoginWithNaverId Javscript 설정 정보 및 초기화 */
	var naverLogin = new naver.LoginWithNaverId(
			{
				clientId: "irD1NHw9tD2Loycjai2X",
				callbackUrl: "http://localhost:8090/DEVCA/member/loginpage.do",
				isPopup: false,
				loginButton: {color: "green", type: 3, height: 48}, /* 로그인 버튼의 타입을 지정 */
				callbackHandle: true
				/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */
			}
		);

		/* (3) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
		naverLogin.init();
		
		/* (4) Callback의 처리. 정상적으로 Callback 처리가 완료될 경우 main page로 redirect(또는 Popup close) */
		window.addEventListener('load', function () {
			naverLogin.getLoginStatus(function (status) {
				if (status) {
					/* (5) 필수적으로 받아야하는 프로필 정보가 있다면 callback처리 시점에 체크 */
					var uniqId = naverLogin.user.getId();
					var email = naverLogin.user.getEmail();
					var name = naverLogin.user.getName();
					
					if( uniqId == undefined || uniqId == null) {
						alert("아이디는 필수정보입니다. 정보제공을 동의해주세요.");
						/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
						naverLogin.reprompt();
						return;
					}
					if( email == undefined || email == null) {
						alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
						/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
						naverLogin.reprompt();
						return;
					}					
					if( name == undefined || name == null) {
						alert("이름은 필수정보입니다. 정보제공을 동의해주세요.");
						/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
						naverLogin.reprompt();
						return;
					}
					console.log(uniqId);
					console.log(email);
					console.log(name);
					//window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?":" + location.port:":" + location.port) + "/DEVCA/member/loginpage.do");
					
					// 가입된 sns id 인지 체크
					$.ajax({
						type : "POST",
						url : "/DEVCA/member/issnsmember.do",
						data : {
							SNS_ID : uniqId, 
							snsType : "NAVER"
						},
						dataType : "JSON",
		
						success : function(msg) {
							/* alert(msg.issns); */
							
							if(msg.issns > 0){
								//naver id로 회원가입이 되어 있음	-> 로그인
								$("#snsLoginHiddenForm input[name='snsType']").val("NAVER");
								$("#snsLoginHiddenForm input[name='SNS_ID']").val(uniqId);
								$("#snsLoginHiddenForm").submit();
							}else{
								//naver id로 회원가입이 안되어 있음 -> 회원가입
								
								// 히든 폼에 set
								$("#snsHiddenForm input[name='snsType']").val("NAVER");
								$("#snsHiddenForm input[name='SNS_ID']").val(uniqId);
								$("#snsHiddenForm input[name='SNS_NICKNAME']").val(name);
								$("#snsHiddenForm input[name='SNS_EMAIL']").val(email);
								
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
				} else {
					console.log("callback 처리에 실패하였습니다.");
				}
			});
		});
	
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
						$("#snsLoginHiddenForm input[name='snsType']").val("NAVER");
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


/////////////// START :: 네이버 sns 연동
/////////////// END :: 네이버 sns 연동
</script>
<!-- END :: KAKAO LOGIN -->

</html>