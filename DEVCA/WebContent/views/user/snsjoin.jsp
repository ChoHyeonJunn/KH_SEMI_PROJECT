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
	var snsType = $(opener.document).find("#snsHiddenForm input[name='snsType']").val();
	var SNS_ID = $(opener.document).find("#snsHiddenForm input[name='SNS_ID']").val();
	var SNS_NICKNAME = $(opener.document).find("#snsHiddenForm input[name='SNS_NICKNAME']").val();
	var SNS_EMAIL = $(opener.document).find("#snsHiddenForm input[name='SNS_EMAIL']").val();
	var access_token = $(opener.document).find("#snsHiddenForm input[name='access_token']").val();
	
	// sns 를 통해 이메일을 받았다면 email input 삭제
	if(SNS_EMAIL != null && SNS_EMAIL != ""){
		$("#replaceSNSEmail").remove();		
	}
	
	$("#snsJoinForm").submit(function(e){
		e.preventDefault();
		// 실제 유저 입력 form은 event 취소
		// javaScript가 작동되지 않는 환경에서는 유저 입력 form이 submit됨 -> server 측에서 검증되므로 로그인 불가.
		
		var MEMBER_NAME = $("#snsJoinForm input[name='MEMBER_NAME']").val();
		var MEMBER_EMAIL;
		if(SNS_EMAIL != null && SNS_EMAIL != ""){
			MEMBER_EMAIL = SNS_EMAIL;			
		}else{
			MEMBER_EMAIL = $("#snsJoinForm input[name='MEMBER_EMAIL']").val();
		}
		var MEMBER_PHONE = $("#snsJoinForm input[name='MEMBER_PHONE']").val();
		
		$(opener.document).find("#snsJoinHiddenForm input[name='snsType']").val(snsType);
		
		$(opener.document).find("#snsJoinHiddenForm input[name='MEMBER_NAME']").val(MEMBER_NAME);
		$(opener.document).find("#snsJoinHiddenForm input[name='MEMBER_EMAIL']").val(MEMBER_EMAIL);
		$(opener.document).find("#snsJoinHiddenForm input[name='MEMBER_PHONE']").val(MEMBER_PHONE);
		
		$(opener.document).find("#snsJoinHiddenForm input[name='SNS_ID']").val(SNS_ID);
		$(opener.document).find("#snsJoinHiddenForm input[name='SNS_NICKNAME']").val(SNS_NICKNAME);
		$(opener.document).find("#snsJoinHiddenForm input[name='access_token']").val(access_token);

		$(opener.document).find("#snsJoinHiddenForm").submit();
		close();
		
/* 		$.ajax({
			type : "POST",
			url : "/DEVCA/member/아이디체크체크체크체크체크체크체크ㅔ.do",
			data : {
				snsType : snsType, 
				MEMBER_NAME : MEMBER_NAME,
				MEMBER_EMAIL : MEMBER_EMAIL,
				MEMBER_PHONE : MEMBER_PHONE,
				
				SNS_ID : SNS_ID,
				SNS_NICKNAME : SNS_NICKNAME,
				access_token : access_token
			},
			dataType : "JSON",

			success : function(args) {
				alert("성공");
			},

			error : function(request, status, error) {
				alert("통신 실패");
				alert("code : " + request.status
						+ "\n" + "message : "
						+ request.responseText
						+ "\n" + "error : " + error);
			}
		}) */
		
		
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
		
		<form id="snsJoinForm" action="/DEVCA/member/snsjoin.do" method="post">
			<div>
				<div>
					<label for="name">이름</label>
				</div>
				<div>
					<input id="name" type="text" name="MEMBER_NAME" required="required" placeholder="이름" autocomplete="name">
				</div>
			</div>
			<div id="replaceSNSEmail">
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
					<input id="phone" type="tel" name="MEMBER_PHONE" required="required" placeholder="010-1234-1234" autocomplete="tel"">
				</div>
			</div>
			<div>
				<div>		
					<input type="submit" value="SNS계정만들기">
				</div>
			</div>
		</form>
	</section>
</body>
</html>