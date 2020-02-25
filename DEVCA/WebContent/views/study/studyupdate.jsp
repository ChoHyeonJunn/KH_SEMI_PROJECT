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

<!-- END :: JAVASCRIPT -->
</head>
<body>

	<section>
		<form action="/DEVCA/study/studyupdate.do" action="POST">
			<input type="hidden" value="${study.MEMBER_CODE }" name="MEMBER_CODE">
			<input type="hidden" value="${study.STUDY_CODE }" name="STUDY_CODE">
			
			<table border="1">
				<tr>
					<th>이름</th>
					<td>${study.MEMBER_CODE }</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" value="${study.STUDY_TITLE }" name="STUDY_TITLE" required="required">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="60" required="required" name="STUDY_CONTENT">
							${study.STUDY_CONTENT }
						</textarea>
						
						<!-- 지도 표시 -->
	  					<div id="map" style="width:500px;height:400px;"></div>
					</td>
				</tr>
				<tr>
					<td colspan = "2">
						<c:if test="${sessionLoginMember.MEMBER_CODE eq study.MEMBER_CODE || sessionLoginKakao.MEMBER_CODE eq study.MEMBER_CODE || sessionLoginNaver.MEMBER_CODE eq study.MEMBER_CODE}">
							<input type="submit" value="수정"> 
							<input type="button" value="취소" onclick="location.href='/DEVCA/study/studydetailpage.do?STUDY_CODE=${study.STUDY_CODE}'">
						</c:if>
						<input type="button" value="목록" onclick="location.href='/DEVCA/study/studylistpage.do'">
					</td>
				</tr>
			</table>
		</form>
	</section>
	
	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>