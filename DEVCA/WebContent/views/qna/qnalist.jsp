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
	$("td:eq('')").css("visibility", "hidden");
</script>

<!-- END :: JAVASCRIPT -->

<style type="text/css">
thead {
	background-color: #862d86;
	color: white;
}
</style>
</head>
<body>

	<h1 class="card-title">&nbsp; &nbsp;Q&A</h1>
	<c:if
		test="${not empty sessionLoginMember.MEMBER_CODE || not empty sessionLoginKakao.MEMBER_CODE || not empty sessionLoginNaver.MEMBER_CODE}">
		&nbsp; &nbsp; &nbsp; &nbsp;<input type="button" class="btn btn-lg" value="글쓰기"
			onclick="location.href='/DEVCA/qnapage/qnawriteform.do'" />
	</c:if>

	<section class="card p-4 my-3 bg-white">

		<div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list }">
							<tr>
								<td colspan="4">-----작성된 글이 존재하지 않습니다------</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list }" var="QNA_BOARD">
								<tr>
									<th scope="row">${QNA_BOARD.QNA_POST_NO }</th>
									<td><c:forEach begin="1" end="${QNA_BOARD.QNA_TITLE_TAB }">
								&nbsp;&nbsp;&nbsp;
								</c:forEach> <a class="card-link" style="cursor: pointer;"
										href="/DEVCA/qnapage/qnadetail.do?QNA_BOARD_NO=${QNA_BOARD.QNA_BOARD_NO }"><strong>${QNA_BOARD.QNA_TITLE }</strong></a>
									</td>
									<td><strong>${QNA_BOARD.MEMBER_NAME }/${QNA_BOARD.MEMBER_EMAIL }</strong></td>
									<td>${QNA_BOARD.QNA_DATE }</td>
								</tr>

							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
				<tr>
				</tr>
			</table>
		</div>

	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>