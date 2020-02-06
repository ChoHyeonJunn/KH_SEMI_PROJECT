package com.devca.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { 
		"", // 요청의 내용을 간단히 요약
		"", // 요청의 내용을 간단히 요약
})
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BoardController() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response) {
		// command에 따른 로직 처리

		String command = request.getRequestURI();
		System.out.println("<" + command + ">");

		if (command.endsWith("")) {
			doBoardTest(request, response);
		} else if (command.endsWith("")) {

		} 
		//,,,,,
	}

	private void doBoardTest(HttpServletRequest request, HttpServletResponse response) {
		// biz 호출을 통한 로직처리 및 dispatch(), jsResponse() 를 이용한 페이지 전환
	}

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

		getRequest(request, response);	// 모든 요청은 getRequest() 메서드에서 처리
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		getRequest(request, response);	// 모든 요청은 getRequest() 메서드에서 처리
	}

}
