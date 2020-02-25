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

<script type="text/javascript">
$(function(){
	$("#email_check").attr("disabled", "disabled");
	$("#SUBMIT").removeAttr("disabled");
	
	// 이메일 정규식
	var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;   

	var snsType = $(opener.document).find("#snsHiddenForm input[name='snsType']").val();
	var SNS_ID = $(opener.document).find("#snsHiddenForm input[name='SNS_ID']").val();
	var SNS_NICKNAME = $(opener.document).find("#snsHiddenForm input[name='SNS_NICKNAME']").val();
	var SNS_EMAIL = $(opener.document).find("#snsHiddenForm input[name='SNS_EMAIL']").val();
	var access_token = $(opener.document).find("#snsHiddenForm input[name='access_token']").val();
	
	// sns 를 통해 이메일을 받았다면 중복검사
	if(SNS_EMAIL != null && SNS_EMAIL != ""){		
		$("#email").val(SNS_EMAIL);
		$.ajax({
			
			type: "POST",
			url: "/DEVCA/member/emailconfirm.do",
			data: { MEMBER_EMAIL : SNS_EMAIL },
			dataType: "JSON",
			
			success: function(msg) {	
				if(msg.result > 0) {						
					$("#SUBMIT").attr("disabled", "disabled");
					$("#email_check").attr("disabled", "disabled");
					$("#email_confirm").text("이미 사용중인 이메일입니다.");
					$("#email_confirm").attr("style", "color:red");
				}
			},
			
			error : function() {
				alert("통신 실패");
			}
		})
			
	}
	
	$("#name").keyup(function() {
		if($("#name").val() == null || $("#name").val() == "") {
			$("#name_confirm").text("필수 정보입니다.");
			$("#name_confirm").attr("style", "color:red");
		} else {			
			$.ajax({
				
				type: "POST",
				url: "/DEVCA/member/nameconfirm.do",
				data: { MEMBER_NAME : $("#name").val() },
				dataType: "JSON",
				
				success: function(msg) {	
					if(msg.result > 0) {
						$("#SUBMIT").attr("disabled", "disabled");
						$("#email_check").attr("disabled", "disabled");						
						$("#name_confirm").text("이미 사용중인 별명입니다.");
						$("#name_confirm").attr("style", "color:red");
						
					} else {
						$("#name_confirm").text("사용 가능한 별명입니다.");
						$("#name_confirm").attr("style", "color:blue");
						
						$("#SUBMIT").removeAttr("disabled");
					}
				},
				
				error : function() {
					alert("통신 실패");
				}
			})
		}
	})
	
	$("#email").keyup(function() {
		
		if($("#email").val() == null || $("#email").val() == "") {
			$("#SUBMIT").attr("disabled", "disabled");
			$("#email_check").attr("disabled", "disabled");
			$("#email_confirm").text("필수 정보입니다.");
			$("#email_confirm").attr("style", "color:red");
		} else {	
			
			if(regExp.test($("#email").val())){
				$.ajax({
					
					type: "POST",
					url: "/DEVCA/member/emailconfirm.do",
					data: { MEMBER_EMAIL : $("#email").val() },
					dataType: "JSON",
					
					success: function(msg) {	
						if(msg.result > 0) {						
							$("#SUBMIT").attr("disabled", "disabled");
							$("#email_check").attr("disabled", "disabled");
							$("#email_confirm").text("이미 사용중인 이메일입니다.");
							$("#email_confirm").attr("style", "color:red");
						} else {
							$("#email_confirm").text("사용 가능한 이메일입니다. 이메일 인증을 진행해주세요.");
							$("#email_confirm").attr("style", "color:blue");
							
							$("#email_check").removeAttr("disabled");
							$("#SUBMIT").removeAttr("disabled");
							
						}
					},
					
					error : function() {
						alert("통신 실패");
					}
				})
			} else{
				$("#SUBMIT").attr("disabled", "disabled");
				$("#email_check").attr("disabled", "disabled");
				$("#email_confirm").text("이메일 형식이 아닙니다.");
				$("#email_confirm").attr("style", "color:red");
			}
		}
	})

	$("#email_check").click(function(){
		$("#email_confirm").text("이메일 인증 진행중...");
		$("#email_confirm").attr("style", "color:green");

		if($("#email").val() == null || $("#email").val() == "") {
			$("#SUBMIT").attr("disabled", "disabled");
			$("#email_check").attr("disabled", "disabled");
			$("#email_confirm").text("필수 정보입니다.");
			$("#email_confirm").attr("style", "color:red");
		} else {			
			$.ajax({				
				type: "POST",
				url: "/DEVCA/member/emailAuth.do",
				data: { MEMBER_EMAIL : $("#email").val() },
				dataType: "JSON",
				
				success: function(msg) {	
					$("#emailAuthHiddenForm input[name='authNum']").val(msg.authNum);
												
					// 팝업 생성
					var url = "/DEVCA/views/member/joinemailauth.jsp";
					var title = "";
					var prop = "top=200px,left=600px,width=500px,height=500px";
							
					window.open(url, title, prop);					
				},
				
				error : function() {
					alert("통신 실패");
				}
			})
		}
	})
	
	$("#snsJoinForm").submit(function(e){
		e.preventDefault();
		// 실제 유저 입력 form은 event 취소
		// javaScript가 작동되지 않는 환경에서는 유저 입력 form이 submit됨 -> server 측에서 검증되므로 로그인 불가.
		
		// 변수 set
		var MEMBER_NAME = $("#snsJoinForm input[name='MEMBER_NAME']").val();
		var MEMBER_EMAIL;
		if(SNS_EMAIL != null && SNS_EMAIL != ""){
			MEMBER_EMAIL = SNS_EMAIL;			
		}else{
			MEMBER_EMAIL = $("#snsJoinForm input[name='MEMBER_EMAIL']").val();
		}
		var MEMBER_PHONE = $("#snsJoinForm input[name='MEMBER_PHONE']").val();
		
		// opener 의 히든폼에 setValues 한 후 submit
		$(opener.document).find("#snsJoinHiddenForm input[name='snsType']").val(snsType);
		
		$(opener.document).find("#snsJoinHiddenForm input[name='MEMBER_NAME']").val(MEMBER_NAME);
		$(opener.document).find("#snsJoinHiddenForm input[name='MEMBER_EMAIL']").val(MEMBER_EMAIL);
		$(opener.document).find("#snsJoinHiddenForm input[name='MEMBER_PHONE']").val(MEMBER_PHONE);
		
		$(opener.document).find("#snsJoinHiddenForm input[name='SNS_ID']").val(SNS_ID);
		$(opener.document).find("#snsJoinHiddenForm input[name='SNS_NICKNAME']").val(SNS_NICKNAME);
		$(opener.document).find("#snsJoinHiddenForm input[name='access_token']").val(access_token);

		$(opener.document).find("#snsJoinHiddenForm").submit();
		close();		
	})
})
	
	
</script>

