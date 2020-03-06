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
section {
	height: 800px;
}

article {
	position: absolute;
	right: 5px;
	left: 250px;
	height: 100%;
}

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
	
   <section>
   <%@ include file="/views/form/portfoliosidebar.jsp"%>
   <article>
   	   <h1>교육 정보를 입력하세요.</h1>
	   <fieldset>
	   	<form action="/DEVCA/portfolio/actionpage.do" method="post">
	   	<input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
	      <div class="school-main">
	      	<c:forEach items="${schoolList }" var="schoolList">
	      	<input type="hidden" name="school_seq" value="${schoolList.SCHOOL_SEQ }"/>
		      <div class="school-item">
		      	<div class="school-item-schoolname">
		      		<label>학교/기관</label>
		      		<input type="text" name="schoolname" placeholder="OO학교" value="${schoolList.SCHOOL_NAME }"/>
		      	</div>
		      	<div class="school-item-inline">
			      	<div class="school-item-major">
			      		<label>전공</label>
			      		<input type="text" name="major" placeholder="컴퓨터 공학" value="${schoolList.SCHOOL_MAJOR }"/>
			      	</div>
			      	<div class="school-item-degree">
			      		<label>학위</label>
			      		<input type="text" name="degree" placeholder="학사" value="${schoolList.SCHOOL_DEGREE }"/>
			      	</div>
		      	</div>
		      	<div class="school-item-inline">
		      		<div class="school-item-start">
		      			<label>입학</label>
		      			<input type="text" name="start_date" placeholder="입학 년월" value="${schoolList.SCHOOL_OF_START }"/>
		      		</div>
		      		<div class="school-item-end">
		      			<label>졸업(예정)</label>
		      			<input type="text" name="end_date" placeholder="졸업 년월" value="${schoolList.SCHOOL_OF_END }"/>
		      		</div>
		      	</div>
		      	<div class="school-item-inline">
			      	<div class="school-item-mycredit">
			      		<label>내 학점</label>
			      		<input type="text" name="mycredit" placeholder="3.5"  value="${schoolList.SCHOOL_CREDIT }"/>
			      	</div>
			      	<div class="school-item-maxcredit">
			      		<label>최대 학점</label>
			      		<input type="text" name="maxcredit" placeholder="4.5" value="${schoolList.SCHOOL_MAXCREDIT }"/>
			      	</div>	
		      	</div>
		      	<div class="school-item-othertext">
		      		<label>기타 설명</label>
		      		<textarea rows="2" cols="20" name="othertext" placeholder="위에서 적지 못한 학력에 관한 사항을 적어주세요.">${schoolList.SCHOOL_EXPLANATION }</textarea>
		      	</div>
		      </div>
		     </c:forEach>
	      </div>
	      <div class="controll-wrap">
	      	<a href="#" class="back-button" onclick="location.href='/DEVCA/portfolio/sidelanguagepage.do'">이전</a>
	      	<input type="submit" class="next-button" value="다음"/>
	      </div>
	      </form>
      </fieldset>
      
      </article>
   </section>
   
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>