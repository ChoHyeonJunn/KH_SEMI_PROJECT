<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
   request.setCharacterEncoding("UTF-8");
%>
<%
   response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- HEADER FORM -->
<%@ include file="/views/form/header.jsp"%>

<!-- START :: css -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet"
   type="text/css">
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript"
   src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
   $(document).ready(function() {
      $("#next0").click(function() {
         $("#survey0").hide();
         
         var str1 = $("#survey0 input[type=radio]:checked").val();
         var str2 = '배워본 적이 없습니다.';
         
         if (str1 == str2)
            $("#survey6").show();
         else
            $("#survey1").show();
      });
      $("#next1").click(function() {
         $("#survey1").hide();
         $("#survey2").show();
      });
      $("#next2").click(function() {
         $("#survey2").hide();
         $("#survey3").show();
      });
      $("#next3").click(function() {
         $("#survey3").hide();
         $("#survey4").show();
      });
      $("#next4").click(function() {
         $("#survey4").hide();
         $("#survey5").show();
      });
      $("#next5").click(function() {
         $("#survey5").hide();
         $("#survey12").show();
      });
      $("#next6").click(function() {
         $("#survey6").hide();
         $("#survey7").show();
      });
      $("#next7").click(function() {
         $("#survey7").hide();
         $("#survey8").show();
      });
      $("#next8").click(function() {
         $("#survey8").hide();
         $("#survey9").show();
      })
      $("#next9").click(function() {
         $("#survey9").hide();
         $("#survey10").show();
      })
      $("#next10").click(function() {
         $("#survey10").hide();
         $("#survey11").show();
      })
      $("#next11").click(function() {
         $("#survey11").hide();
         $("#survey13").show();
      })
/* -------------------------------------------------- */
      $("#back12").click(function() {
         $("#survey13").hide();
         $("#survey11").show();
      });
      $("#back11").click(function() {
         $("#survey12").hide();
         $("#survey5").show();
      });
      $("#back10").click(function() {
         $("#survey11").hide();
         $("#survey9").show();
      });
      $("#back10").click(function() {
         $("#survey10").hide();
         $("#survey9").show();
      });
      $("#back9").click(function() {
         $("#survey10").hide();
         $("#survey9").show();
      });
      $("#back8").click(function() {
         $("#survey9").hide();
         $("#survey8").show();
      });
      $("#back7").click(function() {
         $("#survey8").hide();
         $("#survey7").show();
      });
      $("#back6").click(function() {
         $("#survey7").hide();
         $("#survey6").show();
      });
      $("#back5").click(function() {
         $("#survey6").hide();
         $("#survey0").show();
      });
      $("#back4").click(function() {
         $("#survey5").hide();
         $("#survey4").show();
      });
      $("#back3").click(function() {
         $("#survey4").hide();
         $("#survey3").show();
      });
      $("#back2").click(function() {
         $("#survey3").hide();
         $("#survey2").show();
      });
      $("#back1").click(function() {
         $("#survey2").hide();
         $("#survey1").show();
      });
      $("#back0").click(function() {
         $("#survey1").hide();
         $("#survey0").show();
      });
   });
