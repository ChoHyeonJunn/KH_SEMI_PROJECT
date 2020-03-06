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
            <h1>소지하신 자격증/ 취득내용을 적어주세요. </h1>
      	<fieldset>
   			<form action="/DEVCA/portfolio/workpage.do" method="post">
   			<input type="hidden" name="member_code" value="${sessionLoginMember.MEMBER_CODE }"/>
   				<div class="action-main">
   					<c:forEach items="${certificateList }" var="certificateList">
   					<input type="hidden" name="certificate_seq" value="${certificateList.CERTIFICATE_SEQ }"/>
   					<div class="action-item">
   						<div class="action-item-name">
   							<label>수상/ 취득내역</label>
   							<input type="text" name="certificate_name" value="${certificateList.CERTIFICATE_NAME }" placeholder="입력"/>
   						</div>
   						<div class="action-item-label">
   							<label>취득 년월</label>
   							<input type="text" name="certificate_start_date" value="${certificateList.CERTIFICATE_DATE }" placeholder="취득일(2000-11-11)"/>
   						</div>
   						<div class="action-item-end">
   							<label>링크</label>
   							<input type="text" name="certificate_link" value="${certificateList.CERTIFICATE_LINK }" placeholder="http://"/>
   						</div>
   						<div class="action-item-extext">
   							<label>설명</label>
   							<textarea rows="2" cols="40" name="certificate_ex_text" placeholder="위에서 적지 못한 자격증에 관한 사항을 적어주세요.">${certificateList.CERTIFICATE_EX_TEXT }</textarea>
   						</div>	
   					</div>
   					</c:forEach>
   				</div>
   				<div class="action-wrap">
   					<a href="#" onclick="location.href='/DEVCA/portfolio/sideactionpage.do?member_code=${sessionLoginMember.MEMBER_CODE }'">이전</a>
   					<input type="submit" value="다음"/>
   				</div>
   			</form>
   		</fieldset>
      </article>
   </section>
   
   <!-- FOOTER FORM -->
   <%@ include file="/views/form/footer.jsp"%>
</body>
</html>