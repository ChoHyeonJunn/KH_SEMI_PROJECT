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
			<h1>계정만들기</h1>
		</div>
		<div>
			<div>
				<a id="kakao-login-btn">카카오</a>
			</div>
			<div>
				<a href="#">네이버</a>
			</div>
		</div>
		
		<div>
			<hr>
		</div>
		
		<form action="/DEVCA/member/join.do" method="post">
			<div>
				<div>
					<label for="name">이름</label>
				</div>
				<div>
					<input id="name" type="text" name="MEMBER_NAME" required="required" placeholder="이름" autocomplete="name">
				</div>
			</div>
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
					<label for="phone">전화번호</label>
				</div>
				<div>			
					<input id="phone" type="tel" name="MEMBER_PHONE" required="required" placeholder="010-1234-1234" autocomplete="tel">
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
					<label for="pwChk">비밀번호 확인</label>
				</div>
				<div>
					<input id="pwChk" type="password" required="required" placeholder="password-check">
				</div>
			</div>	
			<div>
				<div>
					<div>			
						<input type="submit" value="계정만들기">
					</div>
					<div>
						이미 계정이 있으신가요?
						<a href="/DEVCA/member/loginpage.do">로그인></a>
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
	<form id="snsLoginHiddenForm" action="/DEVCA/member/loginkakao.do" method="post">
		<input type="hidden" name="SNS_ID">
		<input type="hidden" name="access_token">
	</form>
	<!-- END :: SNSLOGIN 시 실제 서버로 전송되는 form -->
</body>

<!-- START :: SNS LOGIN -->
<script type="text/javascript">

/////////////// START :: 카카오 sns 연동

// 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('dde3d6a6f398e8afdf7600f84f211532');

// 카카오 로그인 버튼을 생성합니다.
Kakao.Auth.createLoginButton({
  container: '#kakao-login-btn',
  success: function(authObj) {
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
				url : "/DEVCA/member/iskakaomember.do",
				data : {
					MEMBER_EMAIL : res.kaccount_email
				},
				dataType : "JSON",

				success : function(msg) {
					/* alert(msg.iskakao); */
					
					if(msg.iskakao > 0){
						//kakao 이메일로 회원가입이 되어 있음	-> 로그인
						$("#snsLoginHiddenForm input[name='SNS_ID']").val(res.id);
						$("#snsLoginHiddenForm input[name='access_token']").val(authObj.access_token);
						$("#snsLoginHiddenForm").submit();
					}else{
						//kakao 이메일로 회원가입이 안되어 있음 -> 회원가입
						
						// 히든 폼에 set
						$("#snsHiddenForm input[name='snsType']").val("KAKAO");
						$("#snsHiddenForm input[name='SNS_ID']").val(res.id);
						$("#snsHiddenForm input[name='SNS_NICKNAME']").val(res.properties['nickname']);
						$("#snsHiddenForm input[name='SNS_EMAIL']").val(res.kaccount_email);
						$("#snsHiddenForm input[name='access_token']").val(authObj.access_token);
						
						// 팝업 생성
						var url = "/DEVCA/views/member/snsjoin.jsp";
						var title = "";
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
<!-- END :: SNS LOGIN -->
</html>







