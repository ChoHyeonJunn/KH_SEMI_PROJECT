<%@page import="com.VO.FilesVO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" import="com.VO.UsersVO, com.VO.BoardsVO"%>

<%@ include file="inc_header.html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="sessionLoginUser" value="${sessionScope.loginUser}"></c:set>

<c:set var="user" value="${userContents}" />
<c:set var="board" value="${boardContents}" />
<c:set var="file" value="${fileContents}" />


<!DOCTYPE html>
<html>
<head>
   <meta charset="EUC-KR">
   <title>글 내용</title>

   <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
   <script type="text/javascript">

   $(function () {
      // 온로드시 댓글 정보 select
      selectComment();
   })

   // select : 댓글 리스트 html에 표시
   function fillComment(commentsList){
      $("#ajaxCommentForm").empty();
      $.each(commentsList, function (index, comment) {

         // 댓글 div 생성
         if (comment.GROUP_DEPTH > 0) {
            $("#ajaxCommentForm").append($("<div>").attr({
               id: comment.GROUP_DEPTH,
               style: "margin: 10px; margin-left: 50px;"
            }));
         } else {
            $("#ajaxCommentForm").append($("<div>").attr({
               id: comment.GROUP_DEPTH,
               style: "margin: 10px; "
            }));
         }

         // index번째 댓글 div를 찾아 내부 div 생성
         var commentDiv = $("#ajaxCommentForm > div").eq(index);
         commentDiv.append($("<div>").attr({
            "class" : "content"
         }));
         commentDiv.append($("<div>").attr({
            id : "goodbad" + comment.COMMENT_CODE
         }));
         commentDiv.append($("<div>").attr({
            id : "subCommentForm"+comment.COMMENT_CODE,
            style: "padding-left: 50px;"
         }))

         //내부 div 안에 콘텐츠 생성 <!-- start :: 이름, 작성일, 수정, 삭제, 내용, 수정폼대기 -->
         var content = commentDiv.find(".content");
         content.append($("<span>").attr("class", "name").text(comment.NAME));
         content.append($("<span>").attr("class", "date").text(comment.CREATE_DATE));
         if (
            comment.USER_CODE 
            == 
            <c:choose>
               <c:when test="${ empty sessionLoginUser}">
                  <c:out value="-1"/>
               </c:when>
               <c:otherwise>
                  <c:out value="${ sessionLoginUser.USER_CODE }"/>
               </c:otherwise>
            </c:choose>
            ) {
            content.append($("<a>").attr({
               id: "UpdateButton" + comment.COMMENT_CODE,
               href: "javascript:change(" + comment.COMMENT_CODE + "," + comment.BOARD_CODE + ",'" + comment.CONTEXT + "');"
            }).text("수정"));
            content.append("&nbsp;");
            content.append($("<a>").attr({
               href: "javascript:deleteComment(${board.BOARD_CODE},"+comment.COMMENT_CODE+","+comment.GROUP_DEPTH+","+comment.GROUP_NO+")"
            }).text("삭제"));
         }
         content.append($("<div>").attr("id", "Content" + comment.COMMENT_CODE).text(comment.CONTEXT));
         content.append($("<div>").attr("id", "updateForm" + comment.COMMENT_CODE));

         // 내부 div 안에 좋아요 싫어요 답글
         var goodbad = commentDiv.find("#goodbad" + comment.COMMENT_CODE);
         if(
            <c:out value="${ empty sessionLoginUser }"/> 
            ||
            comment.USER_CODE 
            == 
            <c:choose>
               <c:when test="${ empty sessionLoginUser}">
                  <c:out value="-1"/>
               </c:when>
               <c:otherwise>
                  <c:out value="${ sessionLoginUser.USER_CODE }"/>
               </c:otherwise>
            </c:choose>         
            ){
            goodbad.append("좋아요 " + comment.COUNT_GOOD + " &nbsp;&nbsp; " + "싫어요 " + comment.COUNT_BAD);
         } else {
            goodbad.append($("<a>").attr({
               href: "javascript:statusComment(" + comment.COMMENT_CODE + ",'good')"
            }).text("좋아요 " + comment.COUNT_GOOD)); 
            goodbad.append(" &nbsp;&nbsp; ")
            goodbad.append($("<a>").attr({
               href: "javascript:statusComment(" + comment.COMMENT_CODE + ",'bad')"
            }).text("싫어요 " + comment.COUNT_BAD));
         }
         if(<c:out value="${not empty sessionLoginUser}"/>){
            goodbad.append($("<input>").attr({
               type: "button",
               onclick: "createSubComment(" + comment.COMMENT_CODE + ",'" + comment.NAME + "'," + comment.GROUP_NO +"," + comment.GROUP_ORDER + "," + comment.GROUP_DEPTH + ");",
               value: "답글"
            }));
         }

         
         // 임시 콘솔 출력
         console.log(
            "COMMENT_CODE : " + comment.COMMENT_CODE + "\n" +
            "BOARD_CODE : " + comment.BOARD_CODE + "\n" +
            "USER_CODE : " + comment.USER_CODE + "\n" +
            "CONTEXT : " + comment.CONTEXT + "\n" +

            "COUNT_GOOD : " + comment.COUNT_GOOD + "\n" +
            "COUNT_BAD : " + comment.COUNT_BAD + "\n" +
            "CREATE_DATE : " + comment.CREATE_DATE + "\n" +
            "UPDATE_DATE : " + comment.UPDATE_DATE + "\n" +

            "GROUP_NO : " + comment.GROUP_NO + "\n" +
            "GROUP_ORDER : " + comment.GROUP_ORDER + "\n" +
            "GROUP_DEPTH : " + comment.GROUP_DEPTH + "\n" +
            "NAME : " + comment.NAME
         );
      });
   }

   // select : ajax : 댓글 list 불러오기
   function selectComment() {
      var BOARD_CODE = <c:out value="${board.BOARD_CODE}" />;
      $.ajax({
         type: "POST",
         url: "/Basic_Board_Project/BoardController?action=selectComment",
         data: {
            BOARD_CODE: BOARD_CODE
         },
         datatype: "JSON",

         success: function (args) {
            var commentsList = JSON.parse(args);
            fillComment(commentsList); //댓글 html 표시 함수 호출
         },

         error: function (request, status, error) {
            alert("통신 실패");
            alert("code : " + request.status + "\n" +
               "message : " + request.responseText + "\n" +
               "error : " + error);
         }
      });
   }

   // insert : ajax : 원 댓글 쓰기
   function commentSubmit() {
      var BOARD_CODE = $("#commentSubmit").find("input[name='BOARD_CODE']").val();
      var USER_CODE = $("#commentSubmit").find("input[name='USER_CODE']").val();
      var CONTEXT = $("#commentSubmit").find("textarea[name='CONTEXT']").val();

      $.ajax({
         type: "POST",
         url: "/Basic_Board_Project/BoardController?action=insertComment",
         data: {
            BOARD_CODE: BOARD_CODE,
            USER_CODE: USER_CODE,
            CONTEXT: CONTEXT
         },
         datatype: "text",

         success: function (args) {
            selectComment();
         },
         error: function (request, status, error) {
            alert("통신 실패");
            alert("code : " + request.status + "\n" +
               "message : " + request.responseText + "\n" +
               "error : " + error);
         }
      })
   }
   
   // insert : 대댓글 폼 display 표시
   function createSubComment(COMMENT_CODE, NAME, GROUP_NO, GROUP_ORDER, GROUP_DEPTH) {

      // 대댓글 달기 폼
      var subCommentForm = $("#subCommentForm"+COMMENT_CODE);
         subCommentForm.append($("<form>").attr({
            action: "/Basic_Board_Project/BoardController?action=insertSubComment",
            method: "POST",
            id : "subCommentSubmit" + COMMENT_CODE
         }));
         var subForm = subCommentForm.find("form").eq(0);
         subForm.append($("<input>").attr({
            type: "hidden",
            name: "BOARD_CODE",
            value: "${board.BOARD_CODE}"
         }));
         subForm.append($("<input>").attr({
            type: "hidden",
            name: "USER_CODE",
            value: "${sessionLoginUser.USER_CODE}"
         }));
         subForm.append($("<input>").attr({
            type: "hidden",
            name: "GROUP_NO",
            value: GROUP_NO
         }));
         subForm.append($("<input>").attr({
            type: "hidden",
            name: "GROUP_ORDER",
            value: GROUP_ORDER
         }));
         subForm.append($("<input>").attr({
            type: "hidden",
            name: "GROUP_DEPTH",
            value: GROUP_DEPTH
         }));
         subForm.append($("<textarea>").attr({
            cols: "120",
            rows: "3",
            name: "CONTEXT",
            placeholder: "여러분의 소중한 답글을 입력해주세요.",
         }).text("@" + NAME + " " ));
         subForm.append($("<div>").attr({
            style: "margin-left: 700px;"
         }));
         var formDiv = subForm.find("div").eq(0);
         formDiv.append($("<input>").attr({
            type: "button",
            value: "취소",
            "class" : "btn btn-dark",
            style: "margin-right: 10px;",
            onclick: "cancelSubComment(" + COMMENT_CODE + ");"
         }));
         formDiv.append($("<input>").attr({
            type: "button",
            value: "댓글달기",
            onclick: "insertSubComment(" + COMMENT_CODE + ");",
            "class" : "btn btn-dark",
         }));
   }

   // insert : 대댓글 폼 display 숨기기
   function cancelSubComment(COMMENT_CODE) {
      $("#subCommentForm"+COMMENT_CODE).empty();
   }

   // insert : ajax : 대댓글 쓰기
   function insertSubComment(COMMENT_CODE) {
      var form = $("#subCommentSubmit" + COMMENT_CODE);

      var BOARD_CODE = form.find("input[name='BOARD_CODE']").val();
      var USER_CODE = form.find("input[name='USER_CODE']").val();
      var GROUP_NO = form.find("input[name='GROUP_NO']").val();
      var GROUP_ORDER = form.find("input[name='GROUP_ORDER']").val();
      var GROUP_DEPTH = form.find("input[name='GROUP_DEPTH']").val();
      var CONTEXT = form.find("textarea[name='CONTEXT']").val();

      $.ajax({
            type: "POST",
            url: "/Basic_Board_Project/BoardController?action=insertSubComment",
            data: {
               BOARD_CODE: BOARD_CODE,
               USER_CODE: USER_CODE,
               GROUP_NO: GROUP_NO,
               GROUP_ORDER: GROUP_ORDER,
               GROUP_DEPTH: GROUP_DEPTH,
               CONTEXT: CONTEXT
            },
            datatype: "text",

            success: function (args) {
               selectComment();
            },

            error: function (request, status, error) {
               alert("통신 실패");
               alert("code : " + request.status + "\n" +
                  "message : " + request.responseText + "\n" +
                  "error : " + error);
            }
         })
   }

   // update : 수정 버튼 클릭 -> form 나타내기
   function change(COMMENT_CODE, BOARD_CODE, CONTEXT) {
      var delUpdateButton = document.getElementById("UpdateButton" + COMMENT_CODE);
      var delContent = document.getElementById("Content" + COMMENT_CODE);

      delUpdateButton.remove();
      delContent.remove();

      var updateForm = document.getElementById("updateForm" + COMMENT_CODE);

      var str =
         '<form action="/Basic_Board_Project/BoardController?action=updateComment" method="post" id="updateForm' + COMMENT_CODE + '">' +
         '   <input type="hidden" name="BOARD_CODE" value="' + BOARD_CODE + '">' +
         '   <input type="hidden" name="COMMENT_CODE" value="' + COMMENT_CODE + '">' +
         '   <textarea cols="120" rows="3" name="CONTEXT">' + CONTEXT + '</textarea>' +
         '   <input type="button" value="수정" onclick="updateComment(' + COMMENT_CODE + ');" class="btn btn-dark">' +
         '</form>';


      var addForm = document.createElement("div");
      addForm.innerHTML = str;
      updateForm.appendChild(addForm);
   }

   // update : ajax : 댓글 수정
   function updateComment(COMMENT_CODE) {
      var BOARD_CODE = $("#updateForm"+COMMENT_CODE).find("input[name='BOARD_CODE']").val();
      var COMMENT_CODE = $("#updateForm"+COMMENT_CODE).find("input[name='COMMENT_CODE']").val();
      var CONTEXT = $("#updateForm"+COMMENT_CODE).find("textarea[name='CONTEXT']").val();

      $.ajax({
            type: "POST",
            url: "/Basic_Board_Project/BoardController?action=updateComment",
            data: {
               BOARD_CODE: BOARD_CODE,
               COMMENT_CODE: COMMENT_CODE,
               CONTEXT: CONTEXT
            },
            datatype: "text",

            success: function (args) {
               selectComment();
            },

            error: function (request, status, error) {
               alert("통신 실패");
               alert("code : " + request.status + "\n" +
                  "message : " + request.responseText + "\n" +
                  "error : " + error);
            }
         })
   }
   
   // update : ajax : 좋아요 싫어요
   function statusComment(COMMENT_CODE,status){
      var BOARD_CODE = <c:out value="${board.BOARD_CODE}"/>;

      $.ajax({
            type: "POST",
            url:  "/Basic_Board_Project/BoardController?action=statusComment",
            data: {
               BOARD_CODE: BOARD_CODE,
               COMMENT_CODE: COMMENT_CODE,
               status: status
            },
            datatype: "text",

            success: function (args) {
               selectComment();
            },

            error: function (request, status, error) {
               alert("통신 실패");
               alert("code : " + request.status + "\n" +
                  "message : " + request.responseText + "\n" +
                  "error : " + error);
            }
         })
   }

   // delete : ajax : 댓글 삭제하기
   function deleteComment(BOARD_CODE,COMMENT_CODE,GROUP_DEPTH,GROUP_NO){

         $.ajax({
            type: "POST",
            url: "/Basic_Board_Project/BoardController?action=deleteComment",
            data: {
               BOARD_CODE: BOARD_CODE,
               COMMENT_CODE: COMMENT_CODE,
               GROUP_DEPTH: GROUP_DEPTH,
               GROUP_NO: GROUP_NO
            },
            datatype: "text",

            success: function (args) {
               if(args == 'true')
                  alert("댓글 삭제 성공!!")
               else
                  alert("댓글 삭제 실패 ㅜㅜ")
               selectComment();
            },

            error: function (request, status, error) {
               alert("통신 실패");
               alert("code : " + request.status + "\n" +
                  "message : " + request.responseText + "\n" +
                  "error : " + error);
            }
         })
   }

   
   </script>
