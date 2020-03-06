<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- HEADER FORM -->
<%@ include file="/views/form/header.jsp"%>

<!-- START :: css -->
<style type="text/css">
section{
	height: 100%;
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
		
		var MEMBER_PW = $(this).find("#pw").val();
		var NEW_MEMBER_PW = $(this).find("#new_pw").val();
		
		$("#pwResetHiddenForm input[name='MEMBER_PW']").val(rsa.encrypt(MEMBER_PW));
		$("#pwResetHiddenForm input[name='NEW_MEMBER_PW']").val(rsa.encrypt(NEW_MEMBER_PW));
		
		// 임시 출력 alert!!//////////////////////////////////////
		alert("MEMBER_PW : " + $("#pwResetHiddenForm input[name='MEMBER_PW']").val() + "\n" 
				+ "NEW_MEMBER_PW : " + $("#pwResetHiddenForm input[name='NEW_MEMBER_PW']").val() + "\n"
				);
		//////////////////////////////////////////////////////

		
		$("#pwResetHiddenForm").submit();
	})
	
})

</script>
<!-- END :: JAVASCRIPT -->

<!-- START :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
<c:if test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver}">
	<jsp:forward page="/DEVCA/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
</head>
<body>
	
	
	<section class="container-fluid">
		<div class="row">
	
			<%@ include file="/views/form/privacysidebar.jsp"%>	
		
			<!-- START :: profile content -->
			<article class="col-md-10">
				<div class="card p-4 my-3 bg-white">
					
					<form id="pwResetHiddenForm" action="/DEVCA/member/privacypasswordupdate.do" method="post">
						<input type="hidden" name="MEMBER_PW">
						<input type="hidden" name="NEW_MEMBER_PW">
					</form>
					
					<form id="pwResetForm" action="/DEVCA/member/privacypasswordupdate.do" method="post">
						
						<label for="pw">*현재 비밀번호</label>
						<div class="input-group mb-3">
							<input id="pw" class="form-control" type="password" name="MEMBER_PW" required="required" placeholder="current password">
							<div class="input-group-prepend">				
			       				<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
						</div>
						<div>
							비밀번호를 잊으셨나요?
							<a class="card-link" href="/DEVCA/member/privacypasswordresetpage.do">비밀번호 재설정</a>
						</div>						
						
						<div>
							<hr>
						</div>
					
						<label for="new_pw">*비밀번호 (비밀번호는 한 개 이상의 소문자와 숫자를 포함해야 하며, 7자 이상이어야 합니다.)</label>
						<div class="input-group mb-3">
							<input id="new_pw" class="form-control" type="password" name="NEW_MEMBER_PW" required="required" placeholder="new password">
							<div class="input-group-prepend">				
			       				<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
						</div>
						
						
						<label for="new_pwChk">*비밀번호 확인</label>
						<div class="input-group mb-3">
							<input id="new_pwChk" class="form-control" type="password" name="NEW_MEMBER_PW_CHECK" required="required" placeholder="new password check">
							<div class="input-group-prepend">				
			       				<span class="input-group-text"><i class="fas fa-check"></i></span>
							</div>
						</div>
						<div id="pw_confirm"></div>
						
						<div class="input-group mb-3">
							<input id="SUBMIT" class="btn btn-block btn-lg" type="submit" value="비밀번호 변경">
						</div>	
						
					</form>			
						
				
				</div>
			</article>	
			<!-- END :: profile content -->	
		</div>
	</section>	
	
	<!-- FOOTER FORM -->		
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>