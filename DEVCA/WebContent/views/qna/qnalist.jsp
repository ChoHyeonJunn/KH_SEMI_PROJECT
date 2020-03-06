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


<!-- bootstrap -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<!--Fontawesome CDN-->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">

<!-- end bootstrap --!>


<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
	

<script type="text/javascript">

</script>



<!-- END :: JAVASCRIPT -->

<style type="text/css">
</style>
</head>
<body>



	<section>

		<h1>QNA 게시판</h1>
		<div class="well">
			<table class="table">
				<tr>
					<th>#</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th style="width: 36px;"></th>
				</tr>
				<c:choose>
					<c:when test="${empty list }">
						<tr>
							<td colspan="4">-----작성된 글이 존재하지 않습니다------</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list }" var="QNA_BOARD">
							<tr>
								<td>${QNA_BOARD.QNA_POST_NO }</td>
								<td><c:forEach begin="1" end="${QNA_BOARD.QNA_TITLE_TAB }">
								&nbsp;&nbsp;&nbsp;
							</c:forEach> <a
									href="/DEVCA/qnapage/qnadetail.do?QNA_BOARD_NO=${QNA_BOARD.QNA_BOARD_NO }">${QNA_BOARD.QNA_TITLE }</a>
								</td>
								<td>${QNA_BOARD.QNA_WRITER }</td>
								<td>${QNA_BOARD.QNA_DATE }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<tr>
					<td colspan="4"><input type="button" class="btn" value="글쓰기"
						onclick="location.href='/DEVCA/qnapage/qnawriteform.do'" /></td>
				</tr>
			</table>
		</div>

	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>