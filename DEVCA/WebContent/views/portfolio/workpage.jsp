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

   function attachAddr(){
      const str = '<div class="work-item"><hr/><br/>'+
         '<input type="hidden" name="work_count" value="0"/>'+
         '<span class="deletepage btn btn-primary btn-sm" style="float: right;">삭제</span>'+
            '<label>직종</label>'+
            '<div class="input-group mb-3">'+
               '<input type="text" name="work_name" placeholder="입력"/>'+
               '<span class="input-group-text"><i class="far fa-edit"></i></span>'+
            '</div>'+
            '<label>연봉</label>'+
            '<div class="input-group mb-3">'+
               '<input type="text" name="income" placeholder="0만원"/>'+
               '<span class="input-group-text"><i class="fas fa-hand-holding-usd"></i></span>'+
            '</div>'+
         '</div>';
         
         $(".work-main").append(str);
         
          return false;
   }
   
   $(document).on('click','.deletepage',(function(){
      if($('.work-item').length === 1){
         }else{
            $(this).parent().remove();
         }
      })
   );
   
</script>
<style type="text/css">
.insert{
   display: inline-block;
}
.insert-center{
   text-align: center;
}
</style>
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
               <h1>희망하는 직군과 최소 연봉을 적어주세요.</h1>
                  <fieldset>
                     <form action="/DEVCA/portfolio/previewpage.do" method="post">
                     <input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
                        <div class="work-main">
                           <c:forEach items="${workList }" var="workList">
                           <div class="work-item"><hr/><br/>
                           <input type="hidden" name="work_count" value="0"/>
                              <span class="deletepage btn btn-primary btn-sm" style="float: right;">삭제</span>
                              <label>직종</label>
                              <div class="input-group mb-3">
                                 <input type="text" name="work_name" value="${workList.LINE_OF_WORK }" placeholder="입력"/>
                                 <span class="input-group-text"><i class="far fa-edit"></i></span>
                              </div>
                              <label>연봉</label>
                              <div class="input-group mb-3">
                                 <input type="text" name="income" value="${workList.INCOME }" placeholder="0만원"/>
                                 <span class="input-group-text"><i class="fas fa-hand-holding-usd"></i></span>
                              </div>
                           </div>
                           </c:forEach>
                        </div>
                           <div class="insert-center">
                           <div class="insert">
                              <a href="#" class="btn btn-primary btn-sm" onclick="attachAddr();" >직종/연봉 추가</a>
                           </div>
                        </div>
                        <div>
                           <a href="#" class="btn btn-primary btn-lg" onclick="location.href='/DEVCA/portfolio/sidecertificatepage.do'">이전</a>
                           <input class="btn btn-primary btn-lg" type="submit" value="다음" style="float: right;"/>
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