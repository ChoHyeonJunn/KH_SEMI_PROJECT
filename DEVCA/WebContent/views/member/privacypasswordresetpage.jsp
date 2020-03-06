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
<script type="text/javascript">
$(function(){
	// 이메일 정규식
	var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;   

	$("#email").keyup(function() {
		
		if($("#email").val() == null || $("#email").val() == "") {
			$("#email_confirm").text("필수 정보입니다.");
			$("#email_confirm").attr("style", "color:red");
		} else {	
			
			if(regExp.test($("#email").val())){
				$("#email_confirm").text("적합한 이메일 형식.");
				$("#email_confirm").attr("style", "color:green");		
				
				$("#SUBMIT").removeAttr("disabled");
			} else{
				$("#email_confirm").text("이메일 형식이 아닙니다.");
				$("#email_confirm").attr("style", "color:red");
				
				$("#SUBMIT").attr("disabled", "disabled");
			}
		}
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
					
					<h2 class="card-title">비밀번호 재설정</h2>
					<h5 class="card-title">비밀번호를 재설정 할 이메일을 입력하세요. 자세한 안내가 담긴 메일을 보내드리겠습니다.</h5>
					
					<div class="card-body">		
					
						<form action="/DEVCA/member/privacypasswordresetemail.do">
							
							<input type="hidden" name="MEMBER_NAME" value="${sessionScope.loginMember.MEMBER_NAME }">
					
							
							<label for="email">*비밀번호를 재설정 할 이메일</label>
							<div class="input-group mb-3">
								<input id="email" class="form-control" type="email" name="MEMBER_EMAIL" required="required" placeholder="example@example.com" autocomplete="email">
								<div class="input-group-append">				
				       				<span id="email_check_remove" class="input-group-text"><i class="fas fa-envelope"></i></span>
								</div>
							</div>			
							<div id="email_confirm"></div>	<!-- 경고문이 들어갈 공간 -->	
										
									
							<div class="input-group mb-3">
								<input class="btn btn-block btn-lg" type="submit" value="비밀번호 재설정 메일 보내기" id="SUBMIT">
							</div>
							
						</form>
						
						
					</div>			
				</div>
			</article>	
			<!-- END :: profile content -->	
		</div>
	</section>	
	
	<!-- FOOTER FORM -->		
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>