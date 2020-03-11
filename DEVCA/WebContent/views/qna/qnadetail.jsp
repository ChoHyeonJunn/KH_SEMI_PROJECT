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

												output += "<div class='card p-4 my-3 bg-white'><div>"
														+ comm.COMMENT_CONTENT
														+ "</div></div>";

												output += "<strong>"
														+ comm.MEMBER_NAME
														+ " / "
														+ comm.MEMBER_EMAIL
														+ "</strong> / "
														+ comm.COMMENT_DATE
														+ "<br/><br/>";

												output += "<c:if test='${not empty sessionLoginMember.MEMBER_CODE || not empty sessionLoginKakao.MEMBER_CODE || not empty sessionLoginNaver.MEMBER_CODE}'>"

												output += "<input type='button' class='btn' value='답글' id='subCommentBtn' onclick='subCommentToggle("
														+ comm.COMMENT_NO
														+ ")'/>&nbsp;&nbsp;&nbsp;";

												output += "<input type='button' class='btn' value='수정' id='updateBtn' onclick='updateFormToggle("
														+ comm.COMMENT_NO
														+ ")'/>&nbsp;&nbsp;&nbsp;";

												output += "<input type='button' class='btn' value='삭제' onclick='deleteComment("
														+ comm.COMMENT_BOARD_NO
														+ ","
														+ comm.COMMENT_NO
														+ ","
														+ comm.COMMENT_GROUP_DEPTH
														+ ","
														+ comm.COMMENT_GROUP_NO
														+ ")'/><br/></c:if>";

												output += "<form action='/DEVCA/qnacomment/qnacommentupdate.do' method='post' id='updateForm" + comm.COMMENT_NO + "' style='display:none;'>"
														+ "<input type='hidden' name='COMMENT_BOARD_NO' value='" + comm.COMMENT_BOARD_NO + "'/>"
														+ "<input type='hidden' name='COMMENT_NO' value='" + comm.COMMENT_NO + "'/>"
														+ "<textarea class='form-control' cols='50' rows='3' name='COMMENT_CONTENT' placeholder=''>"
														+ comm.COMMENT_CONTENT
														+ "</textarea>"
														+ "<br/><input type='button' class='btn' value='수정' onclick='updateComment("
														+ comm.COMMENT_NO
														+ ")'/>"
														+ "&nbsp;&nbsp;&nbsp;"
														+ "<input type='button' class='btn' value='취소' onclick='updateCancel("
														+ comm.COMMENT_NO
														+ ")'/>" + "</form>";

												output += '<form action="/DEVCA/qnacomment/qnasubcommment.do" method="post" id="subCommentForm' + comm.COMMENT_NO + '" style="display:none;">'
														+ '<input type="hidden" name="MEMBER_CODE" value="' + comm.MEMBER_CODE + '">'
														+ '<input type="hidden" name="parentcommentno" value="' + comm.COMMENT_NO + '"/>'
														+ '<input type="hidden" name="COMMENT_BOARD_NO" value="' + comm.COMMENT_BOARD_NO + '"/>'
														+ '<input type="hidden" name="COMMENT_GROUP_NO" value="' + comm.COMMENT_GROUP_NO + '"/>'
														+ '<input type="hidden" name="COMMENT_GROUP_ORDER" value="' + comm.COMMENT_GROUP_ORDER + '"/>'
														+ '<input type="hidden" name="COMMENT_GROUP_DEPTH" value="' + comm.COMMENT_GROUP_DEPTH + '"/>'
														+ '<textarea class="form-control" cols="50" rows="3" name="COMMENT_CONTENT">ㄴ'
														+ comm.MEMBER_NAME
														+ ' : </textarea>'
														+ '<br/><input type="button" class="btn" value="답글달기" onclick="insertSubComment('
														+ comm.COMMENT_NO
														+ ')"/>'
														+ '&nbsp;&nbsp;&nbsp;'
														+ '<input type="button" class="btn" value="취소" onclick="subCommentCancel('
														+ comm.COMMENT_NO
														+ ')"/>'
														+ '</form><hr/>';

											});

							if (output == "") {
								output += "<div class='card p-4 my-3 bg-white'>---등록된 댓글이 없습니다---</div>";
							}
							$("#ajaxCommentForm").html(output);
						})

	}

	function insertComment() {
		var MEMBER_CODE = $("#commentSubmit").find("input[name='MEMBER_CODE']")
				.val();
		var COMMENT_BOARD_NO = $("#commentSubmit").find(
				"input[name='COMMENT_BOARD_NO']").val();
		var COMMENT_CONTENT = $("#commentSubmit").find(
				"textarea[name='COMMENT_CONTENT']").val();

		$.ajax({
			type : 'POST',
			url : "/DEVCA/qnacomment/qnacommentwrite.do",
			data : {
				MEMBER_CODE : MEMBER_CODE,
				COMMENT_BOARD_NO : COMMENT_BOARD_NO,
				COMMENT_CONTENT : COMMENT_CONTENT
			},
			datatype : "text",

			success : function(args) {
				selectComment();
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

	function updateFormToggle(COMMENT_NO) {
		$("#updateForm" + COMMENT_NO).show();
	}

	function updateCancel(COMMENT_NO) {
		$("#updateForm" + COMMENT_NO).hide();
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

	function subCommentToggle(COMMENT_NO) {
		$("#subCommentForm" + COMMENT_NO).show();
	}

	function subCommentCancel(COMMENT_NO) {
		$("#subCommentForm" + COMMENT_NO).hide();
	}

	// insert : ajax : 대댓글 쓰기
	function insertSubComment(COMMENT_NO) {
		var form = $("#subCommentForm" + COMMENT_NO);

		var parentcommentno = form.find("input[name='parentcommentno']").val();
		var COMMENT_BOARD_NO = form.find("input[name='COMMENT_BOARD_NO']")
				.val();
		var COMMENT_CONTENT = form.find("textarea[name='COMMENT_CONTENT']")
				.val();
		var COMMENT_GROUP_NO = form.find("input[name='COMMENT_GROUP_NO']")
				.val();
		var COMMENT_GROUP_ORDER = form
				.find("input[name='COMMENT_GROUP_ORDER']").val();
		var COMMENT_GROUP_DEPTH = form
				.find("input[name='COMMENT_GROUP_DEPTH']").val();
		var MEMBER_CODE = form.find("input[name='MEMBER_CODE']").val();

		$.ajax({
			type : "POST",
			url : "/DEVCA/qnacomment/qnasubcomment.do",
			data : {
				parentcommentno : parentcommentno,
				COMMENT_BOARD_NO : COMMENT_BOARD_NO,
				COMMENT_CONTENT : COMMENT_CONTENT,
				COMMENT_GROUP_NO : COMMENT_GROUP_NO,
				COMMENT_GROUP_ORDER : COMMENT_GROUP_ORDER,
				COMMENT_GROUP_DEPTH : COMMENT_GROUP_DEPTH,
				MEMBER_CODE : MEMBER_CODE
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

		<form>
			<div class="card p-4 my-3 bg-white">
				<div class="col-md-10">
					<h2>${QNA_BOARD.QNA_TITLE }</h2>
				</div>
				<div class="col-md-9">
					<strong>${QNA_BOARD.MEMBER_NAME } /
						${QNA_BOARD.MEMBER_EMAIL }</strong> / ${QNA_BOARD.QNA_DATE }
				</div>
				<div class="card p-4 my-3 bg-white">${QNA_BOARD.QNA_CONTENT }</div>
				<div>
					<c:if
						test="${not empty sessionLoginMember.MEMBER_CODE || not empty sessionLoginKakao.MEMBER_CODE || not empty sessionLoginNaver.MEMBER_CODE}">
						<input type="button" class="btn" value="글쓰기"
							onclick="location.href='/DEVCA/qnapage/qnawriteform.do'" />
					&nbsp; <input type="button" class="btn" value="답글"
							onclick="location.href='/DEVCA/qnapage/answerform.do?QNA_BOARD_NO=${QNA_BOARD.QNA_BOARD_NO }'" />
					&nbsp; <input type="button" class="btn" value="수정"
							onclick="location.href='/DEVCA/qnapage/qnaupdateform.do?QNA_BOARD_NO=${QNA_BOARD.QNA_BOARD_NO }'" />
					&nbsp; <input type="button" class="btn" value="삭제"
							onclick="location.href='/DEVCA/qnapage/qnadelete.do?QNA_BOARD_NO=${QNA_BOARD.QNA_BOARD_NO }'" />
					&nbsp; 
					</c:if>
					<input type="button" class="btn" value="목록"
						onclick="location.href='/DEVCA/qnapage/qnalist.do'" />
				</div>
			</div>
		</form>



		<!-- start :: ajax 댓글 리스트 -->
		<div class="card p-4 my-3 bg-white">
			<h5>댓글</h5>
			<div id="ajaxCommentForm"></div>
			<!-- end :: ajax 댓글 리스트 -->

			<!-- start :: 댓글 달기 -->
			<c:if
				test="${not empty sessionLoginMember.MEMBER_CODE || not empty sessionLoginKakao.MEMBER_CODE || not empty sessionLoginNaver.MEMBER_CODE}">
				<form action="/DEVCA/comment/commentwrite.do" method="post"
					id="commentSubmit">
					<input type="hidden" name="MEMBER_CODE"
						value="${sessionMember_profile.MEMBER_CODE }"> <input
						type="hidden" name="COMMENT_BOARD_NO"
						value="${QNA_BOARD.QNA_BOARD_NO }" />
					<div>
						<textarea class="form-control" cols="50" rows="5"
							name="COMMENT_CONTENT" placeholder="여러분의 소중한 댓글을 입력해주세요."></textarea>
						<br /> <input class="btn" type="button" value="댓글달기"
							onclick="insertComment();" />

					</div>

				</form>

			</c:if>
			<!-- end :: Comment Form-->
		</div>
	</section>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>