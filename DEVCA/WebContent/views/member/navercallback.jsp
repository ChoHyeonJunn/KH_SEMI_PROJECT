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
	var naver_id_login = new naver_id_login("irD1NHw9tD2Loycjai2X", "http://qclass.iptime.org:8787/DEVCA/views/member/navercallback.jsp");
	// 접근 토큰 값 출력
	/* alert(naver_id_login.oauthParams.access_token); */
	// 네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
	     /*  alert(naver_id_login.getProfileData('id'));
		  alert(naver_id_login.getProfileData('email'));
		  alert(naver_id_login.getProfileData('name')); */
	      var uniqId = naver_id_login.getProfileData('id');
		  var email = naver_id_login.getProfileData('email');
		  var name = naver_id_login.getProfileData('name');
		  
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
						$(opener.document).find("#snsLoginHiddenForm input[name='snsType']").val("NAVER");
						$(opener.document).find("#snsLoginHiddenForm input[name='SNS_ID']").val(uniqId);
						$(opener.document).find("#snsLoginHiddenForm").submit();
					}else{
						//naver id로 회원가입이 안되어 있음 -> 회원가입
								
						// 히든 폼에 set
						$(opener.document).find("#snsHiddenForm input[name='snsType']").val("NAVER");
						$(opener.document).find("#snsHiddenForm input[name='SNS_ID']").val(uniqId);
						$(opener.document).find("#snsHiddenForm input[name='SNS_NICKNAME']").val(name);
						$(opener.document).find("#snsHiddenForm input[name='SNS_EMAIL']").val(email);
								
						// 팝업 생성
						var url = "/DEVCA/views/member/snsjoin.jsp";
						var title = "JOIN DEVCA";
						var prop = "top=200px,left=600px,width=500px,height=500px";
							
						opener.window.open(url, title, prop);
					}
					close();
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
</script>
</body>
</html>