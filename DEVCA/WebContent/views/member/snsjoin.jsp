<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>

<!-- bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	
	<!--Fontawesome CDN-->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
	
<!-- end bootstrap --!>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- START :: CSS -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<style type="text/css">
.container{
	padding-top: 80px;
}

.card {
	width: 600px;
	margin: 10% auto 100px auto;
	box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);
	-webkit-transition: .25s box-shadow;
	transition: .25s box-shadow;
}
.card:focus,
.card:hover {
	box-shadow: 0 20px 40px 0 rgba(0, 0, 0, 0.18), 0 4px 15px 0 rgba(0, 0, 0, 0.15);
}
.card-link{
	color: #862d86;
	font-weight: 800;
}

.btn, .input-group-text{
	color: white;
	font-weight: 800;
	background-color: #862d86; 
}

.social_icon{
	position: absolute;
	right: 20px;
	top: -30px;
}
.social_icon span{
	width: 99px;
	height: 99px;
	margin-left: 10px;
	border-radius: 20px;
}
.social_icon span:hover{
	box-shadow: 0 10px 10px 0 rgba(0, 0, 0, 0.18), 0 4px 15px 0 rgba(0, 0, 0, 0.15);
	cursor: pointer;
}

.list-group li{
	list-style: none;
	margin-right: 20px;
}
</style><!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#SUBMIT").attr("disabled", "disabled");
	$("#email_check").attr("style", "display: none;");
	
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
							
							$("#email_check_remove").attr("style", "display:none;")
							$("#email_check").attr("style", "display");
							
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

	<section class="container">
	
		<h1 class="card-title">
			SNS JOIN
		</h1>
		
		<div>
			<hr>
		</div>
		

		<form id="snsJoinForm" action="/DEVCA/member/snsjoin.do" method="post">
			
			<!-- <label for="name">별명</label> -->
			<div class="input-group mb-3">
				<input id="name" type="text" class="form-control" name="MEMBER_NAME" required="required" placeholder="nickname" autocomplete="name">
				<div class="input-group-append">				
					<span class="input-group-text"><i class="fas fa-user"></i></span>
				</div>
			</div>
			<div id="name_confirm"></div>	<!-- 경고문이 들어갈 공간 -->
			
					
			<!-- <label for="email">이메일</label> -->
			<div id="replaceSNSEmail" class="input-group mb-3">
				<input id="email" class="form-control" type="email" name="MEMBER_EMAIL" required="required" placeholder="example@example.com" autocomplete="email">
				<div class="input-group-append">				
		       		<span id="email_check_remove" class="input-group-text"><i class="fas fa-envelope"></i></span>
				</div>
				<input id="email_check"  class="btn" type="button" value="email 인증번호 받기" >
			</div>					
			<div id="email_confirm"></div>	<!-- 경고문이 들어갈 공간 -->
			
			
			<!-- <label for="phone">전화번호</label> -->
			<div class="input-group mb-3">	
				<input id="phone" class="form-control" type="tel" name="MEMBER_PHONE" required="required" placeholder="010-1234-1234" autocomplete="tel">
				<div class="input-group-append">				
		    		<span class="input-group-text"><i class="fas fa-phone"></i></span>
				</div>					
			</div>
					
		
			<div class="input-group mb-3">
				<input class="btn btn-block btn-lg" type="submit" value="SNS계정만들기" id="SUBMIT">
			</div>
			
		</form>
	</section>
	
	
	<form id="emailAuthHiddenForm" action="#">
		<input type="hidden" name="authNum">
	</form>
		
</body>
</html>