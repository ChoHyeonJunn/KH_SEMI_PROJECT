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
    <c:forEach var="survey" items="${surveyList }">
       var SURVEY_LANGUAGE = '나의 경력 기간 : ${survey.SURVEY_LANGUAGE}';
       var SURVEY_POSITION = '나의 포지션 : ${survey.SURVEY_POSITION}';
      var SURVEY_BASIC = '공부해본 적 있는 과목-기본지식편 : ${survey.SURVEY_BASIC }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_SERVER = '공부해본 적 있는 과목.-언어 및 서버 : ${survey.SURVEY_SERVER }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_DATABASE = '공부해본 적 있는 과목-데이터 베이스 : ${survey.SURVEY_DATABASE }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_FRAMEWORK = '공부해본 적 있는 과목-프레임워크 및 라이브러리 : ${survey.SURVEY_FRAMEWORK }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');

      var SURVEY_CHECK_NON_MAJOR = '나는 어디 포지션에 맞는 개발자 일까요? : ${survey.SURVEY_CHECK_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_BASIC_NON_MAJOR = '공부해본 적 있는 과목-기본지식편 : ${survey.SURVEY_BASIC_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_SERVER_NON_MAJOR = '공부해본 적 있는 과목.-언어 및 서버 : ${survey.SURVEY_SERVER_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_DATABASE_NON_MAJOR = '공부해본 적 있는 과목-데이터 베이스 : ${survey.SURVEY_DATABASE_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_FRAMEWORK_NON_MAJOR = '공부해본 적 있는 과목-프레임워크 및 라이브러리 : ${survey.SURVEY_FRAMEWORK_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      
      $("#surveyList_container")
         .append($("<div class='major'>").text(SURVEY_LANGUAGE))
         .append($("<div class='major'>").text(SURVEY_POSITION))
         .append($("<div class='major'>").text(SURVEY_BASIC))
         .append($("<div class='major'>").text(SURVEY_SERVER))
         .append($("<div class='major'>").text(SURVEY_DATABASE))
         .append($("<div class='major'>").text(SURVEY_FRAMEWORK))
         
         .append($("<div class='non_major'>").text(SURVEY_CHECK_NON_MAJOR))
         .append($("<div class='non_major'>").text(SURVEY_BASIC_NON_MAJOR))
         .append($("<div class='non_major'>").text(SURVEY_SERVER_NON_MAJOR))
         .append($("<div class='non_major'>").text(SURVEY_DATABASE_NON_MAJOR))
         .append($("<div class='non_major'>").text(SURVEY_FRAMEWORK_NON_MAJOR));
    </c:forEach>
})
    $(function() {
      if($(".major").text="null"){
         $(".non_major").hide();
      }else{
         $(".major").hide();
      }
   })

</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>

	<section class="container-fluid">	
		<div class="row">
			<%@ include file="/views/form/portfoliosidebar.jsp"%>	    
			
			<article class="col-md-10">
				<div class="card p-4 my-3 bg-white"> 
					
					<div id="surveyList_container">
			            <h2>나의 설문조사 결과</h2>		            
			        </div>
			        
			     	<c:forEach var="survey" items="${surveyList }">
				     	<div style="display: none;">
					        <div>${survey.SURVEY_LANGUAGE }</div>
					        <div>${survey.SURVEY_POSITION }</div>
					        <div>${survey.SURVEY_BASIC }</div>
					        <div>${survey.SURVEY_SERVER }</div>
					        <div>${survey.SURVEY_DATABASE }</div>
					        <div>${survey.SURVEY_FRAMEWORK }</div>
					        
					        <div>${survey.SURVEY_CHECK_NON_MAJOR }</div>
					        <div>${survey.SURVEY_BASIC_NON_MAJOR }</div>
					        <div>${survey.SURVEY_SERVER_NON_MAJOR }</div>
					        <div>${survey.SURVEY_DATABASE_NON_MAJOR }</div>
					        <div>${survey.SURVEY_FRAMEWORK_NON_MAJOR }</div>
				        </div>
			      	</c:forEach>
				
				</div>
			</article>  
			
			  
			
	      
	      </div>
   </section>
   
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>