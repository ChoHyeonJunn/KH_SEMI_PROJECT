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
	/**
	 * 초기 페이지 로딩시 댓글 불러오기
	 */
	$(function() {

		selectComment();

	});

	/**
	 * 댓글 불러오기(Ajax)
	 */
	function selectComment() {
		var COMMENT_BOARD_NO = <c:out value="${QNA_BOARD.QNA_BOARD_NO }" />;

		$
				.getJSON(
						"/DEVCA/qnacomment/qnacommentlist.do",
						{
							COMMENT_BOARD_NO : COMMENT_BOARD_NO
						},
						function(data) {

							var output = "";
							$
									.each(
											data,
											function(index, comm) {

												output += "<div>"
														+ comm.COMMENT_WRITER
														+ " / "
														+ comm.COMMENT_DATE
														+ "<br/>";

												output += "<div>"
														+ comm.COMMENT_CONTENT
														+ "</div>";

												output += "<input type='button' value='답글' onclick='createSubComment("
														+ comm.COMMENT_NO
														+ ","
														+ comm.COMMENT_BOARD_NO
														+ ","
														+ '"'
														+ comm.COMMENT_WRITER
														+ '"'
														+ ","
														+ comm.COMMENT_GROUP_NO
														+ ","
														+ comm.COMMENT_GROUP_ORDER
														+ ","
														+ comm.COMMENT_GROUP_DEPTH
														+ ")'/>&nbsp;&nbsp;&nbsp;";

												output += "<input type='button' value='수정' onclick='updateFormToggle("
														+ comm.COMMENT_NO
														+ ","
														+ comm.COMMENT_GROUP_NO
														+ ","
														+ '"'
														+ comm.COMMENT_CONTENT
														+ '"'
														+ ")'/>&nbsp;&nbsp;&nbsp;";

												output += "<input type='button' value='삭제' onclick='deleteComment("
														+ comm.COMMENT_BOARD_NO
														+ ","
														+ comm.COMMENT_NO
														+ ","
														+ comm.COMMENT_GROUP_DEPTH
														+ ","
														+ comm.COMMENT_GROUP_NO
														+ ")'/><br/>";

												output += "<form id='updateForm" + comm.COMMENT_NO + "'></form>";
												output += "<form id='subCommentForm" + comm.COMMENT_NO + "'></form></div>";

											});

							if (output == "") {
								output += "<div>---등록된 댓글이 없습니다---</div>";
							}
							$("#ajaxCommentForm").html(output);
						})

	}

	function insertComment() {
		var COMMENT_BOARD_NO = $("#commentSubmit").find(
				"input[name='COMMENT_BOARD_NO']").val();
		var COMMENT_WRITER = $("#commentSubmit").find(
				"input[name='COMMENT_WRITER']").val();
		var COMMENT_CONTENT = $("#commentSubmit").find(
				"textarea[name='COMMENT_CONTENT']").val();

		$.ajax({
			type : 'POST',
			url : "/DEVCA/qnacomment/qnacommentwrite.do",
			data : {
				COMMENT_BOARD_NO : COMMENT_BOARD_NO,
				COMMENT_WRITER : COMMENT_WRITER,
				COMMENT_CONTENT : COMMENT_CONTENT
			},
			datatype : "text",

			success : function(args) {
				selectComment();
				$("#commentSubmit").find("input[name='COMMENT_WRITER']")
						.val("");
				$("#commentSubmit").find("textarea[name='COMMENT_CONTENT']")
						.val("");

			},
			error : function(request, status, error) {
				//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}

		});
	}

	function deleteComment(COMMENT_BOARD_NO, COMMENT_NO, COMMENT_GROUP_DEPTH,
			COMMENT_GROUP_NO) {

		$.ajax({
			type : "POST",
			url : "/DEVCA/qnacomment/qnacommentdelete.do",
			data : {
				COMMENT_BOARD_NO : COMMENT_BOARD_NO,
				COMMENT_NO : COMMENT_NO,
				COMMENT_GROUP_DEPTH : COMMENT_GROUP_DEPTH,
				COMMENT_GROUP_NO : COMMENT_GROUP_NO
			},
			datatype : "text",

			success : function(args) {
				alert("댓글 삭제 성공!!")
				selectComment();
			},

			error : function(request, status, error) {
				alert("통신 실패");
				alert("code : " + request.status + "\n" + "message : "
						+ request.responseText + "\n" + "error : " + error);
			}
		})
	}

	function updateFormToggle(COMMENT_NO, COMMENT_BOARD_NO, COMMENT_CONTENT) {

		var updateForm = document.getElementById("updateForm" + COMMENT_NO);

		var str = '<form action="/DEVCA/qnacomment/qnacommentupdate.do" method="post" id="updateForm' + COMMENT_NO + '">'
				+ '<input type="hidden" name="COMMENT_BOARD_NO" value="' + COMMENT_BOARD_NO + '"/>'
				+ '<input type="hidden" name="COMMENT_NO" value="' + COMMENT_NO + '"/>'
				+ '<textarea cols="50" rows="3" name="COMMENT_CONTENT" placeholder="">'
				+ COMMENT_CONTENT
				+ '</textarea>'
				+ '<br/><input type="button" value="수정" onclick="updateComment('
				+ COMMENT_NO
				+ ')"/>'
				+ '&nbsp;&nbsp;&nbsp;'
				+ '<input type="button" value="취소" onclick="selectComment()"/>'
				+ '</form>';

		var addForm = document.createElement("div");
		addForm.innerHTML = str;
		updateForm.appendChild(addForm);
	}

	// update : ajax : 댓글 수정
	function updateComment(COMMENT_NO) {
		var COMMENT_BOARD_NO = $("#updateForm" + COMMENT_NO).find(
				"input[name='COMMENT_BOARD_NO']").val();
		var COMMENT_NO = $("#updateForm" + COMMENT_NO).find(
				"input[name='COMMENT_NO']").val();
		var COMMENT_CONTENT = $("#updateForm" + COMMENT_NO).find(
				"textarea[name='COMMENT_CONTENT']").val();

		$.ajax({
			type : "POST",
			url : "/DEVCA/qnacomment/qnacommentupdate.do",
			data : {
				COMMENT_BOARD_NO : COMMENT_BOARD_NO,
				COMMENT_NO : COMMENT_NO,
				COMMENT_CONTENT : COMMENT_CONTENT
			},
			datatype : "text",

			success : function(args) {
				selectComment();
			},

			error : function(request, status, error) {
				alert("통신 실패");
				alert("code : " + request.status + "\n" + "message : "
						+ request.responseText + "\n" + "error : " + error);
			}
		})
	}

	function createSubComment(parentcommentno, COMMENT_BOARD_NO,
			COMMENT_WRITER, COMMENT_GROUP_NO, COMMENT_GROUP_ORDER,
			COMMENT_GROUP_DEPTH) {

		var subCommentForm = document.getElementById("subCommentForm"
				+ parentcommentno);

		var str = '<form action="/DEVCA/qnacomment/qnasubcommment.do" method="post" id="subCommentForm' + parentcommentno + '">'
				+ '<input type="hidden" name="parentcommentno" value="' + parentcommentno + '"/>'
				+ '<input type="hidden" name="COMMENT_BOARD_NO" value="' + COMMENT_BOARD_NO + '"/>'
				+ '<input type="hidden" name="COMMENT_GROUP_NO" value="' + COMMENT_GROUP_NO + '"/>'
				+ '<input type="hidden" name="COMMENT_GROUP_ORDER" value="' + COMMENT_GROUP_ORDER + '"/>'
				+ '<input type="hidden" name="COMMENT_GROUP_DEPTH" value="' + COMMENT_GROUP_DEPTH + '"/>'
				+ '<textarea cols="50" rows="3" name="COMMENT_CONTENT" placeholder="">@'
				+ COMMENT_WRITER
				+ ' : </textarea>'
				+ '<br/> 작성자 : <input type="text" name="COMMENT_WRITER" />'
				+ '<br/><input type="button" value="답글달기" onclick="insertSubComment('
				+ parentcommentno
				+ ')"/>'
				+ '&nbsp;&nbsp;&nbsp;'
				+ '<input type="button" value="취소" onclick="selectComment()"/>'
				+ '</form>';

		var addForm = document.createElement("div");
		addForm.innerHTML = str;
		subCommentForm.appendChild(addForm);
	}

	/* function createSubComment(parentcommentno, COMMENT_BOARD_NO, COMMENT_WRITER,
			COMMENT_GROUP_NO, COMMENT_GROUP_ORDER, COMMENT_GROUP_DEPTH) {
		// 대댓글 달기 폼
		var subCommentForm = $("#subCommentForm" + COMMENT_NO);
		subCommentForm.append($("<form>").attr({
			action : "/DEVCA/qnacomment/qnasubcomment.do",
			method : "POST",
			id : "subCommentSubmit" + COMMENT_NO
		}));
		subCommentForm.append($("<input>").attr({
			type : "hidden",
			name : "parentcommentno",
			value : parentcommentno
		}));
		subCommentForm.append($("<input>").attr({
			type : "hidden",
			name : "COMMENT_BOARD_NO",
			value : COMMENT_BOARD_NO
		}));

		subCommentForm.append($("<input>").attr({
			type : "hidden",
			name : "COMMENT_GROUP_NO",
			value : COMMENT_GROUP_NO
		}));
		subCommentForm.append($("<input>").attr({
			type : "hidden",
			name : "COMMENT_GROUP_ORDER",
			value : COMMENT_GROUP_ORDER
		}));
		subCommentForm.append($("<input>").attr({
			type : "hidden",
			name : "COMMENT_GROUP_DEPTH",
			value : COMMENT_GROUP_DEPTH
		}));

		subCommentForm.append($("<br/>"));
		subCommentForm.append($("<textarea>").attr({
			cols : "120",
			rows : "3",
			name : "COMMENT_CONTENT",
			placeholder : "여러분의 소중한 답글을 입력해주세요.",
		}).text("ㄴ@" + COMMENT_WRITER +""));

		subCommentForm.append($("<br/>"));

		subCommentForm.append("작성자 : ");
		subCommentForm.append($("<input>").attr({
			type : "text",
			name : "COMMENT_WRITER"
		}));
		subCommentForm.append($("<br/>"));
		subCommentForm.append($("<br/>"));
		subCommentForm.append($("<input>").attr({
			type : "button",
			value : "답글달기",
			onclick : "insertSubComment(" + COMMENT_NO + ");",
			"class" : "btn btn-dark",
		}));
		subCommentForm.append("&nbsp;&nbsp;&nbsp;");
		subCommentForm.append($("<input>").attr({
			type : "button",
			value : "취소",
			onclick : "cancelSubComment(" + COMMENT_NO + ");"
		}));
	}

	// insert : 대댓글 폼 display 숨기기
	function cancelSubComment(COMMENT_NO) {
		$("#subCommentForm" + COMMENT_NO).empty();
	}*/

	// insert : ajax : 대댓글 쓰기
	function insertSubComment(parentcommentno) {
		var form = $("#subCommentForm" + parentcommentno);

		var parentcommentno = form.find("input[name='parentcommentno']").val();
		var COMMENT_BOARD_NO = form.find("input[name='COMMENT_BOARD_NO']")
				.val();
		var COMMENT_WRITER = form.find("input[name='COMMENT_WRITER']").val();
		var COMMENT_CONTENT = form.find("textarea[name='COMMENT_CONTENT']")
				.val();
		var COMMENT_GROUP_NO = form.find("input[name='COMMENT_GROUP_NO']")
				.val();
		var COMMENT_GROUP_ORDER = form
				.find("input[name='COMMENT_GROUP_ORDER']").val();
		var COMMENT_GROUP_DEPTH = form
				.find("input[name='COMMENT_GROUP_DEPTH']").val();

		$.ajax({
			type : "POST",
			url : "/DEVCA/qnacomment/qnasubcomment.do",
			data : {
				parentcommentno : parentcommentno,
				COMMENT_BOARD_NO : COMMENT_BOARD_NO,
				COMMENT_WRITER : COMMENT_WRITER,
				COMMENT_CONTENT : COMMENT_CONTENT,
				COMMENT_GROUP_NO : COMMENT_GROUP_NO,
				COMMENT_GROUP_ORDER : COMMENT_GROUP_ORDER,
				COMMENT_GROUP_DEPTH : COMMENT_GROUP_DEPTH
			},
			datatype : "text",

			success : function(args) {
				selectComment();

			},

			error : function(request, status, error) {
				alert("통신 실패" + parentcommentno);
				alert("code : " + request.status + "\n" + "message : "
						+ request.responseText + "\n" + "error : " + error);
			}
		})
	}
</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>

	<section>
		<input type="button" value="목록"
			onclick="location.href='/DEVCA/qnapage/qnalist.do'" />
		<form>
			<div>
				${QNA_BOARD.QNA_TITLE }
				<div>${QNA_BOARD.QNA_WRITER }/${QNA_BOARD.QNA_DATE }</div>
				${QNA_BOARD.QNA_CONTENT }
				<div>
					<input type="button" class="btn" value="글쓰기"
						onclick="location.href='/DEVCA/qnapage/qnawriteform.do'" />
					&nbsp; <input type="button" value="답글"
						onclick="location.href='/DEVCA/qnapage/answerform.do?QNA_BOARD_NO=${QNA_BOARD.QNA_BOARD_NO }'" />
					&nbsp; <input type="button" value="수정"
						onclick="location.href='/DEVCA/qnapage/qnaupdateform.do?QNA_BOARD_NO=${QNA_BOARD.QNA_BOARD_NO }'" />
					&nbsp; <input type="button" value="삭제"
						onclick="location.href='/DEVCA/qnapage/qnadelete.do?QNA_BOARD_NO=${QNA_BOARD.QNA_BOARD_NO }'" />
					&nbsp; <input type="button" value="목록"
						onclick="location.href='/DEVCA/qnapage/qnalist.do'" />
				</div>
			</div>
		</form>
		<div class="container mx-auto m-4 p-4 bg-ligth shadow">

			<!-- start :: ajax 댓글 리스트 -->
			<div id="ajaxCommentForm"></div>
			<!-- end :: ajax 댓글 리스트 -->

			<!-- start :: 댓글 달기 -->
			<form action="/DEVCA/comment/commentwrite.do" method="post"
				id="commentSubmit">
				<input type="hidden" name="COMMENT_BOARD_NO"
					value="${QNA_BOARD.QNA_BOARD_NO }" />
				<div>
					<textarea cols="50" rows="5" name="COMMENT_CONTENT"
						placeholder="여러분의 소중한 댓글을 입력해주세요."></textarea>
					<br /> 작성자 : <input type="text" name="COMMENT_WRITER" /> <br />
					<br /> <input type="button" value="댓글달기"
						onclick="insertComment();" />
				</div>

			</form>


		</div>
		<!-- end :: Comment Form-->
	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>