<%@page import="com.devca.model.dto.profile.CAREER"%>
<%@page import="com.devca.model.dto.profile.CAREER_DETAIL"%>
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
	<section class="container-fluid">
		<div class="row">
			<%@ include file="/views/form/portfoliosidebar.jsp"%>
				<!-- START :: profile content -->
			<article class="col-md-10">
				<div class="card p-4 my-3 bg-white">
					<div class="profile-main">
					<h1>실무경력이 있나요?</h1>	
						<fieldset>
							<form action="/DEVCA/portfolio/projectpage.do" method="post">
							<input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
								<c:forEach items="${careerList }" var ="careerList">
									<div class="profile-item">
									
									
										<label for="companyname">기업이름</label>
										<div class="input-group mb-3">
											<input type="text" id="companyname" name="COMPANYNAME" placeholder="기업 이름 입력" value="${careerList.COMPANY_NAME }"/>
											<span class="input-group-text"><i class="fas fa-phone"></i></span>
										</div>
										
										
										<label for="duty">직무</label> 
										<div class="input-group mb-3">
											<input type="text" id="duty" name="DUTY" placeholder="프론트엔드 개발자" value="${careerList.DUTY }" />
											<span class="input-group-text"><i class="fas fa-phone"></i></span>
										</div>
										
										
										<label for="day_of_entry">입사일</label>
										<div class="input-group mb-3">
											<input type="text" id="day_of_entry" name="DAY_OF_ENTRY" value="${careerList.DAY_OF_ENTRY }"/>	
											<span class="input-group-text"><i class="fas fa-phone"></i></span>	
										</div>
										
										
										<label for="date_of_departure">퇴사일</label>
										<div class="input-group mb-3">
											<input type="text" id="date_of_departure" name="DATE_OF_DEPARTURE" value="${careerList.DATE_OF_DEPARTURE }"/>
											<span class="input-group-text"><i class="fas fa-phone"></i></span>
										</div>
										
										
										<label for="stack">사용 스택</label>
										<div class="input-group mb-3">
											<input type="text" id="stack" name="STACK" placeholder="스택 입력" value="${careerList.STACK }"/>	
											<span class="input-group-text"><i class="fas fa-phone"></i></span>
										</div>
										
										
										<c:forEach items="${career_detailList }" var="career_detailList">
											<label>상세 업무 및 성과</label>
											<div class="profile-items">
												<div class="career-detail-item">
													<input type="hidden" name="CAREER_SEQ" value="${career_detailList.CAREER_DETAIL_SEQ }"/>
													<div class="input-group mb-3">
														<input type="text" name="PERFORMANCE" placeholder="상세 업무 및 성과" value="${career_detailList.PERFORMANCE }"/>
														<span class="input-group-text"><i class="fas fa-phone"></i></span>
													</div>
													<div class="row">
														<div class="col-md-4">
															<div class="input-group mb-3">
																<input type="text" name="START_DATE" placeholder="시작일(2020-01-01)" value="${career_detailList.START_DATE }"/>
																<span class="input-group-text"><i class="fas fa-phone"></i></span>
															</div>
														</div>
														<div class="col-md-4">
															<div class="input-group mb-3">
																<input type="text" name="END_DATE" placeholder="종료일(2020-01-01)" value="${career_detailList.END_DATE }"/>
																<span class="input-group-text"><i class="fas fa-phone"></i></span>
															</div>
														</div>
													</div>
													<div class="input-group mb-3">
														<textarea class="form-control" rows="6" cols="50" name="DETAIL_CONTEXT">${career_detailList.DETAIL_CONTEXT }</textarea>
													</div>
												</div>
											</div>
										</c:forEach>
										<label for="LINK">기타 링크</label>
										<div class="input-group mb-3">
											<input type="text" id="LINK" name="LINK" placeholder="https://website.com" value="${careerList.LINK }"/>
											<span class="input-group-text"><i class="fas fa-phone"></i></span>
										</div>
										<label>기타 설명</label>
										<div class="input-group mb-3">
											<textarea class="form-control" rows="2" cols="50" name="EXPLANATION" placeholder="입력">${careerList.EXPLANATION }</textarea>
											
										</div>	
									</div>
								</c:forEach>	
								<div class="input-group mb-3">
									<input class="btn btn-block btn-lg" type="submit" value="다음"/>	
								</div>
							</form>
						</fieldset>
					</div>
				</div>
			</article>
				<!-- END :: profile content -->	
		</div>
	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>
