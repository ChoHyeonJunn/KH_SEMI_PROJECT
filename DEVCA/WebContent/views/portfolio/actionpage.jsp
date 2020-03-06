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

</script>
<style type="text/css">
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
			   	   	<h1>활동한 경험을 적어주세요</h1>
			   		<fieldset>
			   			<form action="/DEVCA/portfolio/certificatepage.do" method="post">
			   			<input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
			   				<div class="action-main">
			   					<c:forEach items="${actionList }" var="actionList">
			   					<input type="hidden" name="action_seq" value="${actionList.ACTION_SEQ }"/>
			   					<div class="action-item">
			   						
									<label>활동명</label>
									<div class="input-group mb-3">
			   							<input type="text" name="action_name" value="${actionList.ACTION_NAME }" placeholder="입력"/>
			   							<span class="input-group-text"><i class="fas fa-phone"></i></span>
			   						</div>
			   						<div class="row">
				   						<div class="col-md-4">
				  							<label>시작일</label>
											<div class="input-group mb-3">
					   							<input type="text" name="action_start_date" value="${actionList.ACTION_START_DATE }" placeholder="시작일(2000-11-11)"/>
					   							<span class="input-group-text"><i class="fas fa-phone"></i></span>
					   						</div>
				   						</div>
				   						<div class="col-md-4">
				   							<label>종료일</label>
				   							<div class="input-group mb-3">
					   							<input type="text" name="action_end_date" value="${actionList.ACTION_END_DATE }" placeholder="종료일(2000-11-11)"/>
					   							<span class="input-group-text"><i class="fas fa-phone"></i></span>
					   						</div>
				   						</div>
			   						</div>
			   						
			   						<label>활동 링크</label>
			   						<div class="input-group mb-3">
			   							<input type="text" name="action_link" value="${actionList.ACTION_LINK }" placeholder="http://"/>
			   							<span class="input-group-text"><i class="fas fa-phone"></i></span>
			   						</div>
			   						<div class="input-group mb-3">
			   							<label>설명</label>
			   							<textarea class="form-control" rows="2" cols="40" name="action_ex_text" placeholder="위에서 적지 못한 활동에 관한 사항을 적어주세요.">${actionList.ACTION_EX_TEXT }</textarea>
			   						</div>	
			   					</div>
			   					</c:forEach>
			   				</div>
			   				<div class="action-wrap">
			   					<a href="#" class="btn btn-primary btn-lg" onclick="location.href='/DEVCA/portfolio/sideschoolpage.do'">이전</a>
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