</script>
<!-- END :: JAVASCRIPT -->
</head>
<body>
   <form id="surveyform" action="/DEVCA/member/joinpage.do" method="post">
      <div id="survey0">
         <section>
            <h1>프로그래밍 언어를 배워본적이 있습니까?</h1>
            <div>
               <label for="0-1">배워본 적이 없습니다.</label> <input id="0-1" value="배워본 적이 없습니다."
                  type="radio" name="SURVEY_LANGUAGE">
               <!-- survey6으로 -->
            </div>
            <div>
               <label for="0-2">6개월 이상 프로그램을 배웠습니다.</label> <input id="0-2"
                  value="6개월 이상 프로그램을 배웠습니다." type="radio" name="SURVEY_LANGUAGE">
               <!-- survey1으로 -->
            </div>
            <div>
               <label for="0-3">현직 프로그래머로 일을 한지 1년~3년차 입니다.</label> <input
                  id="0-3" value="현직 프로그래머로 일을 한지 1년~3년차 입니다." type="radio" name="SURVEY_LANGUAGE">
               <!-- survey1으로 -->
            </div>
            <div>
               <label for="0-4">현직 프로그래머로 일을한지 5년 이상되었습니다.</label> <input id="0-4"
                  value="현직 프로그래머로 일을한지 5년 이상되었습니다." type="radio" name="SURVEY_LANGUAGE">
               <!-- survey1으로 -->
            </div>
            <div>
               <input type="button" value="다음" id="next0">
            </div>
         </section>
      </div>

      <div id="survey1" style="display: none;">
         <section>

            <h1>포지션을 선택해 주세요.</h1>

            <div>
               <label for="1-1">프론트 개발자</label> <input id="1-1" value="프론트 개발자"
                  type="radio" name="SURVEY_POSITION">
               <!-- survey1으로 -->
               <!-- 프론트 기본 셋 -->
            </div>
            <div>
               <label for="1-2">백엔드 개발자</label> <input id="1-2" value="백엔드 개발자"
                  type="radio" name="SURVEY_POSITION">
               <!-- survey1으로 -->
               <!-- 백엔드 기본 셋 -->
            </div>
            <div>
               <label for="1-3">풀스택 개발자</label> <input id="1-3" value="풀스택 개발자"
                  type="radio" name="SURVEY_POSITION">
               <!-- survey1으로 -->
               <!-- 풀스텍 기본 셋 -->
            </div>
            <div>
               <input type="button" value="이전" id="back0"> <input
                  type="button" value="다음" id="next1">
            </div>
         </section>
      </div>

      <div id="survey2" style="display: none">
         <section>
            <h1>아래항목 중 공부해본 적 있는 과목에 체크해주세요.-기본지식편(전공)</h1>

            <div>
               <label for="2-1">Git,GitHub</label> <input id="2-1" name="SURVEY_BASIC"
                  value="Git,GitHub" type="checkbox">
            </div>
            <div>
               <label for="2-2">hosting</label> <input id="2-2" name="SURVEY_BASIC"
                  value="hosting" type="checkbox">
            </div>
            <div>
               <label for="2-3">DNS</label> <input id="2-3" name="SURVEY_BASIC"
                  value="DNS" type="checkbox">
            </div>

            <div>
               <label for="2-4">Browser</label> <input id="2-4" name="SURVEY_BASIC"
                  value="Browser" type="checkbox">
            </div>
            
            <div>
               <label for="2-5">tcp/ip</label> <input id="2-5" name="SURVEY_BASIC"
                  value="tcp/ip" type="checkbox">
            </div>

            <div>
               <label for="2-6">http</label> <input id="2-6" name="SURVEY_BASIC"
                  value="http" type="checkbox">
            </div>

            <div>
               <label for="2-7">osi7 layer</label> <input id="2-7" name="SURVEY_BASIC"
                  value="osi7 layer" type="checkbox">
            </div>
            <div>
               <label for="2-8">api</label> <input id="2-8" name="SURVEY_BASIC"
                  value="api" type="checkbox">
            </div>
            <div>
               <label for="2-9">자료구조</label> <input id="2-9" name="SURVEY_BASIC"
                  value="자료구조" type="checkbox">
            </div>
            <div>
               <label for="2-10">알고리즘</label> <input id="2-10" name="SURVEY_BASIC"
                  value="알고리즘" type="checkbox">
            </div>
            <div>
               <input type="button" value="이전" id="back1"> <input
                  type="button" value="다음" id="next2">
            </div>
         </section>
      </div>

      <div id="survey3" style="display: none">
         <section>

            <h1>아래항목 중 공부해본 적 있는 과목에 체크해주세요.-언어 및 서버편(전공)</h1>
            <div>
               <label for="3-1">Python</label> <input id="3-1" name="SURVEY_SERVER"
                  value="Python" type="checkbox">
            </div>
            <div>
               <label for="3-2">java</label> <input id="3-2" name="SURVEY_SERVER"
                  value="java" type="checkbox">
            </div>
            <div>
               <label for="3-3">C#</label> <input id="3-3" name="SURVEY_SERVER" value="C#"
                  type="checkbox">
            </div>
            <div>
               <label for="3-5">Scala</label> <input id="3-5" name="SURVEY_SERVER"
                  value="Scala" type="checkbox">
            </div>
            <div>
               <label for="3-6">HTML</label> <input id="3-6" name="SURVEY_SERVER"
                  value="HTML" type="checkbox">
            </div>
            <div>
               <label for="3-7">CSS</label> <input id="3-7" name="SURVEY_SERVER"
                  value="CSS" type="checkbox">
            </div>
            <div>
               <input type="button" value="이전" id="back2"> <input
                  type="button" value="다음" id="next3">
            </div>
         </section>
      </div>

      <div id="survey4" style="display: none">
         <section>
            <h1>아래항목 중 공부해본 적 있는 과목에 체크해주세요.-데이터 베이스편(전공)</h1>
            <div>
               <label for="4-1">Oracle</label> <input id="4-1" name="SURVEY_DATABASE"
                  value="Oracle" type="checkbox">
            </div>
            <div>
               <label for="4-2">mongoDB</label> <input id="4-2" name="SURVEY_DATABASE"
                  value="mongoDB" type="checkbox">
            </div>
            <div>
               <label for="4-3">MS MQL</label> <input id="4-3" name="SURVEY_DATABASE"
                  value="MS MQL" type="checkbox">
            </div>
            <div>
               <label for="4-4">MariaDB</label> <input id="4-4" name="SURVEY_DATABASE"
                  value="MariaDB" type="checkbox">
            </div>
            <div>
               <label for="4-5">DynamoDB</label> <input id="4-5" name="SURVEY_DATABASE"
                  value="DynamoDB" type="checkbox">
            </div>
            <div>
               <input type="button" value="이전" id="back3"> <input
                  type="button" value="다음" id="next4">
            </div>
         </section>
      </div>

      <div id="survey5" style="display: none">
         <section>
            <h1>아래항목 중 공부해본 적 있는 과목에 체크해주세요.-프레임워크 및 라이브러리편(전공)</h1>
            <div>
               <label for="5-1">Mybatis</label> <input id="5-1" name="SURBEY_FRAMEWORK"
                  value="Mybatis" type="checkbox">
            </div>
            <div>
               <label for="5-2">Hibernate</label> <input id="5-2" name="SURBEY_FRAMEWORK"
                  value="Hibernate" type="checkbox">
            </div>
            <div>
               <label for="5-3">JPA</label> <input id="5-3" name="SURBEY_FRAMEWORK"
                  value="JPA" type="checkbox">
            </div>
            <div>
               <label for="5-4">Node.js</label> <input id="5-4" name="SURBEY_FRAMEWORK"
                  value="Node.js" type="checkbox">
            </div>
            <div>
               <label for="5-5">Flask</label> <input id="5-5" name="SURBEY_FRAMEWORK"
                  value="Flask" type="checkbox">
            </div>
            <div>
               <label for="5-6">Spring</label> <input id="5-6" name="SURBEY_FRAMEWORK"
                  value="Spring" type="checkbox">
            </div>
            <div>
               <label for="5-7">Django</label> <input id="5-7" name="SURBEY_FRAMEWORK"
                  value="Django" type="checkbox">
            </div>
            <div>
               <label for="5-8">React.js</label> <input id="5-8" name="SURBEY_FRAMEWORK"
                  value="React.js" type="checkbox">
            </div>
            <div>
               <label for="5-9">Vue.js</label> <input id="5-9" name="SURBEY_FRAMEWORK"
                  value="Vue.js" type="checkbox">
            </div>
            <div>
               <label for="5-10">Bootstrap</label> <input id="5-10" name="SURBEY_FRAMEWORK"
                  value="Bootstrap" type="checkbox">
            </div>
            <div>
               <label for="5-11">jQuery</label> <input id="5-11" name="SURBEY_FRAMEWORK"
                  value="jQuery" type="checkbox">
            </div>
            <div>
               <input type="button" value="이전" id="back4"> <input
                  type="button" value="다음" id="next5">
            </div>
         </section>
      </div>

      <div id="survey6" style="display: none">
         <section>
            <h1>개발자를 되는 것을 고민하고 있으신가요? 해당하는 부분에 체크해보세요 :) (비전공)</h1>
            <div>
               <label for="6-1">궁금한 게 있으면 꼭 찾아보는 편이다.</label> <input id="6-1"
                  name="NON_MAJOR" value="궁금한 게 있으면 꼭 찾아보는 편이다." type="checkbox">
            </div>
            <div>
               <label for="6-2">원인과 결과의 인과관계로 설명하는 것을 좋아한다.</label> <input
                  id="6-2" name="NON_MAJOR" value="원인과 결과의 인과관계로 설명하는 것을 좋아한다."
                  type="checkbox">
            </div>
            <div>
               <label for="6-3">문서파일의 성능이나 용도에 따라 잘 정리하는 편이다.</label> <input
                  id="6-3" name="NON_MAJOR" value="문서파일의 성능이나 용도에 따라 잘 정리하는 편이다."
                  type="checkbox">
            </div>
            <div>
               <label for="6-4">좋아하는 건 하루종일해도 계속할 수 있다.</label> <input id="6-4"
                  name="NON_MAJOR" value="좋아하는 건 하루종일해도 계속할 수 있다." type="checkbox">
            </div>
            <div>
               <label for="6-5">이해력이 높고, 빠르게 학습할 수 있습니다.</label> <input id="6-5"
                  name="NON_MAJOR" value="이해력이 높고, 빠르게 학습할 수 있습니다." type="checkbox">
            </div>
            <div>
               <label for="6-6">문제를 효율적으로 해결하려고 노력합니다.</label> <input id="6-6"
                  name="NON_MAJOR" value="문제를 효율적으로 해결하려고 노력합니다." type="checkbox">
            </div>
            <div>
               <input type="button" value="이전" id="back5"> <input
                  type="button" value="다음" id="next6">
            </div>
         </section>
      </div>
      <div id="survey7" style="display: none">
         <section>
            <h1>해당되는 부분에 체크해주세요.(비전공)</h1>
            <div>
               <label for="7-1">저는 기술적인 사람이면서도 시각적인 사람입니다.</label> <input id="7-1"
                  name="SURBEY_CHECK_NON_MAJOR" value="저는 기술적인 사람이면서도 시각적인 사람입니다." type="checkbox">
            </div>
            <div>
               <label for="7-2">디지털 플랫폼과 상호작용하는 방식에 관심이 많습니다.</label> <input
                  id="7-2" name="SURBEY_CHECK_NON_MAJOR" value="디지털 플랫폼과 상호작용하는 방식에 관심이 많습니다." type="checkbox">
            </div>
            <div>
               <label for="7-3">다른 팀들과 유연하게 긴밀히 협력하는 것을 좋아합니다</label> <input
                  id="7-3" name="SURBEY_CHECK_NON_MAJOR" value="다른 팀들과 유연하게 긴밀히 협력하는 것을 좋아합니다" type="checkbox">
            </div>
            <div>
               <label for="7-4">사용자 경험에서의 문제를 정확하게 발견할 수 있습니다.</label> <input
                  id="7-4" name="SURBEY_CHECK_NON_MAJOR" value="사용자 경험에서의 문제를 정확하게 발견할 수 있습니다." type="checkbox">
            </div>
            <div>
               <label for="7-5">예술적인 창의성을 실제 서비스에 반영하고 싶습니다</label> <input
                  id="7-5" name="SURBEY_CHECK_NON_MAJOR" value="예술적인 창의성을 실제 서비스에 반영하고 싶습니다" type="checkbox">
            </div>
            <div>
               <label for="7-6">데이터를 다루는 것을 좋아합니다.</label> <input id="7-6"
                  name="SURBEY_CHECK_NON_MAJOR" value="데이터를 다루는 것을 좋아합니다." type="checkbox">
            </div>
            <div>
               <label for="7-7">가장 효과적이고 효율적인 솔루션을 내는 것에 자신 있습니다.</label> <input
                  id="7-7" name="SURBEY_CHECK_NON_MAJOR" value="가장 효과적이고 효율적인 솔루션을 내는 것에 자신 있습니다." type="checkbox">
            </div>
            <div>
               <input type="button" value="이전" id="back6"> <input
                  type="button" value="다음" id="next7">
            </div>
         </section>
      </div>
      
      <div id="survey8" style="display: none">
         <section>
            <h1>아래항목 중 공부해본 적 있는 과목에 체크해주세요.-기본지식편(비전공)</h1>

            <div>
               <label for="8-1">Git,GitHub</label> <input id="8-1" name="SURBEY_BASIC_NON_MAJOR"
                  value="Git,GitHub" type="checkbox">
            </div>
            <div>
               <label for="8-2">hosting</label> <input id="8-2" name="SURBEY_BASIC_NON_MAJOR"
                  value="hosting" type="checkbox">
            </div>
            <div>
               <label for="8-3">DNS</label> <input id="8-3" name="SURBEY_BASIC_NON_MAJOR"
                  value="DNS" type="checkbox">
            </div>

            <div>
               <label for="8-4">Browser</label> <input id="8-4" name="SURBEY_BASIC_NON_MAJOR"
                  value="Browser" type="checkbox">
            </div>

            <div>
               <label for="8-5">tcp/ip</label> <input id="8-5" name="SURBEY_BASIC_NON_MAJOR"
                  value="tcp/ip" type="checkbox">
            </div>

            <div>
               <label for="8-6">http</label> <input id="8-6" name="SURBEY_BASIC_NON_MAJOR"
                  value="http" type="checkbox">
            </div>

            <div>
               <label for="8-7">osi7 layer</label> <input id="8-7" name="SURBEY_BASIC_NON_MAJOR"
                  value="osi7 layer" type="checkbox">
            </div>
            <div>
               <label for="8-8">api</label> <input id="8-8" name="SURBEY_BASIC_NON_MAJOR"
                  value="api" type="checkbox">
            </div>
            <div>
               <label for="8-9">자료구조</label> <input id="8-9" name="SURBEY_BASIC_NON_MAJOR"
                  value="자료구조" type="checkbox">
            </div>
            <div>
               <label for="8-10">알고리즘</label> <input id="8-10" name="SURBEY_BASIC_NON_MAJOR"
                  value="알고리즘" type="checkbox">
            </div>
            <div>
               <input type="button" value="이전" id="back7"> <input
                  type="button" value="다음" id="next8">
            </div>
         </section>
      </div>
      
      <div id="survey9" style="display: none">
         <section>

            <h1>아래항목 중 공부해본 적 있는 과목에 체크해주세요.-언어 및 서버편(비전공)</h1>
            <div>
               <label for="9-1">Python</label> <input id="9-1" name="SURBEY_SERVER_NON_MAJOR"
                  value="Python" type="checkbox">
            </div>
            <div>
               <label for="9-2">java</label> <input id="9-2" name="SURBEY_SERVER_NON_MAJOR"
                  value="java" type="checkbox">
            </div>
            <div>
               <label for="9-3">C#</label> <input id="9-3" name="SURBEY_SERVER_NON_MAJOR" value="C#"
                  type="checkbox">
            </div>
            <div>
               <label for="9-5">Scala</label> <input id="9-5" name="SURBEY_SERVER_NON_MAJOR"
                  value="Scala" type="checkbox">
            </div>
            <div>
               <label for="9-6">HTML</label> <input id="9-6" name="SURBEY_SERVER_NON_MAJOR"
                  value="HTML" type="checkbox">
            </div>
            <div>
               <label for="9-7">CSS</label> <input id="9-7" name="SURBEY_SERVER_NON_MAJOR"
                  value="CSS" type="checkbox">
            </div>
            <div>
               <input type="button" value="이전" id="back8"> <input
                  type="button" value="다음" id="next9">
            </div>
         </section>
      </div>
      
      <div id="survey10" style="display: none">
         <section>
            <h1>아래항목 중 공부해본 적 있는 과목에 체크해주세요.-데이터 베이스편(비전공)</h1>
            <div>
               <label for="10-1">Oracle</label> <input id="10-1" name="SURBEY_DATABASE_NON_MAJOR"
                  value="Oracle" type="checkbox">
            </div>
            <div>
               <label for="10-2">mongoDB</label> <input id="10-2" name="SURBEY_DATABASE_NON_MAJOR"
                  value="mongoDB" type="checkbox">
            </div>
            <div>
               <label for="10-3">MS MQL</label> <input id="10-3" name="SURBEY_DATABASE_NON_MAJOR"
                  value="MS MQL" type="checkbox">
            </div>
            <div>
               <label for="10-4">MariaDB</label> <input id="10-4" name="SURBEY_DATABASE_NON_MAJOR"
                  value="MariaDB" type="checkbox">
            </div>
            <div>
               <label for="10-5">DynamoDB</label> <input id="10-5" name="SURBEY_DATABASE_NON_MAJOR"
                  value="DynamoDB" type="checkbox">
            </div>
            <div>
               <input type="button" value="이전" id="back9"> <input
                  type="button" value="다음" id="next10">
            </div>
         </section>
      </div>
      
      <div id="survey11" style="display: none">
         <section>
            <h1>아래항목 중 공부해본 적 있는 과목에 체크해주세요.-프레임워크 및 라이브러리편(비전공)</h1>
            <div>
               <label for="11-1">Mybatis</label> <input id="11-1" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="Mybatis" type="checkbox">
            </div>
            <div>
               <label for="11-2">Hibernate</label> <input id="11-2" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="Hibernate" type="checkbox">
            </div>
            <div>
               <label for="11-3">JPA</label> <input id="11-3" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="JPA" type="checkbox">
            </div>
            <div>
               <label for="11-4">Node.js</label> <input id="11-4" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="Node.js" type="checkbox">
            </div>
            <div>
               <label for="11-5">Flask</label> <input id="11-5" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="Flask" type="checkbox">
            </div>
            <div>
               <label for="11-6">Spring</label> <input id="11-6" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="Spring" type="checkbox">
            </div>
            <div>
               <label for="11-7">Django</label> <input id="11-7" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="Django" type="checkbox">
            </div>
            <div>
               <label for="11-8">React.js</label> <input id="11-8" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="React.js" type="checkbox">
            </div>
            <div>
               <label for="11-9">Vue.js</label> <input id="11-9" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="Vue.js" type="checkbox">
            </div>
            <div>
               <label for="11-10">Bootstrap</label> <input id="11-10" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="Bootstrap" type="checkbox">
            </div>
            <div>
               <label for="11-11">jQuery</label> <input id="11-11" name="SURBEY_FRAMEWORK_NON_MAJOR"
                  value="jQuery" type="checkbox">
            </div>
            <div>
               <input type="button" value="이전" id="back10"> <input
                  type="button" value="다음" id="next11">
            </div>
         </section>
      </div>
      
      <div id="survey12" style="display: none">
         <section>
            <h1>종합결과 (전공)</h1>
            <!-- <div>
               <span id="chk01"></span>
            </div>
            <div>
               <div id="chk02"></div>
            </div>
            <div>
               <span id="chk03"></span>
            </div> -->
            <h2 style="text-align: center;">답변을 바탕으로</h2>
            <br>
            <h2 style="text-align: center;">나의 커리어 설계와 스킬에 맞는</h2>
            <h2 style="text-align: center;">10년의 개발 스터디 플랜을 짜드립니다.</h2>
            <input type="button" value="이전" id="back11"> <input
               type="submit" value="회원가입">
         </section>
      </div>
      <div id="survey13" style="display: none">
         <section>
            <h1>종합결과 (비전공)</h1>
            <!-- <div>
               <span id="chk01"></span>
            </div>
            <div>
               <div id="chk02"></div>
            </div>
            <div>
               <span id="chk03"></span>
            </div> -->
            <h2 style="text-align: center;">답변을 바탕으로</h2>
            <br>
            <h2 style="text-align: center;">나의 커리어 설계와 스킬에 맞는</h2>
            <h2 style="text-align: center;">10년의 개발 스터디 플랜을 짜드립니다.</h2>
            <input type="button" value="이전" id="back12"> <input
               type="submit" value="회원가입">
         </section>
      </div>
   </form>
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>