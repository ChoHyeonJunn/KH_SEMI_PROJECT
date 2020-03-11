<%@page import="com.devca.model.dto.profile.SKILL"%>
<%@page import="java.util.List"%>
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

$(function() {
	var i = 0;
	$("#skillList").change(function(){
		if($(".skillbox-items").length < 3){
			var skill = $(this).val();
			
				$("#skillbox").append("<div class='container p-3 my-3 bg-primary text-white skillbox-items'>"+skill+"<span class='click' style='float: right;'><input type='hidden' name='skill_name' value='"+skill+"'>X</span></div>");
			};
		i++;
	});
	
});

$(document).on('click','.click',(function() {
	$(this).parent().remove();
	})
);
//})
//);
//$(function() {
//	$("#skillList").change(function(){
//			var skill = $(this).val(); //체크박스 속성의 블록 옆에 b태그 . b태그의 텍스트
//			$("#skillbox").append("<div class='.skillbox-items'>"+skill+"</div><br/>");
//	});
//});
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
			<article class="col-md-10">
				<div class="card p-4 my-3 bg-white">
					<h1>사용가능한 기술을 선택해주세요.</h1>
						<fieldset>
							<form action="/DEVCA/portfolio/languagepage.do" method="post">
							<input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
							<input type="hidden" id="skill_name" value=""/>
							<div class="skill-main">
								<div class = "skill-item">
									<c:choose>
										<c:when test="${empty skillList }"></c:when>
										<c:otherwise>
											<c:forEach items="${skillList }" var="skillList">
												<div class="container p-3 my-3 bg-dark text-white">${skillList.SKILL }
													<span class='click' style='float: right;'>X</span>
												</div>
											</c:forEach>
										</c:otherwise>
									</c:choose>
									<div class="skill-items" id="skillbox">
									</div>
								</div>
								<div class="input-group mb-3">
									<select class="form-control" id="skillList"  onchange="document.getElementById('skill_name').value = this.options[this.selectedIndex].value">
									    <option disabled="disabled" selected="selected">스킬을 선택하세요.</option>
									    <option value="Visual Basic">Visual Basic</option>
									    <option value="Java">Java</option>
									    <option value="Database">Database</option>
									    <option value="HTML CSS">HTML CSS</option>
									    <option value="Javascript Jquery">Javascript Jquery</option>
									    <option value="C">C</option>
									    <option value="C++">C++</option>
									    <option value="C#">C#</option>
									    <option value="Github">Github</option>
									    <option value="Django">Django</option>
									    <option value="MongoDB">MongoDB</option>
									    <option value="Spring">Spring</option>
									</select>
								</div>
							</div>
							<div class = "skill-warp">
								<a href="#" class="btn btn-primary btn-lg" onclick="location.href='/DEVCA/portfolio/sideprojectpage.do'">이전</a>
								<input class="btn btn-primary btn-lg" type="submit" value="다음" style="float: right;"/>
							</div>
						</form>
					</fieldset>
				</div>
			</article>
		<!-- END :: profile content -->
		</div>
	</section>
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>