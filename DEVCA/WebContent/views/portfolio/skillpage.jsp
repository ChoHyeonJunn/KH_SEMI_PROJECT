<%@page import="com.devca.model.dto.SKILL"%>
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
section {
	height: 800px;
}

article {
	position: absolute;
	right: 5px;
	left: 250px;
	height: 100%;
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
//
//	$(document).ready(function(){
//		$("#job3").chosen({
//		    width:"50%",
//		}); 
//	})
$(document).ready(function(){
	if($('.skillbox-items').length < 3){
		$('#skillList').change(function() {
			 $('#skillbox').html('<div class="skillbox-items">'+$("#skillList option:selected").val()+'</div>');
		});
	}
});

  
  

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
		<fieldset>
		<form action="/DEVCA/portfolio/languagepage.do" method="post">
		<input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
		<div class="skill-main">
			<div class = "skill-item">
				<div class="skill-items" id="skillbox">
				<c:choose>
				<c:when test="${empty skillList }"></c:when>
					<c:otherwise>
						<c:forEach items="${skillList }" var="skillList">
							<div class="skillbox-items">${skillList.SKILL }</div>				
						</c:forEach>
					</c:otherwise>
				</c:choose>
				</div>
			</div>
			<div class="skill-search">
				<select id="skillList">
				    <option value="0">스킬을 선택하세요.</option>
				    <option value="Visual Basic">Visual Basic</option>
				    <option value="Java">Java</option>
				    <option value="Database">Database</option>
				    <option value="htmlcss">html/css</option>
				    <option value="javascriptjquery">javascript/jquery</option>
				    <option value="C">C</option>
				    <option value="C++">C++</option>
				    <option value="C#">C#</option>
				    <option value="github">gitbub</option>
				    <option value="Django">Django</option>
				    <option value="mongoDB">mongoDB</option>
				    <option value="Spring">Spring</option>
				</select>
			</div>
		</div>
		<div class = "skill-warp">
			<a href="#" onclick="location.href='/DEVCA/portfolio/sideprojectpage.do?member_code=${sessionLoginMember.MEMBER_CODE}'">이전</a>
			<input type="submit" value="다음"/>
		</div>
		
		</form>
		</fieldset>
	</article>
		<!-- END :: profile content -->
	</section>
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>