<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- START :: css -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

$(function(){
	$("#authNum").focus();
	
	$("#emailAuth").submit(function(e){
		e.preventDefault();
		
		var OGauthNum = $(opener.document).find("#emailAuthHiddenForm input[name='authNum']").val();
		var INPUTauthNum = $("#emailAuth input[name='authNum']").val();
		
		if(OGauthNum == INPUTauthNum){
			$(opener.document).find("#email_confirm").text("이메일 인증에 성공하였습니다.");
			$(opener.document).find("#email").attr("disabled", "disabled");
			$(opener.document).find("#email").attr("style", "border: 1px solid green");
			$(opener.document).find("#email_check").remove();
			$(opener.document).find("#phone").focus();
		}else{
			$(opener.document).find("#email_confirm").text("이메일 인증에 실패하였습니다.");
		}
		close();
	})
})

</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>

	<section>
		<form id="emailAuth" action="#">
			<div>
				이메일 인증번호 입력 : 
			</div>
			<div>				
				<input id="authNum" type="text" name="authNum">
			</div>
			<div>
				<input type="submit" value="인증하기">
			</div>
		</form>		
	</section>
	
</body>
</html>