<!-- END :: JAVASCRIPT -->

</head>
<body>
	<section>
		<div>
			<h1>SNS계정만들기</h1>
		</div>
		
		<div>
			<hr>
		</div>
		<form id="emailAuthHiddenForm" action="#">
			<input type="hidden" name="authNum">
		</form>	
		<form id="snsJoinForm" action="/DEVCA/member/snsjoin.do" method="post">
			<div>
				<div>
					<label for="name">이름</label>
				</div>
				<div>
					<input id="name" type="text" name="MEMBER_NAME" required="required" placeholder="이름" autocomplete="name">
				</div>
			</div>
			
			<div id="name_confirm"></div>	<!-- 경고문이 들어갈 공간 -->
			
			<div id="replaceSNSEmail">
				<div>
					<label for="email">이메일</label>
				</div>
				<div>
					<input id="email" type="email" name="MEMBER_EMAIL" required="required" placeholder="abc@abc.com" autocomplete="email">
					<input id="email_check" type="button" value="email 인증">					
				</div>
			</div>		

			
			<div id="email_confirm"></div>	<!-- 경고문이 들어갈 공간 -->
			
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
					<input type="submit" value="SNS계정만들기" id="SUBMIT">
				</div>
			</div>
		</form>
	</section>
</body>
</html>