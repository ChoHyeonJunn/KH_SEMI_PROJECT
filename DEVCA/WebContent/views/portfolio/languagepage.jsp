<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- HEADER FORM -->
<%@ include file="/views/form/header.jsp"%>

<style type="text/css">
section {
	height: 800px;
}

article {
	position: absolute;
	right: 5px;
	left: 250px;
	height: 100%;
}
.language-insert{
	display: inline-block;
}
.language-insert-center{
	text-align: center;
}
</style>
<!-- START :: css -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/DEVCA/resources/css/chosen.css" type="text/css"/>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!-- SELECT :: search -->
<script type="text/javascript" src="/DEVCA/resources/js/chosen.jquery.js"/></script>

<!-- SELECT :: search -->
<script type="text/javascript">

	$(function(){
		if($("#otherselect").val() == "other"){
			$('input[name = otherlanguage]').show();
		}else{
			$('input[name = otherlanguage]').hide();
		}
	});
	
	function attachAddr(){
		const str = '<li> '+
				'<input type="text" name="language_name" placeholder="시험명" value="${langcertlist.LANGUAGE_CERTIFICATE_NAME }"/> '+
				'<input type="text" name="language_grade" placeholder="점수/등급" value="${langcertlist.LANGUAGE_CERTIFICATE_GRADE }"/> '+
				'<span class="click">x</span> <br/><br/>'+
				'</li>';
			
			$("#langcert").append(str);
			
			 return false;
	}
	
		$(document).on('click','.click',(function() {
				$(this).parent().remove();
		
			})
		);

		


</script>
<!-- 값 세팅법 :: $("#SkillBox").val("bb").trigger("chosen:updated"); -->
<!-- END :: JAVASCRIPT -->
<c:if
	test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver}">
	<jsp:forward page="/DEVCA/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
</head>
<body>
	<section>	
	<%@ include file="/views/form/portfoliosidebar.jsp"%>
	<!-- START :: profile content -->
		<article>
		<div>
			<h1>외국어 수준을 알려주세요.</h1>
		</div>
		
			<form action="/DEVCA/portfolio/schoolpage.do" method="post">
			<input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
			<fieldset>
				<div class="language-main">
					
					<c:forEach items="${languageList }" var="languagelist">
					<input type="hidden" name="language_seq" value="${languagelist.LANGUAGE_SEQ }"/>
					<div class="language-item">
						<div class="language-items">
							<label>외국어</label>
						<select id="otherselect" name="language">
							<option>외국어 선택</option>
							<option value="영어" <c:if test="${languagelist.LANGUAGE eq '영어'}">selected</c:if>>영어</option>
							<option value="일본어" <c:if test="${languagelist.LANGUAGE eq '일본어'}">selected</c:if>>일본어</option>
							<option value="중국어" <c:if test="${languagelist.LANGUAGE eq '중국어'}">selected</c:if>>중국어</option>
							<option value="other">기타</option>
						</select>
						<input type="text" name="otherlanguage" placeholder="입력해 주세요." style="display:none;"/>
						</div>
						<div id = "langcert">
						<c:forEach items="${langcertList }" var="langcertlist">
						<input type="hidden" name="languagecertificate_seq" value="${langcertlist.LANGUAGE_CERTIFICATE_SEQ }"/>
							<label>어학 시험</label>
								<li>
									<input type="text" name="language_name" placeholder="시험명" value="${langcertlist.LANGUAGE_CERTIFICATE_NAME }"/>
									<input type="text" name="language_grade" placeholder="점수/등급" value="${langcertlist.LANGUAGE_CERTIFICATE_GRADE }"/>
									<span class="click">x</span>
									<br/><br/>
								</li>
						</c:forEach>
						</div>	
						<div class="language-insert-center">
							<div class="language-insert">
								<a href="#" onclick="attachAddr();" >+</a>
							</div>
						</div>
					</div>
				</c:forEach>
				</div>
				<div class="">
				
				</div>
			</fieldset>
			<div>
				<input type="button" value="이전" onclick="location.href='/DEVCA/portfolio/sideskillpage.do?member_code=${sessionLoginMember.MEMBER_CODE }'"/>
				<input type="submit" value="다음" style="float:right;"/>
			</div>
			</form>
			
		</article>
	
	</section>
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>