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

<!-- include libraries(jQuery, bootstrap) -->
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- include summernote css/js-->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#summernote').summernote({
			height : 300, // set editor height
			minHeight : null, // set minimum height of editor
			maxHeight : null, // set maximum height of editor
			focus : true
		// set focus to editable area after initializing summernote
		})
	});
</script>

<!-- END :: JAVASCRIPT -->

</head>
<body>

	<section>
		<h1>
			답변하기 <input type="button" value="취소"
				onclick="location.href='/DEVCA/qnapage/qnadetail.do?QNA_BOARD_NO=${QNA_BOARD.QNA_BOARD_NO }'" />
		</h1>
		<form action="/DEVCA/qnapage/answerres.do" method="post">
			<input type="hidden" name="MEMBER_CODE"
				value="${sessionMember_profile.MEMBER_CODE }"> <input
				type="hidden" name="parentboardno"
				value="${QNA_BOARD.QNA_BOARD_NO }" />
			<div>
				<div>
					제목 : <input type="text" name="QNA_TITLE"
						value="RE:${QNA_BOARD.QNA_TITLE }" />
				</div>
				<div>
					<textarea rows="10" cols="60" name="QNA_CONTENT" id="summernote">Q. ${QNA_BOARD.QNA_CONTENT }
					A. : 
					</textarea>
				</div>
				<div>
					<input type="submit" value="답변 작성" />
				</div>
			</div>
		</form>
	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>