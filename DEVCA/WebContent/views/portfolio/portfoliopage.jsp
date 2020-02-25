<%@page import="com.devca.model.dto.CAREER"%>
<%@page import="com.devca.model.dto.CAREER_DETAIL"%>
<%@page import="java.util.List"%>
<%@page import="com.devca.model.dto.MEMBER"%>
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
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	function inNumber(){
	  if(event.keyCode<48 || event.keyCode>57){
	     event.returnValue=false;
	  }
	}


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
	<!-- START :: profile content -->
	<article>
		<div class="profile-main">
		<h1>실무경력이 있나요?</h1>	
			<fieldset>
				<form action="/DEVCA/portfolio/projectpage.do" method="post">
				<input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
					<c:forEach items="${careerList }" var ="careerList">
						<div class="profile-item">
							<div class="profile-items">
								<label for="companyname">기업이름</label>
								<input type="text" id="companyname" name="COMPANYNAME" placeholder="기업 이름 입력" value="${careerList.COMPANY_NAME }"/>
							</div>
							<div class="profile-items">
								<label for="duty">직무</label> 
								<input type="text" id="duty" name="DUTY" placeholder="프론트엔드 개발자" value="${careerList.DUTY }" />
							</div>
							<div class="profile-items">
								<label for="day_of_entry">입사일</label>
								<input type="text" id="day_of_entry" name="DAY_OF_ENTRY" value="${careerList.DAY_OF_ENTRY }"/>	
							</div>
							<div class="profile-items">
								<label for="date_of_departure">퇴사일</label>
								<input type="text" id="date_of_departure" name="DATE_OF_DEPARTURE" value="${careerList.DATE_OF_DEPARTURE }"/>
							</div>
							<div class="profile-items">
								<label for="stack">사용 스택</label>
								<input type="text" id="stack" name="STACK" placeholder="스택 입력" value="${careerList.STACK }"/>	
							</div>
							<c:forEach items="${career_detailList }" var="career_detailList">
								<label>상세 업무 및 성과</label>
								<div class="profile-items">
									<div class="career-detail-item">
										<input type="hidden" name="CAREER_SEQ" value="${career_detailList.CAREER_DETAIL_SEQ }"/>
										<input type="text" name="PERFORMANCE" placeholder="상세 업무 및 성과" value="${career_detailList.PERFORMANCE }"> <br/>
										<input type="text" name="START_DATE" placeholder="시작일(2020-01-01)" value="${career_detailList.START_DATE }"/>
										<input type="text" name="END_DATE" placeholder="종료일(2020-01-01)" value="${career_detailList.END_DATE }"/><br/>
										<textarea rows="6" cols="50" name="DETAIL_CONTEXT">${career_detailList.DETAIL_CONTEXT }</textarea>
									</div>
								</div>
							</c:forEach>
							<div class="profile-items">
								<label for="LINK">기타 링크</label>
								<input type="text" id="LINK" name="LINK" placeholder="https://website.com" value="${careerList.LINK }"/>	
							</div>
							<div class="profile-items">
								<label>기타 설명</label>
								<textarea rows="2" cols="50" name="EXPLANATION" placeholder="입력">${careerList.EXPLANATION }</textarea>
							</div>	
						</div>
					</c:forEach>	
					<div>
						<input type="submit" value="다음" style="float: right;"/>	
					</div>
				</form>
			</fieldset>
		</div>
		</article>
		<!-- END :: profile content -->
	
	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>
