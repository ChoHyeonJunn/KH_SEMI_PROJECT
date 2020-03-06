package com.devca.controller;

import java.io.IOException;


import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.devca.model.biz.comment.QnaCommentBizImpl;
import com.devca.model.dto.QNA_COMMENT;
import com.google.gson.Gson;

@WebServlet(//
		name = "qnacomment", // Controller Mapping name
		//
		urlPatterns = { "qnacommentlist.do", // qna 페이지로 이동
				"qnacommentwrite.do", "qnacommentupdate.do", "qnacommentdelete.do", "qnasubcomment.do" })
public class QnaCommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	public QnaCommentController() {
		super();
	}

	public QnaCommentBizImpl cbiz = new QnaCommentBizImpl();

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String command = request.getRequestURI();
		System.out.println("<" + command + ">");

		if (command.endsWith("/qnacommentlist.do")) {
			doQnaCommentList(request, response);
		} else if (command.endsWith("/qnacommentwrite.do")) {
			doQnaCommentWrite(request, response);
		} else if (command.endsWith("/qnacommentupdate.do")) {
			doQnaCommentUpdate(request, response);
		} else if (command.endsWith("/qnacommentdelete.do")) {
			doQnaCommentDelete(request, response);
		} else if (command.endsWith("/qnasubcomment.do")) {
			doQnaSubComment(request, response);
		} else {
			doError(request, response);
		}
	}

	private void doQnaCommentList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub

		int COMMENT_BOARD_NO = Integer.parseInt(request.getParameter("COMMENT_BOARD_NO"));
		List<QNA_COMMENT> comlist = cbiz.selectCommentList(COMMENT_BOARD_NO);
		JSONArray jsonArr = new JSONArray();

		for (int i = 0; i < comlist.size(); i++) {
			JSONObject jsonObj = new JSONObject();

			jsonObj.put("COMMENT_NO", comlist.get(i).getCOMMENT_NO());
			jsonObj.put("COMMENT_BOARD_NO", comlist.get(i).getCOMMENT_BOARD_NO());
			jsonObj.put("COMMENT_WRITER", comlist.get(i).getCOMMENT_WRITER());
			jsonObj.put("COMMENT_CONTENT", comlist.get(i).getCOMMENT_CONTENT());

			jsonObj.put("COMMENT_DATE", comlist.get(i).getCOMMENT_DATE().toString());

			jsonObj.put("COMMENT_GROUP_NO", comlist.get(i).getCOMMENT_GROUP_NO());
			jsonObj.put("COMMENT_GROUP_ORDER", comlist.get(i).getCOMMENT_GROUP_ORDER());
			jsonObj.put("COMMENT_GROUP_DEPTH", comlist.get(i).getCOMMENT_GROUP_DEPTH());

			jsonArr.add(jsonObj);

		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(comlist);
		PrintWriter out = response.getWriter();
		out.println(jsonList);

	}

	private void doQnaCommentWrite(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();

		QNA_COMMENT QNA_COMMENT = new QNA_COMMENT();

		QNA_COMMENT.setCOMMENT_BOARD_NO(Integer.parseInt(request.getParameter("COMMENT_BOARD_NO")));
		QNA_COMMENT.setCOMMENT_WRITER(request.getParameter("COMMENT_WRITER"));
		QNA_COMMENT.setCOMMENT_CONTENT(request.getParameter("COMMENT_CONTENT"));

		int res = cbiz.insertComment(QNA_COMMENT);

		if (res > 0) {
			out.println("true");
			out.close();
		} else {
			out.println("false");
			out.close();
		}
	}

	private void doQnaCommentUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub

		PrintWriter out = response.getWriter();

		QNA_COMMENT QNA_COMMENT = new QNA_COMMENT();

		QNA_COMMENT.setCOMMENT_BOARD_NO(Integer.parseInt(request.getParameter("COMMENT_BOARD_NO")));
		QNA_COMMENT.setCOMMENT_NO(Integer.parseInt(request.getParameter("COMMENT_NO")));
		QNA_COMMENT.setCOMMENT_CONTENT(request.getParameter("COMMENT_CONTENT"));

		int res = cbiz.updateComment(QNA_COMMENT);

		if (res > 0) {
			out.println("true");
			out.close();
		} else {
			out.println("false");
			out.close();
		}
	}

	private void doQnaCommentDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();

		System.out.println("delete Comment");

		int res = cbiz.deleteComment(Integer.parseInt(request.getParameter("COMMENT_NO")));

		if (res > 0) {
			out.println("true");
			out.close();
		} else {
			out.println("false");
			out.close();
		}
	}

	private void doQnaSubComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		
		int parentcommentno = Integer.parseInt(request.getParameter("parentcommentno"));
		int COMMENT_BOARD_NO = Integer.parseInt(request.getParameter("COMMENT_BOARD_NO"));
		
		System.out.println(COMMENT_BOARD_NO);
		

		QNA_COMMENT QNA_COMMENT = new QNA_COMMENT();
		QNA_COMMENT.setCOMMENT_NO(parentcommentno);
		QNA_COMMENT.setCOMMENT_BOARD_NO(COMMENT_BOARD_NO);
		QNA_COMMENT.setCOMMENT_WRITER(request.getParameter("COMMENT_WRITER"));
		QNA_COMMENT.setCOMMENT_CONTENT(request.getParameter("COMMENT_CONTENT"));
		QNA_COMMENT.setCOMMENT_GROUP_NO(Integer.parseInt(request.getParameter("COMMENT_GROUP_NO")));
		QNA_COMMENT.setCOMMENT_GROUP_ORDER(Integer.parseInt(request.getParameter("COMMENT_GROUP_ORDER")));
		QNA_COMMENT.setCOMMENT_GROUP_DEPTH(Integer.parseInt(request.getParameter("COMMENT_GROUP_DEPTH")));

		int res = cbiz.subCommentProc(QNA_COMMENT);
		if (res > 0) {
			out.println("true");
			out.close();
		} else {
			out.println("false" + parentcommentno);
			out.close();
		}
	}

	private void doError(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/error.jsp", request, response);
	}

	/*
	 * Servlet Basic Template : Please do not modify ...
	 */
	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}

	private void jsResponse(String msg, String url, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('" + msg + "')");
		out.println("location.href='" + url + "'");
		out.println("</script>");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		getRequest(request, response); // 모든 요청은 getRequest() 메서드에서 처리
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		getRequest(request, response); // 모든 요청은 getRequest() 메서드에서 처리
	}

}
