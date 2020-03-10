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
.school-item-inline{
   display:flex;
   flex-wrap: wrap;
}
label{
   font-size: 14px;
    line-height: 1.5;
    display: inline-block;
    margin-bottom: 2px;
    margin-left: 4px;
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
                  <h1>교육 정보를 입력하세요.</h1>
                  <fieldset>
                     <form action="/DEVCA/portfolio/actionpage.do" method="post">
                     <input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
                     <div class="school-main">
                        <c:forEach items="${schoolList }" var="schoolList">
                        <input type="hidden" name="school_seq" value="${schoolList.SCHOOL_SEQ }"/>
                        <div class="school-item">
                           <label>학교/기관</label>
                           <div class="input-group mb-3">
                              <input type="text" name="schoolname" placeholder="OO학교" value="${schoolList.SCHOOL_NAME }"/>
                              <span class="input-group-text"><i class="fas fa-phone"></i></span>
                           </div>
                           
                           <div class="row">
                              <div class="col-md-4">
                              <label>전공</label>
                                 <div class="input-group mb-3">
                                    <input type="text" name="major" placeholder="컴퓨터 공학" value="${schoolList.SCHOOL_MAJOR }"/>
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                 </div>
                            </div>
                            <div class="col-md-4">   
                            <label>학위</label>
                                 <div class="input-group mb-3">
                                    <input type="text" name="degree" placeholder="학사" value="${schoolList.SCHOOL_DEGREE }"/>
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                 </div>
                              </div>
                           </div>
                           <div class="row">
                              <div class="col-md-4">
                              <label>입학</label>
                                 <div class="input-group mb-3">
                                    <input type="date" name="start_date" placeholder="입학 년월" value="${schoolList.SCHOOL_OF_START }"/>
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                 </div>
                            </div>
                            <div class="col-md-4">   
                            <label>졸업(예정)</label>
                                 <div class="input-group mb-3">
                                    <input type="date" name="end_date" placeholder="졸업 년월" value="${schoolList.SCHOOL_OF_END }"/>
                                 <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                 </div>
                              </div>
                           </div>
                           <div class="row">
                              <div class="col-md-4">
                                 <label>내 학점</label>
                                 <div class="input-group mb-3">
                                    <input type="text" name="mycredit" placeholder="3.5"  value="${schoolList.SCHOOL_CREDIT }"/>
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                 </div>
                            </div>
                              
                              <div>
                              <label>최대 학점</label>
                              <div class="input-group mb-3">
                                 <input type="text" name="maxcredit" placeholder="4.5" value="${schoolList.SCHOOL_MAXCREDIT }"/>
                                 <span class="input-group-text"><i class="fas fa-phone"></i></span>
                              </div>
                              </div>   
                           </div>
                           
                           <label>기타 설명</label>
                           <div class="input-group mb-3">
                              <textarea  class="form-control" rows="2" cols="20" name="othertext" placeholder="위에서 적지 못한 학력에 관한 사항을 적어주세요.">${schoolList.SCHOOL_EXPLANATION }</textarea>
                           </div>
                        </div>
                       </c:forEach>
                     </div>
                     <div class="controll-wrap">
                        <a href="#" class="btn btn-primary btn-lg" onclick="location.href='/DEVCA/portfolio/sidelanguagepage.do'">이전</a>
                        <input class="btn btn-primary btn-lg" type="submit" class="next-button" value="다음" style="float: right;"/>
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