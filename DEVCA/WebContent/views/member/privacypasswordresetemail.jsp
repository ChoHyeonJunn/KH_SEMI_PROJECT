<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- START :: css -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">

<style type="text/css">
section{
	height: 800px;
}

</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript" src="../resources/js/RSA/rsa.js"></script>
<script type="text/javascript" src="../resources/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="../resources/js/RSA/prng4.js"></script>
<script type="text/javascript" src="../resources/js/RSA/rng.js"></script>

<script type="text/javascript">

$(function(){
	var rsa = new RSAKey();
	rsa.setPublic("${modulus}", "${exponent}");
	
	$("#SUBMIT").attr("disabled", "disabled");

	$("#new_pw,#new_pwChk").keyup(function() {
		var pw = $("#new_pw").val();
		var pwChk = $("#new_pwChk").val();
		
		if(pw != "" && pwChk != "") {
			
			if(pw != pwChk) {
				$("#pw_confirm").text("비밀번호가 일치하지 않습니다.");
				$("#pw_confirm").attr("style", "color:red");						
			} else {	
				$("#pw_confirm").text("비밀번호가 일치합니다.");
				$("#pw_confirm").attr("style", "color:green");
				
				$("#SUBMIT").removeAttr("disabled");
			}
		} 
	})	
	$("#pwResetForm").submit(function(e){
		e.preventDefault();
		
		var NEW_MEMBER_PW = $(this).find("#new_pw").val();
		
		$("#pwResetHiddenForm input[name='NEW_MEMBER_PW']").val(rsa.encrypt(NEW_MEMBER_PW));
		
		// 임시 출력 alert!!//////////////////////////////////////
		alert("NEW_MEMBER_PW : " + $("#pwResetHiddenForm input[name='NEW_MEMBER_PW']").val());
		//////////////////////////////////////////////////////

		$("#pwResetHiddenForm").submit();
	})

})

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	
	<section>
		
		<!-- START :: profile content -->
		<article>
		
			<h1><a href="">DEVCA</a></h1>
			
			<div>
				<h1>비밀번호 재설정</h1>
				<h4>
					비밀번호를 다시 설정합니다. 비밀번호는 적어도 하나의 소문자와 숫자를 포함해야 하며, 최소 7자 이상 되어야 합니다.
				</h4>
				
				<form id="pwResetHiddenForm" action="/DEVCA/member/privacypasswordupdate.do" method="post">
					<input type="hidden" name="NEW_MEMBER_PW">
				</form>
				
				<form id="pwResetForm" action="/DEVCA/member/privacypasswordupdate.do" method="post">
	
					
					<div>
						<div>
							<label for="pw">*비밀번호</label>
						</div>
						<div>
							<input id="new_pw" type="password" name="NEW_MEMBER_PW" required="required" placeholder="password">
						</div>
						<div>
							비밀번호는 한 개 이상의 소문자와 숫자를 포함해야 하며, 7자 이상이어야 합니다.
						</div>
					</div>
					
					<div>
						<div>
							<label for="pwChk">*비밀번호 확인</label>
						</div>
						<div>
							<input id="new_pwChk" type="password" name="NEW_MEMBER_PW_CHECK" required="required" placeholder="password">
						</div>
					</div>
					<div id="pw_confirm"></div>
					
					<div>
						<div>		
							<input type="submit" value="변경 사항 저장" id="SUBMIT">
						</div>
					</div>
				</form>			
			</div>
			
			
		</article>	
		<!-- END :: profile content -->	
		
	</section>	
	
	<!-- FOOTER FORM -->		
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>