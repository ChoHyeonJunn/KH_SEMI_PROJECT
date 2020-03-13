<%@page import="com.devca.model.dto.profile.PROJECT"%>
<%@page import="com.devca.model.dto.profile.CAREER"%>
<%@page import="java.util.List"%>
<%@page import="com.devca.model.dto.member.MEMBER"%>
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
<style type="text/css">
dd{
   font-size: 10pt;
}

li{
   font-size: 8pt;
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
</script>
<!-- END :: JAVASCRIPT -->

<!-- START :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
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
         <article class="col-md-10">
            <div class="card p-4 my-3 bg-white">
               
               <div class="preview-main">
                  <h1> <c:out value="${sessionLoginMember.MEMBER_NAME }"/>님의 프로필 미리보기</h1>
                  <br/>
                     <dl>
                        <dd>Tel - ${sessionLoginMember.MEMBER_PHONE }</dd>
                        <dd>Mail - ${sessionLoginMember.MEMBER_EMAIL }</dd>
                     </dl>
                     <br/>
                  <h4>희망 연봉/ 희망 직군</h4><hr/>
                  <c:forEach items="${workList }" var="workList">
                     <dl>
                        <dd>${workList.INCOME }/ ${workList.LINE_OF_WORK } </dd>
                     </dl>
                  </c:forEach>
                  <br/><h4>업무 경험
                     <span>
                           총 : ${careerdate_year }년  ${careerdate_month } 개월
                     </span>
                  </h4> <hr/>
                  <c:forEach items="${careerList }" var="careerList" >
                     <h5>회사명 : ${careerList.COMPANY_NAME }</h5>
                     <dl>
                        <dd>직무 - ${careerList.DUTY } </dd>
                        <dd>링크 - ${careerList.LINK }</dd>
                        <dd>기술 - ${careerList.STACK }</dd>
                        <div>
                           <ul>
                              <li>${careerList.PERFORMANCE }</li>
                           </ul>
                           <p>${careerList.DETAIL_CONTEXT }</p>
                        </div>
                        <dd>기타 설명 - ${careerList.EXPLANATION }</dd>
                     </dl>
                  </c:forEach>
                  <br/><h4>개인 프로젝트</h4><hr/>
                  <c:forEach items="${projectList }" var="projectList">
                     <h5>${projectList.PROJECT_NAME }</h5>
                     <dl>
                        <dd>${projectList.PROJECT_USE_STACK } </dd>
                        <div>
                           <ul>
                              <li>${projectList.PROJECT_ONELINE_EX }</li>
                              <li>${projectList.PROJECT_TEAM }:${projectList.PROJECT_MEMBER }</li>
                              <li>${projectList.PROJECT_DETAIL }</li>
                              <li>${projectList.PROJECT_STORAGE_LINK }</li>
                              <li>${projectList.PROJECT_WEBSITE }</li>
                              <li>${projectList.PROJECT_ANDROID }</li>
                              <li>${projectList.PROJECT_IOS }</li>
                           </ul>
                        </div>
                     </dl>
                  </c:forEach>
                  <br/><h4>외국어</h4><hr/>
                  <c:forEach items="${languageList }" var="languageList">
                     <dl>
                        <dd>${languageList.LANGUAGE }</dd>
                     </dl>
                  </c:forEach>
                  <br/><h4>학력</h4><hr/>
                  <c:forEach items="${schoolList }" var="schoolList">
                     <dl>
                        <dd>${schoolList.SCHOOL_NAME }</dd>
                        <div>
                           <ul>
                              <li>${schoolList.SCHOOL_MAJOR }/ ${schoolList.SCHOOL_DEGREE }</li>
                              <li>${schoolList.SCHOOL_CREDIT }/${schoolList.SCHOOL_MAXCREDIT }</li>
                              <li>${schoolList.SCHOOL_EXPLANATION }</li>
                           </ul>
                         </div>
                      </dl>
                  </c:forEach>
                 <br/><h4>자격증</h4><hr/>
                 <c:forEach items="${certificateList }" var="certificateList">
                    <DL>
                       <DD>${certificateList.CERTIFICATE_NAME }</DD>
                       <div>
                          <ul>
                              <li>${certificateList.CERTIFICATE_LINK }</li>
                              <li>${certificateList.CERTIFICATE_EX_TEXT }</li>
                           </ul>
                        </div>
                    </DL>
                    
                  </c:forEach>
               </div>
              <div class="btn btn-primary btn-sm">
                  <a href="#" onclick="location.href='/DEVCA/portfolio/sideportfoliopage.do'">수정</a>
                </div>
           </div>
         </article>
      </div>
   </section>
   
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>