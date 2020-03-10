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
   <style type="text/css">
   label{
   font-weight: bold;
   }
   </style>
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
         if ($('input:radio[name="SURVEY_LANGUAGE"]:checked').length >= 1) {
            $("#survey0").hide();
            var str1 = $("#survey0 input[type=radio]:checked").val();
            var str2 = '배워본 적이 없습니다.';
            if (str1 == str2)
               $("#survey6").show();
            else
               $("#survey1").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
      });
      $('#next1').click(function() {
         if ($('input:radio[name="SURVEY_POSITION"]:checked').length >= 1) {
            $("#survey1").hide();
            $("#survey2").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
      })
      $('#next2').click(function() {
         if ($("input:checkbox[name='SURVEY_BASIC']").is(":checked")) {
            $("#survey2").hide();
            $("#survey3").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
      })
      $('#next3').click(function() {
         if ($("input:checkbox[name='SURVEY_SERVER']").is(":checked")) {
            $("#survey3").hide();
            $("#survey4").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
      })
      $('#next4').click(function() {
         if ($("input:checkbox[name='SURVEY_DATABASE']").is(":checked")) {
            $("#survey4").hide();
            $("#survey5").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
      })
      $('#next5').click(function() {
         if ($("input:checkbox[name='SURBEY_FRAMEWORK']").is(":checked")) {
            $("#survey5").hide();
            $("#survey12").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
      })
      $("#next6").click(function() {
         $("#survey6").hide();
         $("#survey7").show();
      });
      $('#next7').click(function() {
         if ($("input:checkbox[name='SURBEY_CHECK_NON_MAJOR']").is(":checked")) {
            $("#survey7").hide();
            $("#survey8").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
      })
      $('#next8').click(function() {
         if ($("input:checkbox[name='SURBEY_BASIC_NON_MAJOR']").is(":checked")) {
            $("#survey8").hide();
            $("#survey9").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
      })
      $('#next9').click(function() {
         if ($("input:checkbox[name='SURBEY_SERVER_NON_MAJOR']").is(":checked")) {
            $("#survey9").hide();
            $("#survey10").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
      })
      $('#next10').click(function() {
         if ($("input:checkbox[name='SURBEY_DATABASE_NON_MAJOR']").is(":checked")) {
            $("#survey10").hide();
            $("#survey11").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
      })
      $('#next11').click(function() {
         if ($("input:checkbox[name='SURBEY_FRAMEWORK_NON_MAJOR']").is(":checked")) {
            $("#survey11").hide();
            $("#survey13").show();
         } else {
            alert("하나 이상 체크해 주세요.")
         }
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
 <section class="container-fluid">
 <div class="row">
 <article class="col-md-12">
 <div class="card p-4 my-3 bg-white">
   <form id="surveyform" action="/DEVCA/member/joinpage.do" method="post">
      <div id="survey0">
         <section>
            <h2 class="font-weight-bold">프로그래밍 언어를 배워본적이 있습니까?</h2>
            <br>
            <div class="custom-control custom-radio">
               <input class="custom-control-input" id="0-1" value="배워본 적이 없습니다."type="radio" name="SURVEY_LANGUAGE" required="required">
               <label class="custom-control-label" for="0-1">
               <b>배워본 적이 없습니다.</b>
               </label> 
               <!-- survey6으로 -->
            </div>
            <div class="custom-control custom-radio">
               <input class="custom-control-input" id="0-2" value="6개월 이상 프로그램을 배웠습니다." type="radio" name="SURVEY_LANGUAGE" required="required">
               <label class="custom-control-label" for="0-2"><b>6개월 이상 프로그램을 배웠습니다.</b></label> 
               <!-- survey1으로 -->
            </div>
            <div class="custom-control custom-radio">
               <input class="custom-control-input" id="0-3" value="현직 프로그래머로 일을 한지 1년~3년차 입니다." type="radio" name="SURVEY_LANGUAGE" required="required">
               <label class="custom-control-label" for="0-3"><b>현직 프로그래머로 일을 한지 1년~3년차 입니다.</b></label> 
               <!-- survey1으로 -->
            </div>
            <div class="custom-control custom-radio">
               <input class="custom-control-input" id="0-4" value="현직 프로그래머로 일을한지 5년 이상되었습니다." type="radio" name="SURVEY_LANGUAGE" required="required">
               <label class="custom-control-label" for="0-4"><b>현직 프로그래머로 일을한지 5년 이상되었습니다.</b></label> 
               <!-- survey1으로 -->
            </div>
            <br>
            <div>
               <input class="btn btn-primary btn-lg" style="float: right;" type="button" value="다음" id="next0">
            </div>
         </section>
      </div>

      <div id="survey1" style="display: none;">
         <section>

            <h2 class="font-weight-bold">포지션을 선택해 주세요.</h2>
         <br>
            <div class="custom-control custom-radio">
               <input class="custom-control-input" id="1-1" value="프론트 개발자"type="radio" name="SURVEY_POSITION">
               <label class="custom-control-label" for="1-1"><b>프론트 개발자</b></label> 
               <!-- survey1으로 -->
               <!-- 프론트 기본 셋 -->
            </div>
            <div class="custom-control custom-radio">
               <input class="custom-control-input" id="1-2" value="백엔드 개발자"type="radio" name="SURVEY_POSITION">
               <label class="custom-control-label" for="1-2"><b>백엔드 개발자</b></label> 
               <!-- survey1으로 -->
               <!-- 백엔드 기본 셋 -->
            </div>
            <div class="custom-control custom-radio">
               <input class="custom-control-input" id="1-3"value="풀스택 개발자"type="radio" name="SURVEY_POSITION">
               <label class="custom-control-label" for="1-3"><b>풀스택 개발자</b></label>
               <!-- survey1으로 -->
               <!-- 풀스텍 기본 셋 -->
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back0"> 
               <input style="float: right;" class="btn btn-secondary btn-lg" type="button" value="다음" id="next1">
            </div>
         </section>
      </div>

      <div id="survey2" name="survey2" style="display: none">
         <section>
            <h2 class="font-weight-bold">아래항목 중 공부해본 적 있는 과목에 모두 체크해주세요.</h2>

            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-1"name="SURVEY_BASIC"value="Git,GitHub" type="checkbox">
               <label class="custom-control-label" for="2-1">Git,GitHub</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-2" name="SURVEY_BASIC" value="hosting" type="checkbox">
               <label class="custom-control-label" for="2-2">hosting</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-3" name="SURVEY_BASIC" value="DNS" type="checkbox">
               <label class="custom-control-label" for="2-3">DNS</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-4" name="SURVEY_BASIC"value="Browser" type="checkbox">
               <label class="custom-control-label" for="2-4">Browser</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-5" name="SURVEY_BASIC"value="tcp/ip" type="checkbox">
               <label class="custom-control-label" for="2-5">tcp/ip</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-6" name="SURVEY_BASIC"value="http" type="checkbox">
               <label class="custom-control-label" for="2-6">http</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-7" name="SURVEY_BASIC"value="osi7 layer" type="checkbox">
               <label class="custom-control-label" for="2-7">osi7 layer</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-8" name="SURVEY_BASIC"value="api" type="checkbox">
               <label class="custom-control-label" for="2-8">api</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-9" name="SURVEY_BASIC"value="자료구조" type="checkbox">
               <label class="custom-control-label" for="2-9">자료구조</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-10" name="SURVEY_BASIC"value="알고리즘" type="checkbox">
               <label class="custom-control-label" for="2-10">알고리즘</label>
            </div>
             <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="2-11" name="SURVEY_BASIC"value="해당 사항이 없습니다" type="checkbox">
               <label class="custom-control-label" for="2-11">해당 사항이 없습니다</label>
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back1">
               <input style="float: right;" class="btn btn-primary btn-lg" type="button" value="다음" id="next2">
            </div>
         </section>
      </div>

      <div id="survey3" style="display: none">
         <section>

            <h2 class="font-weight-bold">아래항목 중 공부해본 적 있는 과목에 모두 체크해주세요.</h2>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="3-1" name="SURVEY_SERVER"value="Python" type="checkbox">
               <label class="custom-control-label" for="3-1">Python</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="3-2" name="SURVEY_SERVER"value="java" type="checkbox">
               <label class="custom-control-label" for="3-2">java</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="3-3" name="SURVEY_SERVER" value="C#"type="checkbox">
               <label class="custom-control-label" for="3-3">C#</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="3-5" name="SURVEY_SERVER"value="Scala" type="checkbox">
               <label class="custom-control-label" for="3-5">Scala</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="3-6" name="SURVEY_SERVER"value="HTML" type="checkbox">
               <label class="custom-control-label" for="3-6">HTML</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="3-7" name="SURVEY_SERVER"value="CSS" type="checkbox">
               <label class="custom-control-label" for="3-7">CSS</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="3-8" name="SURVEY_SERVER"value="해당 사항이 없습니다" type="checkbox">
               <label class="custom-control-label" for="3-8">해당 사항이 없습니다</label>
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back2">
               <input style="float: right;" class="btn btn-primary btn-lg" type="button" value="다음" id="next3">
            </div>
         </section>
      </div>

      <div id="survey4" style="display: none">
         <section>
            <h2 class="font-weight-bold">아래항목 중 공부해본 적 있는 과목에 모두 체크해주세요.</h2>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="4-1" name="SURVEY_DATABASE"value="Oracle" type="checkbox">
               <label class="custom-control-label" for="4-1">Oracle</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="4-2" name="SURVEY_DATABASE"value="mongoDB" type="checkbox">
               <label class="custom-control-label" for="4-2">mongoDB</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="4-3" name="SURVEY_DATABASE"value="MS MQL" type="checkbox">
               <label class="custom-control-label" for="4-3">MS MQL</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="4-4" name="SURVEY_DATABASE"value="MariaDB" type="checkbox">
               <label class="custom-control-label" for="4-4">MariaDB</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="4-5" name="SURVEY_DATABASE"value="DynamoDB" type="checkbox">
               <label class="custom-control-label" for="4-5">DynamoDB</label>
            </div>
             <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="4-6" name="SURVEY_DATABASE"value="해당 사항이 없습니다" type="checkbox">
               <label class="custom-control-label" for="4-6">해당 사항이 없습니다</label>
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back3">
               <input style="float: right;" class="btn btn-primary btn-lg" type="button" value="다음" id="next4">
            </div>
         </section>
      </div>

      <div id="survey5" style="display: none">
         <section>
            <h2 class="font-weight-bold">아래항목 중 공부해본 적 있는 과목에 모두 체크해주세요.</h2>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-1" name="SURBEY_FRAMEWORK"value="Mybatis" type="checkbox">
               <label class="custom-control-label" for="5-1">Mybatis</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-2" name="SURBEY_FRAMEWORK"value="Hibernate" type="checkbox">
               <label class="custom-control-label" for="5-2">Hibernate</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-3" name="SURBEY_FRAMEWORK"value="JPA" type="checkbox">
               <label class="custom-control-label" for="5-3">JPA</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-4" name="SURBEY_FRAMEWORK"value="Node.js" type="checkbox">
               <label class="custom-control-label" for="5-4">Node.js</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-5" name="SURBEY_FRAMEWORK"value="Flask" type="checkbox">
               <label class="custom-control-label" for="5-5">Flask</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-6" name="SURBEY_FRAMEWORK"value="Spring" type="checkbox">
               <label class="custom-control-label" for="5-6">Spring</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-7" name="SURBEY_FRAMEWORK"value="Django" type="checkbox">
               <label class="custom-control-label" for="5-7">Django</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-8" name="SURBEY_FRAMEWORK"value="React.js" type="checkbox">
               <label class="custom-control-label" for="5-8">React.js</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-9" name="SURBEY_FRAMEWORK"value="Vue.js" type="checkbox">
               <label class="custom-control-label" class="custom-control-label" for="5-9">Vue.js</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-10" name="SURBEY_FRAMEWORK"value="Bootstrap" type="checkbox">
               <label class="custom-control-label" class="custom-control-label" for="5-10">Bootstrap</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-11" name="SURBEY_FRAMEWORK"value="jQuery" type="checkbox">
               <label class="custom-control-label" for="5-11">jQuery</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="5-12" name="SURBEY_FRAMEWORK"value="해당 사항이 없습니다" type="checkbox">
               <label class="custom-control-label" for="5-12">해당 사항이 없습니다</label>
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back4">
               <input style="float: right;" class="btn btn-primary btn-lg" type="button" value="다음" id="next5">
            </div>
         </section>
      </div>

      <div id="survey6" style="display: none">
         <section>
            <h2 class="font-weight-bold">개발자를 되는 것을 고민하고 있으신가요? 해당하는 부분에 체크해보세요 :)</h2>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="6-1" name="NON_MAJOR" value="궁금한 게 있으면 꼭 찾아보는 편이다." type="checkbox">
               <label class="custom-control-label" for="6-1">궁금한 게 있으면 꼭 찾아보는 편이다.</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="6-2" name="NON_MAJOR" value="원인과 결과의 인과관계로 설명하는 것을 좋아한다."type="checkbox">
               <label class="custom-control-label" for="6-2">원인과 결과의 인과관계로 설명하는 것을 좋아한다.</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="6-3" name="NON_MAJOR" value="문서파일의 성능이나 용도에 따라 잘 정리하는 편이다."type="checkbox">
               <label class="custom-control-label" for="6-3">문서파일의 성능이나 용도에 따라 잘 정리하는 편이다.</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="6-4" name="NON_MAJOR" value="좋아하는 건 하루종일해도 계속할 수 있다." type="checkbox">
               <label class="custom-control-label" for="6-4">좋아하는 건 하루종일해도 계속할 수 있다.</label> 
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="6-5"name="NON_MAJOR" value="이해력이 높고, 빠르게 학습할 수 있습니다." type="checkbox">
               <label class="custom-control-label" for="6-5">이해력이 높고, 빠르게 학습할 수 있습니다.</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="6-6"name="NON_MAJOR" value="문제를 효율적으로 해결하려고 노력합니다." type="checkbox">
               <label class="custom-control-label" for="6-6">문제를 효율적으로 해결하려고 노력합니다.</label>
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back5">
               <input style="float: right;" class="btn btn-primary btn-lg" type="button" value="다음" id="next6">
            </div>
         </section>
      </div>
      
      <div id="survey7" style="display: none">
         <section>
            <h2 class="font-weight-bold">해당되는 부분에 모두 체크해주세요.</h2>
            <!-- 
               100 : 프론트
               200 : 백엔드
             -->
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="7-1"name="SURBEY_CHECK_NON_MAJOR" value="110" type="checkbox">
               <label class="custom-control-label" for="7-1">저는 기술적인 사람이면서도 시각적인 사람입니다.</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="7-2" name="SURBEY_CHECK_NON_MAJOR" value="120" type="checkbox">
               <label class="custom-control-label" for="7-2">디지털 플랫폼과 상호작용하는 방식에 관심이 많습니다.</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="7-3" name="SURBEY_CHECK_NON_MAJOR" value="130" type="checkbox">
               <label class="custom-control-label" for="7-3">다른 팀들과 유연하게 긴밀히 협력하는 것을 좋아합니다</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="7-4" name="SURBEY_CHECK_NON_MAJOR" value="140" type="checkbox">
              <label class="custom-control-label" for="7-4">사용자 경험에서의 문제를 정확하게 발견할 수 있습니다.</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="7-5" name="SURBEY_CHECK_NON_MAJOR" value="150" type="checkbox">
               <label class="custom-control-label" for="7-5">예술적인 창의성을 실제 서비스에 반영하고 싶습니다</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="7-6"name="SURBEY_CHECK_NON_MAJOR" value="210" type="checkbox">
               <label class="custom-control-label" for="7-6">데이터를 다루는 것을 좋아합니다.</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="7-7" name="SURBEY_CHECK_NON_MAJOR" value="220" type="checkbox">
               <label class="custom-control-label" for="7-7">가장 효과적이고 효율적인 솔루션을 내는 것에 자신 있습니다.</label>
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back6">
               <input style="float: right;" class="btn btn-primary btn-lg" type="button" value="다음" id="next7">
            </div>
         </section>
      </div>
      
      <div id="survey8" style="display: none">
         <section>
            <h2 class="font-weight-bold">아래항목 중 공부해본 적 있는 과목에 모두 체크해주세요.</h2>

            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-1" name="SURBEY_BASIC_NON_MAJOR"value="Git,GitHub" type="checkbox">
               <label class="custom-control-label" for="8-1">Git,GitHub</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-2" name="SURBEY_BASIC_NON_MAJOR"value="hosting" type="checkbox">
               <label class="custom-control-label" for="8-2">hosting</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-3" name="SURBEY_BASIC_NON_MAJOR"value="DNS" type="checkbox">
               <label class="custom-control-label" for="8-3">DNS</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-4" name="SURBEY_BASIC_NON_MAJOR"value="Browser" type="checkbox">
               <label class="custom-control-label" for="8-4">Browser</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-5" name="SURBEY_BASIC_NON_MAJOR"value="tcp/ip" type="checkbox">
               <label class="custom-control-label" for="8-5">tcp/ip</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-6" name="SURBEY_BASIC_NON_MAJOR"value="http" type="checkbox">
               <label class="custom-control-label" for="8-6">http</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-7" name="SURBEY_BASIC_NON_MAJOR"value="osi7 layer" type="checkbox">
               <label class="custom-control-label" for="8-7">osi7 layer</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-8" name="SURBEY_BASIC_NON_MAJOR"value="api" type="checkbox">
               <label class="custom-control-label" for="8-8">api</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-9" name="SURBEY_BASIC_NON_MAJOR"value="자료구조" type="checkbox">
               <label class="custom-control-label" for="8-9">자료구조</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-10" name="SURBEY_BASIC_NON_MAJOR"value="알고리즘" type="checkbox">
               <label class="custom-control-label" for="8-10">알고리즘</label>
            </div>
             <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="8-11" name="SURBEY_BASIC_NON_MAJOR"value="해당 사항이 없습니다" type="checkbox">
               <label class="custom-control-label" for="8-11">해당 사항이 없습니다</label>
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back7">
               <input style="float: right;" class="btn btn-primary btn-lg" type="button" value="다음" id="next8">
            </div>
         </section>
      </div>
      
      <div id="survey9" style="display: none">
         <section>

            <h2 class="font-weight-bold">아래항목 중 공부해본 적 있는 과목에 모두 체크해주세요.</h2>
            
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="9-1" name="SURBEY_SERVER_NON_MAJOR"value="Python" type="checkbox">
               <label class="custom-control-label" for="9-1">Python</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="9-2" name="SURBEY_SERVER_NON_MAJOR"value="java" type="checkbox">
               <label class="custom-control-label" for="9-2">java</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="9-3" name="SURBEY_SERVER_NON_MAJOR" value="C#"type="checkbox">
               <label class="custom-control-label" for="9-3">C#</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="9-5" name="SURBEY_SERVER_NON_MAJOR"value="Scala" type="checkbox">
               <label class="custom-control-label" for="9-5">Scala</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="9-6" name="SURBEY_SERVER_NON_MAJOR"value="HTML" type="checkbox">
               <label class="custom-control-label" for="9-6">HTML</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="9-7" name="SURBEY_SERVER_NON_MAJOR"value="CSS" type="checkbox">
               <label class="custom-control-label" for="9-7">CSS</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="9-8" name="SURBEY_SERVER_NON_MAJOR"value="해당 사항이 없습니다" type="checkbox">
               <label class="custom-control-label" for="9-8">해당 사항이 없습니다</label>
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back8">
               <input style="float: right;" class="btn btn-primary btn-lg" type="button" value="다음" id="next9">
            </div>
         </section>
      </div>
      
      <div id="survey10" style="display: none">
         <section>
            <h2 class="font-weight-bold">아래항목 중 공부해본 적 있는 과목에 모두 체크해주세요.</h2>
            
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="10-1" name="SURBEY_DATABASE_NON_MAJOR"value="Oracle" type="checkbox">
               <label class="custom-control-label" for="10-1">Oracle</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="10-2" name="SURBEY_DATABASE_NON_MAJOR"value="mongoDB" type="checkbox">
               <label class="custom-control-label" for="10-2">mongoDB</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="10-3" name="SURBEY_DATABASE_NON_MAJOR"value="MS MQL" type="checkbox">
               <label class="custom-control-label" for="10-3">MS MQL</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="10-4" name="SURBEY_DATABASE_NON_MAJOR"value="MariaDB" type="checkbox">
               <label class="custom-control-label" for="10-4">MariaDB</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="10-5" name="SURBEY_DATABASE_NON_MAJOR"value="DynamoDB" type="checkbox">
               <label class="custom-control-label" for="10-5">DynamoDB</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="10-6" name="SURBEY_DATABASE_NON_MAJOR"value="해당 사항이 없습니다" type="checkbox">
               <label class="custom-control-label" for="10-6">해당 사항이 없습니다</label>
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back9">
               <input style="float: right;" class="btn btn-primary btn-lg" type="button" value="다음" id="next10">
            </div>
         </section>
      </div>
      
      <div id="survey11" style="display: none">
         <section>
            <h2 class="font-weight-bold">아래항목 중 공부해본 적 있는 과목에 모두 체크해주세요.</h2>
            
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-1" name="SURBEY_FRAMEWORK_NON_MAJOR"value="Mybatis" type="checkbox">
               <label class="custom-control-label" for="11-1">Mybatis</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-2" name="SURBEY_FRAMEWORK_NON_MAJOR"value="Hibernate" type="checkbox">
               <label class="custom-control-label" for="11-2">Hibernate</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-3" name="SURBEY_FRAMEWORK_NON_MAJOR"value="JPA" type="checkbox">
               <label class="custom-control-label" for="11-3">JPA</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-4" name="SURBEY_FRAMEWORK_NON_MAJOR"value="Node.js" type="checkbox">
               <label class="custom-control-label" for="11-4">Node.js</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-5" name="SURBEY_FRAMEWORK_NON_MAJOR"value="Flask" type="checkbox">
               <label class="custom-control-label" for="11-5">Flask</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-6" name="SURBEY_FRAMEWORK_NON_MAJOR"value="Spring" type="checkbox">
               <label class="custom-control-label" for="11-6">Spring</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-7" name="SURBEY_FRAMEWORK_NON_MAJOR"value="Django" type="checkbox">
               <label class="custom-control-label" for="11-7">Django</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-8" name="SURBEY_FRAMEWORK_NON_MAJOR"value="React.js" type="checkbox">
               <label class="custom-control-label" for="11-8">React.js</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-9" name="SURBEY_FRAMEWORK_NON_MAJOR"value="Vue.js" type="checkbox">
               <label class="custom-control-label" for="11-9">Vue.js</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-10" name="SURBEY_FRAMEWORK_NON_MAJOR"value="Bootstrap" type="checkbox">
               <label class="custom-control-label" for="11-10">Bootstrap</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-11" name="SURBEY_FRAMEWORK_NON_MAJOR"value="jQuery" type="checkbox">
               <label class="custom-control-label" for="11-11">jQuery</label>
            </div>
            <div class="custom-control custom-checkbox">
               <input class="custom-control-input" id="11-12" name="SURBEY_FRAMEWORK_NON_MAJOR"value="해당 사항이 없습니다" type="checkbox">
               <label class="custom-control-label" for="11-12">해당 사항이 없습니다</label>
            </div>
            <br>
            <div>
               <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back10">
               <input style="float: right;" class="btn btn-primary btn-lg" type="button" value="다음" id="next11">
            </div>
         </section>
      </div>
      
      <div id="survey12" style="display: none">
         <section>
            <h2 class="font-weight-bold">종합결과</h2>
            <!-- <div>
               <span id="chk01"></span>
            </div>
            <div>
               <div id="chk02"></div>
            </div>
            <div>
               <span id="chk03"></span>
            </div> -->
            <h2 class="font-weight-bold" style="text-align: center;">답변을 바탕으로</h2>
            <br>
            <h2 class="font-weight-bold" style="text-align: center;">나의 커리어 설계와 스킬에 맞는</h2>
            <h2 class="font-weight-bold" style="text-align: center;">10년의 개발 스터디 플랜을 짜드립니다.</h2>
            <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back11">
            <input style="float: right;" class="btn btn-primary btn-lg" type="submit" value="회원가입">
         </section>
      </div>
      
      <div id="survey13" style="display: none">
         <section>
            <h1 class="font-weight-bold">종합결과</h1>
            <!-- <div>
               <span id="chk01"></span>
            </div>
            <div>
               <div id="chk02"></div>
            </div>
            <div>
               <span id="chk03"></span>
            </div> -->
            <h2 class="font-weight-bold" style="text-align: center;">답변을 바탕으로</h2>
            <br>
            <h2 class="font-weight-bold" style="text-align: center;">나의 커리어 설계와 스킬에 맞는</h2>
            <h2 class="font-weight-bold" style="text-align: center;">10년의 개발 스터디 플랜을 짜드립니다.</h2>
            <input style="float: left;" class="btn btn-primary btn-lg" type="button" value="이전" id="back12">
            <input style="float: right;" class="btn btn-primary btn-lg" type="submit" value="회원가입">
         </section>
      </div>
   </form>
   </div>
   </article>
   </div>
   </section>
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>