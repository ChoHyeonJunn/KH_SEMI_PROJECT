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

<script
	src="https://cdn.ckeditor.com/ckeditor5/16.0.0/classic/ckeditor.js"></script>

</head>
<body>

	<section>
		<h1>글쓰기 <input type="button" value="취소" onclick="location.href='/DEVCA/qnapage/qnalist.do'" /></h1>
		<form action="/DEVCA/qnapage/qnawriteres.do" method="post">
			<div>
				<div>
					제목 : <input type="text" name="QNA_TITLE" />
				</div>

				<div>
						<textarea rows="10" cols="60" name="QNA_CONTENT" id="content"></textarea>
						<script
							src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
				</div>
				<div>
					작성자 : <input type="text" name="QNA_WRITER" />
				</div>
				<div>
					<input type="submit" value="작성" />
				</div>
			</div>
		</form>
	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>