</head>

<body>
   <div class="container mx-auto m-5 p-5 bg-ligth shadow">

      <!-- start :: BoardContent Detail -->
      <table>
         <tr>
            <td align="center" width="76">글번호</td>
            <td width="319">${board.BOARD_CODE}</td>
         </tr>
         <tr>
            <td align="center" width="76">조회수</td>
            <td width="319">${board.COUNT_VIEW}</td>
         </tr>
         <tr>
            <td align="center" width="76">이름</td>
            <td width="319">${user.NAME}</td>
         </tr>
         <tr>
            <td align="center" width="76">작성일</td>
            <td width="319">${board.CREATE_DATE}</td>
         </tr>
         <tr>
            <td align="center" width="76">제목</td>
            <td width="319">${board.TITLE}</td>
         </tr>
         <tr>
            <td width="399" colspan="2" height="200">${board.CONTEXT}</td>
         </tr>

         <tr>
            <td width="0">&nbsp;</td>
            <td width="399" height="50">
               <c:choose>
                  <c:when test="${fileContents eq null}">
                     첨부파일 없음
                  </c:when>
                  <c:otherwise>
                     첨부파일 <a
                        href="/Basic_Board_Project/FileController?FILE_CODE=${file.FILE_CODE }">${file.FILE_ORIGINAL_NAME}</a>(${file.FILE_SIZE})
                  </c:otherwise>
               </c:choose>
            </td>
         </tr>
         <tr align="center">
            <td colspan="2" width="399">
               <a class="btn btn-dark" href="/Basic_Board_Project/BoardController?action=listBoard">목록</a>
               <c:if test="${sessionLoginUser.USER_CODE eq board.USER_CODE}">
                  <a class="btn btn-dark"
                     href="/Basic_Board_Project/BoardController?action=updateReady&BOARD_CODE=${board.BOARD_CODE}">수정</a>
                  <a class="btn btn-dark"
                     href="/Basic_Board_Project/BoardController?action=delete&BOARD_CODE=${board.BOARD_CODE}">삭제</a>
               </c:if>
            </td>
         </tr>
      </table>
      <!-- end :: BoardContent Detail -->

      <!-- start :: Comment Form -->
      <div class="container mx-auto m-4 p-4 bg-ligth shadow">
         
         <!-- start :: 댓글 달기 -->
         <c:if test="${not empty sessionLoginUser}">
            <form action="/Basic_Board_Project/BoardController?action=insertComment" method="post" id="commentSubmit">
               <input type="hidden" name="BOARD_CODE" value="${board.BOARD_CODE }"> 
               <input type="hidden" name="USER_CODE" value="${sessionLoginUser.USER_CODE}">
               <textarea cols="120" rows="3" name="CONTEXT" placeholder="여러분의 소중한 댓글을 입력해주세요."></textarea>
               &nbsp; <input type="button" value="댓글달기" onclick="commentSubmit();" class="btn btn-dark">
            </form>
         </c:if>
         <!-- end :: 댓글 달기 -->

         <!-- start :: ajax 댓글 리스트 -->
         <div id="ajaxCommentForm"></div>
         <!-- end :: ajax 댓글 리스트 -->
      </div>
      <!-- end :: Comment Form-->
   </div>
</body>
</html>