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
article{
	position: relative;
	margin-left: 250px;
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
	
	
	<section>
		<%@ include file="/views/form/privacysidebar.jsp"%>	
		
		<!-- START :: profile content -->
		<article>
		
			<form action="/DEVCA/member/privacypasswordresetemail.do">
				<input type="hidden" name="MEMBER_NAME" value="${sessionScope.loginMember.MEMBER_NAME }">
				<div>
					<div>
						<h1>비밀번호 찾기</h1>
						<div>
							비밀번호를 재설정 할 이메일을 입력하세요. 자세한 안내가 담긴 메일을 보내드리겠습니다.
						</div>
					</div>
					<div>
						<label for="pw">*비밀번호를 재설정 할 이메일</label>
					</div>
					<div>
						<input id="email" type="email" name="MEMBER_EMAIL" required="required" placeholder="이메일">
					</div>
					<div id="email_confirm"></div>	<!-- 경고문이 들어갈 공간 -->
					
				</div>				
				<div>
					<div>	
						<input id="SUBMIT" type="submit" value="비밀번호 재설정 메일 보내기">
					</div>
				</div>	
			</form>
			<div>
				<ul>
					<li><a href="#">이용약관</a></li>
					<li><a href="#">개인정보 처리방침</a></li>
					<li><a href="#">FAQ/문의</a></li>
				</ul>
			</div>				
			
		</article>	
		<!-- END :: profile content -->	
		
	</section>	
	
	<!-- FOOTER FORM -->		
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>