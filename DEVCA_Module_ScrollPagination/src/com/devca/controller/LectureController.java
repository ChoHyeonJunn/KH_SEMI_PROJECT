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

import com.devca.model.biz.lecture.LectureBiz;
import com.devca.model.biz.lecture.LectureBizImpl;
import com.devca.model.dto.lecture.LECTURE;
import com.google.gson.Gson;

@WebServlet(//
		name = "lecture", // Controller Mapping name
		//
		urlPatterns = { //
				"lecturelistpage.do", // 강의 리스트 페이지로 이동
		})
public class LectureController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	LectureBiz biz = new LectureBizImpl();

	public LectureController() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String command = request.getRequestURI();
		System.out.println("<" + command + ">");

		/* 강의 관련 요청들 */
		if (command.endsWith("/lecturelistpage.do")) {
			doLectureListPage(request, response); // 강의 리스트 페이지로 이동
		} else if (command.endsWith("/lecturelistajax.do")) {
			doLectureListAjax(request, response); // 강의 리스트 가져오기 ajax
		}

		/* 에러페이지로 이동 */
		else {
			doError(request, response);
		}
	}

	/*
	 * 강의 관련 요청들
	 */

	// 강의 리스트 페이지로 이동
	private void doLectureListPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String search = "";
		if (request.getParameter("search") != null)
			search = request.getParameter("search");

		request.setAttribute("search", search);
		dispatch("/views/lecture/lecturelist.jsp", request, response);
	}

	// 강의 리스트 가져오기 ajax
	private void doLectureListAjax(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println("Pagination Number : " + no);
		List<LECTURE> lectureList = biz.selectLectureList(no);

		Gson gson = new Gson();
		String jsonList = gson.toJson(lectureList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 에러 페이지로 이동
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
