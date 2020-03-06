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
.language-insert{
	display: inline-block;
}
.language-insert-center{
	text-align: center;
}
</style>
<!-- START :: css -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

	
	function attachAddr(){
		const str = '<dd class = "langcerts"> '+'<div class="row">'+
				'<div class="col-md-4">'+
				'<div class="input-group mb-3">'+
				'<input type="text" name="language_name" placeholder="시험명" value="${langcertlist.LANGUAGE_CERTIFICATE_NAME }"/>'+
				'<span class="input-group-text"><i class="fas fa-phone"></i></span>'+
				'</div></div> '+
				'<div class="col-md-4">'+
				'<div class="input-group mb-4"><input type="text" name="language_grade" placeholder="점수/등급" value="${langcertlist.LANGUAGE_CERTIFICATE_GRADE }"/> '+
				'<span class="input-group-text"><i class="fas fa-phone"></i></span>'+
				'<span class="click btn btn-primary btn-sm">x</span></div></div></div>'+
				'</dd>';
			
			$("#langcert").append(str);
			
			 return false;
	}
	
		$(document).on('click','.click',(function() {
				$(this).parent().parent().parent().remove();
		
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
	<section class="container-fluid">	
		<div class="row">
			<%@ include file="/views/form/portfoliosidebar.jsp"%>
			<!-- START :: profile content -->
			<article  class="col-md-10">
			<div  class="card p-4 my-3 bg-white">
				<div>
					<h1>외국어 수준을 알려주세요.</h1>
				</div>
				<fieldset>
					<form action="/DEVCA/portfolio/schoolpage.do" method="post">
					<input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
					
						<div class="language-main">	
							<c:forEach items="${languageList }" var="languagelist">
								<input type="hidden" name="language_seq" value="${languagelist.LANGUAGE_SEQ }"/>
								<input type="hidden" id="language" name="language" value="${languagelist.LANGUAGE }"/>
							
							<div class="language-item">
								<div>
									<label>외국어</label>
									<div class="input-group mb-3">
										<select  class="form-control" id="otherselect" onchange="document.getElementById('language').value = this.options[this.selectedIndex].value">
											<option>외국어 선택</option>
											<option value="영어" <c:if test="${languagelist.LANGUAGE eq '영어'}">selected</c:if>>영어</option>
											<option value="일본어" <c:if test="${languagelist.LANGUAGE eq '일본어'}">selected</c:if>>일본어</option>
											<option value="중국어" <c:if test="${languagelist.LANGUAGE eq '중국어'}">selected</c:if>>중국어</option>
											<option value="other">기타</option>
										</select>
									</div>
								<div class="input-group mb-3" id="hidediv">
									<input type="text" id="otherlanguage" name="otherlanguage" placeholder="기타 언어 입력"/>
									<span class="input-group-text"><i class="fas fa-phone"></i></span>
								</div>
								</div>
								<div id = "langcert">
								<c:forEach items="${langcertList }" var="langcertlist">
									<label>어학 시험</label>
									<input type="hidden" name="languagecertificate_seq" value="${langcertlist.LANGUAGE_CERTIFICATE_SEQ }"/>
										<dd class = "langcerts">	
											<div class="row">
												<div class="col-md-4">
													<div class="input-group mb-3">
														<input type="text" name="language_name" placeholder="시험명" value="${langcertlist.LANGUAGE_CERTIFICATE_NAME }"/>
														<span class="input-group-text"><i class="fas fa-phone"></i></span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="input-group mb-4">
														<input type="text" name="language_grade" placeholder="점수/등급" value="${langcertlist.LANGUAGE_CERTIFICATE_GRADE }"/>
														<span class="input-group-text"><i class="fas fa-phone"></i></span>
														<span class="click btn btn-primary btn-sm">x</span>
													</div>
												</div>
											</div>
										</dd>
								</c:forEach>
								</div>	
								<div class="language-insert-center">
									<div class="language-insert">
										<a href="#" class="btn btn-primary btn-sm" onclick="attachAddr();" >+</a>
									</div>
								</div>
							</div>
						</c:forEach>
						</div>
						<div class="">
						
						</div>
					
					<div>
						<input type="button" class="btn btn-primary btn-lg" value="이전" onclick="location.href='/DEVCA/portfolio/sideskillpage.do'"/>
						<input type="submit" class="btn btn-primary btn-lg" value="다음" style="float:right;"/>
					</div>
					</form>
					</fieldset>
				</div>
			</article>
		</div>
	</section>
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>