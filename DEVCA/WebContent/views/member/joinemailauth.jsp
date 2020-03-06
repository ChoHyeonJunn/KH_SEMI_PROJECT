<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 

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

<!-- START :: css -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<style type="text/css">
.container{
	padding-top: 80px;
}

.btn, .input-group-text{
	color: white;
	font-weight: 800;
	background-color: #862d86; 
}
</style>
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

	<section class="container">
		<form id="emailAuth" action="#">
		
			<label for="authNum">이메일 인증번호 입력 :</label>
			<div class="input-group mb-3">
				<input id="authNum" class="form-control" type="text" name="authNum" required="required" placeholder="인증번호">
				<div class="input-group-prepend">				
		    		<span class="input-group-text"><i class="fas fa-key"></i></span>
				</div>
			</div>
			
			<div class="input-group mb-3">
				<input class="btn btn-block btn-lg" type="submit" value="인증하기">
			</div>
		</form>		
	</section>
	
</body>
</html>