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
<style type="text/css">
.blue{
background-color: #5873cc;
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
    <c:forEach var="survey" items="${surveyList }">
      var SURVEY_LANGUAGE = '나의 경력 기간 : ${survey.SURVEY_LANGUAGE}';
      var SURVEY_POSITION = '나의 포지션 : ${survey.SURVEY_POSITION}';
      var SURVEY_BASIC = '공부해본 적 있는 과목-기본지식편 : ${survey.SURVEY_BASIC }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_SERVER = '공부해본 적 있는 과목-언어 및 서버 : ${survey.SURVEY_SERVER }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_DATABASE = '공부해본 적 있는 과목-데이터 베이스 : ${survey.SURVEY_DATABASE }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_FRAMEWORK = '공부해본 적 있는 과목-프레임워크 및 라이브러리 : ${survey.SURVEY_FRAMEWORK }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');

      //var SURVEY_CHECK_NON_MAJOR = '나는 어디 포지션에 맞는 개발자 일까요? : ${survey.SURVEY_CHECK_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      
      var SURVEY_CHECK_NON_MAJOR = '${survey.SURVEY_CHECK_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, '_').split("_");
      
       var sJob = "";
       for(var n = 0 ; n < SURVEY_CHECK_NON_MAJOR.length; n++ ){
         if(SURVEY_CHECK_NON_MAJOR[n].substr(0,1) == '1'){
            if(sJob.indexOf("프론트") != -1 ){// sJob에 프론트가 이미 적혀 있을 경우 0  
                continue;
            }
            sJob = "프론트";  
          } else if (SURVEY_CHECK_NON_MAJOR[n].substr(0,1) == '2'){
              if(sJob.indexOf("백앤드") != -1 ){ // sJob에 백엔드가 이미 적혀 있을 경우 0  
                continue;
             } else {
               if(sJob != ""){
                    sJob += "/";
                 }
                 sJob += "백앤드";
             }
          }
       }   
       sJob += " 개발자 에 적합합니다.";
      var SURVEY_CHECK_NON_MAJOR = '나는 어디 포지션에 맞는 개발자 일까요? : '+sJob;
      var SURVEY_BASIC_NON_MAJOR = '공부해본 적 있는 과목-기본지식편 : ${survey.SURVEY_BASIC_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_SERVER_NON_MAJOR = '공부해본 적 있는 과목-언어 및 서버 : ${survey.SURVEY_SERVER_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_DATABASE_NON_MAJOR = '공부해본 적 있는 과목-데이터 베이스 : ${survey.SURVEY_DATABASE_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      var SURVEY_FRAMEWORK_NON_MAJOR = '공부해본 적 있는 과목-프레임워크 및 라이브러리 : ${survey.SURVEY_FRAMEWORK_NON_MAJOR }'.replace('[','').replace(']','').replace(/, /gi, ' _ ');
      
      $("#surveyList_container")
          .append($("<br class='major'>").text(SURVEY_LANGUAGE))
         .append($("<div class='major font-weight-bold'>").text(SURVEY_LANGUAGE))
         .append($("<br class='major'>").text(SURVEY_LANGUAGE))
         .append($("<div class='major font-weight-bold'>").text(SURVEY_POSITION))
         .append($("<br class='major'>").text(SURVEY_POSITION))
         .append($("<div class='major font-weight-bold'>").text(SURVEY_BASIC))
         .append($("<br class='major'>").text(SURVEY_BASIC))
         .append($("<div class='major font-weight-bold'>").text(SURVEY_SERVER))
         .append($("<br class='major'>").text(SURVEY_SERVER))
         .append($("<div class='major font-weight-bold'>").text(SURVEY_DATABASE))
         .append($("<br class='major'>").text(SURVEY_DATABASE))
         .append($("<div class='major font-weight-bold'>").text(SURVEY_FRAMEWORK))
         .append($("<br class='major'>").text(SURVEY_FRAMEWORK))
         
         .append($("<br class='non_major'>").text(SURVEY_CHECK_NON_MAJOR))
         .append($("<div class='non_major font-weight-bold'>").text(SURVEY_CHECK_NON_MAJOR))
         .append($("<br class='non_major'>").text(SURVEY_CHECK_NON_MAJOR))
         .append($("<div class='non_major font-weight-bold'>").text(SURVEY_BASIC_NON_MAJOR))
         .append($("<br class='non_major'>").text(SURVEY_BASIC_NON_MAJOR))
         .append($("<div class='non_major font-weight-bold'>").text(SURVEY_SERVER_NON_MAJOR))
         .append($("<br class='non_major'>").text(SURVEY_SERVER_NON_MAJOR))
         .append($("<div class='non_major font-weight-bold'>").text(SURVEY_DATABASE_NON_MAJOR))
         .append($("<br class='non_major'>").text(SURVEY_DATABASE_NON_MAJOR))
         .append($("<div class='non_major font-weight-bold'>").text(SURVEY_FRAMEWORK_NON_MAJOR))
          .append($("<br class='non_major'>").text(SURVEY_FRAMEWORK_NON_MAJOR));

    </c:forEach>

    if ($(".major").text().endsWith("null")){
       $(".major").hide();
    } else {
       $(".non_major").hide();
    }
    //alert("var SURVEY_CHECK_NON_MAJOR")
    
    $(".Frontend").click(function() {
      $(".Frontend_page").show();
      $(".Backend_page").hide();
      $(".Full_page").hide();
      alert("프론트기본셋입니다.");
   });
   $(".Backend").click(function() {
      $(".Backend_page").show();
      $(".Frontend_page").hide();
      $(".Full_page").hide();
      alert("백앤드기본셋입니다.")
   });
   $(".Full").click(function() {
      $(".Full_page").show();
      $(".Backend_page").hide();
      $(".Frontend_page").hide();
      alert("풀스택기본셋입니다.");
   });
})
</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>
   
   <section class="container-fluid">
      <div class="row">
         <%@ include file="/views/form/portfoliosidebar.jsp"%>

         <article class="col-md-10">
            <span class="font-weight-bold"style="font-size: 20pt;">MY CARRER</span>
               <button type="button" class="btn btn-secondary btn-sm Frontend">Frontend</button>
               <button type="button" class="btn btn-secondary btn-sm Backend">Backend</button>
               <button type="button" class="btn btn-secondary btn-sm Full">Full</button>
            <div class="card p-4 my-3 bg-white">

               <div id="surveyList_container">
                  <h2 class="font-weight-bold">나의 설문조사 결과</h2>
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
               <!-- 프론트기본셋 -->
               <div class="Frontend_page" style="display: none;">
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm" style="font-size: 15pt; background-color: orange;">
                        General</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Git</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">Github</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm mx-5" style="font-size: 15pt; background-color: orange;"> 언어</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Javascript</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">HTML</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">CSS</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm" style="font-size: 15pt; background-color: orange;">
                        프레임워크&라이브러리</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">React</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">Vue</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Angular</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">BootStrap</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">jQuery</b>
                     </div>
                  </div>
               </div>
               <!-- 백앤드기본셋 -->
               <div class="Backend_page" style="display: none;">
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm mx-5" style="font-size: 15pt; background-color: orange;">
                        General</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Git</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">Github</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Maven</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">Linux</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm" style="font-size: 15pt; background-color: orange;"> 언어</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">JAVA</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm mx-5" style="font-size: 15pt; background-color: orange;">
                        Framework</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Spring</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm" style="font-size: 15pt; background-color: orange;"> WEB</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">WAS</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm mx-5" style="font-size: 15pt; background-color: orange;"> DB</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Oracle</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm" style="font-size: 15pt; background-color: orange;"> 라이브러리</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">ORM</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">Mybatis</b>
                     </div>
                  </div>
               </div>
               <!-- 풀스택기본셋 -->
               <div class="Full_page" style="display: none;">
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm mx-5" style="font-size: 15pt; background-color: orange;">
                        General</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Git</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">Github</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Maven</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">Linux</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm" style="font-size: 15pt; background-color: orange;"> 언어</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">JAVA</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">Javascript</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">CSS</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">HTML</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm mx-5" style="font-size: 15pt; background-color: orange;">
                        Framework</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Spring</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm" style="font-size: 15pt; background-color: orange;"> WEB</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">WAS</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm mx-5" style="font-size: 15pt; background-color: orange;"> DB</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">Oracle</b>
                     </div>
                  </div>
                  <div style="float: left; text-align: center;">
                     <b class="btn btn-secondary btn-sm" style="font-size: 15pt; background-color: orange;"> 라이브러리</b>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">ORM</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm">Mybatis</b>
                     </div>
                     <div>
                        <b class="blue btn btn-secondary btn-sm my-2">BootStrap</b>
                     </div>
                  </div>
               </div>
            </div>
         </article>
      </div>
   </section>
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>