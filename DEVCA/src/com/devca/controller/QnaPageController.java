package com.devca.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.devca.model.biz.qna.QnaPageBizImpl;
import com.devca.model.dto.qna.QNA_BOARD;

@WebServlet(//
		name = "qnapage", // Controller Mapping name
		//
		urlPatterns = { "qnalist.do", // qna 페이지로 이동
				"qnadetail.do", "qnawriteform.do", "qnawriteres.do", "qnaupdateform.do", "qnaupdateres.do",
				"qnadelete.do", "answerform.do", "answerres.do", "faqpage.do" })
public class QnaPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	public QnaPageController() {
		super();
	}

	public QnaPageBizImpl biz = new QnaPageBizImpl();

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String command = request.getRequestURI();
		System.out.println("<" + command + ">");

		// QNA 페이지로 이동
		if (command.endsWith("/qnalist.do")) {
			doQnaList(request, response);
		} else if (command.endsWith("/qnadetail.do")) {
			doQnaDetail(request, response);
		}
		// STUDY 페이지로 이동
		else if (command.endsWith("/qnawriteform.do")) {
			doQnaWriteForm(request, response);
		} else if (command.endsWith("/qnawriteres.do")) {
			doQnaWriteRes(request, response);
		} else if (command.endsWith("/qnaupdateform.do")) {
			doQnaUpdateForm(request, response);
		} else if (command.endsWith("/qnaupdateres.do")) {
			doQnaUpdateRes(request, response);
		} else if (command.endsWith("/qnadelete.do")) {
			doQnaDelete(request, response);
		} else if (command.endsWith("/answerform.do")) {
			doAnswerForm(request, response);
		} else if (command.endsWith("/answerres.do")) {
			doAnswerRes(request, response);
		}
		// FAQ 페이지로 이동
		else if (command.endsWith("/faqpage.do")) {
			doFaqPage(request, response);
		}
		// error 페이지로 이동
		else {
			doError(request, response);
		}
	}

	private void doQnaList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<QNA_BOARD> list = biz.selectList();
		request.setAttribute("list", list);
		dispatch("/views/qna/qnalist.jsp", request, response);

	}

	private void doQnaDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int QNA_BOARD_NO = Integer.parseInt(request.getParameter("QNA_BOARD_NO"));
		QNA_BOARD QNA_BOARD = biz.selectOne(QNA_BOARD_NO);
		request.setAttribute("QNA_BOARD", QNA_BOARD);
		dispatch("/views/qna/qnadetail.jsp", request, response);
	}

	private void doQnaWriteForm(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		dispatch("/views/qna/qnawriteform.jsp", request, response);
	}

	private void doQnaWriteRes(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		String QNA_WRITER = request.getParameter("QNA_WRITER");
		String QNA_TITLE = request.getParameter("QNA_TITLE");
		String QNA_CONTENT = request.getParameter("QNA_CONTENT");
		QNA_BOARD QNA_BOARD = new QNA_BOARD(QNA_WRITER, QNA_TITLE, QNA_CONTENT);

		int res = biz.insert(QNA_BOARD);
		if (res > 0) {
			jsResponse("글 작성 성공", "/DEVCA/qnapage/qnalist.do", response);
		} else {
			jsResponse("글 작성 실패", "/DEVCA/qnapage/qnawriteform.do", response);
		}
	}

	private void doQnaUpdateForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int QNA_BOARD_NO = Integer.parseInt(request.getParameter("QNA_BOARD_NO"));
		QNA_BOARD QNA_BOARD = biz.selectOne(QNA_BOARD_NO);
		request.setAttribute("QNA_BOARD", QNA_BOARD);
		dispatch("/views/qna/qnaupdateform.jsp", request, response);
	}

	private void doQnaUpdateRes(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		int QNA_BOARD_NO = Integer.parseInt(request.getParameter("QNA_BOARD_NO"));
		String QNA_TITLE = request.getParameter("QNA_TITLE");
		String QNA_CONTENT = request.getParameter("QNA_CONTENT");
		QNA_BOARD QNA_BOARD = new QNA_BOARD(QNA_BOARD_NO, QNA_TITLE, QNA_CONTENT);

		int res = biz.update(QNA_BOARD);
		if (res > 0) {
			jsResponse("글 수정 성공", "/DEVCA/qnapage/qnadetail.do?QNA_BOARD_NO=" + QNA_BOARD_NO, response);
		} else {
			jsResponse("글 수정 실패", "/DEVCA/qnapage/qnaupdateform.do?QNA_BOARD_NO=" + QNA_BOARD_NO, response);
		}
	}

	private void doQnaDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		int QNA_BOARD_NO = Integer.parseInt(request.getParameter("QNA_BOARD_NO"));

		int res = biz.delete(QNA_BOARD_NO);
		if (res > 0) {
			jsResponse("글 삭제 성공", "/DEVCA/qnapage/qnalist.do", response);
		} else {
			jsResponse("글 삭제 실패", "/DEVCA/qnapage/qnadetail.do?QNA_BOARD_NO=" + QNA_BOARD_NO, response);
		}
	}

	private void doAnswerForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int QNA_BOARD_NO = Integer.parseInt(request.getParameter("QNA_BOARD_NO"));
		QNA_BOARD QNA_BOARD = biz.selectOne(QNA_BOARD_NO);
		request.setAttribute("QNA_BOARD", QNA_BOARD);
		dispatch("/views/qna/answerform.jsp", request, response);
	}

	private void doAnswerRes(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		int parentboardno = Integer.parseInt(request.getParameter("parentboardno"));
		String QNA_WRITER = request.getParameter("QNA_WRITER");
		String QNA_TITLE = request.getParameter("QNA_TITLE");
		String QNA_CONTENT = request.getParameter("QNA_CONTENT");
		QNA_BOARD QNA_BOARD = new QNA_BOARD();
		QNA_BOARD.setQNA_BOARD_NO(parentboardno);
		QNA_BOARD.setQNA_WRITER(QNA_WRITER);
		QNA_BOARD.setQNA_TITLE(QNA_TITLE);
		QNA_BOARD.setQNA_CONTENT(QNA_CONTENT);

		int res = biz.answerProc(QNA_BOARD);

		if (res > 0) {
			jsResponse("답변 작성 성공", "/DEVCA/qnapage/qnalist.do", response);
			jsResponse("답변 작성 실패", "/DEVCA/qnapage/answerform.do?QNA_BOARD_NO=" + parentboardno, response);
		}
	}

	private void doFaqPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		dispatch("/views/qna/faqpage.jsp", request, response);
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
