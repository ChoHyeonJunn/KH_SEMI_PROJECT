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

<!-- summernote including -->
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.js"></script>


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
		<div class="card p-4 my-3 bg-white">
			<h1 class="card-title">답글 쓰기</h1>
			<br />
			<form action="/DEVCA/qnapage/answerres.do" method="post">
				<input type="hidden" name="MEMBER_CODE"
					value="${sessionMember_profile.MEMBER_CODE }"> <input
					type="hidden" name="parentboardno"
					value="${QNA_BOARD.QNA_BOARD_NO }" />
				<div>
					<div>
						<input class="form-control form-control-lg" type="text"
							name="QNA_TITLE" value="RE:${QNA_BOARD.QNA_TITLE }" />
					</div>
					<br />
					<div>
						<textarea rows="10" cols="60" name="QNA_CONTENT" id="summernote">${QNA_BOARD.QNA_CONTENT }==============================
					</textarea>
					</div>
					<br />
					<div>
						<input class="btn" type="submit" value="답변 작성" /> &nbsp; <input
							class="btn" type="button" value="취소"
							onclick="location.href='/DEVCA/qnapage/qnadetail.do?QNA_BOARD_NO=${QNA_BOARD.QNA_BOARD_NO }'" />
					</div>
				</div>
			</form>
		</div>
	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>