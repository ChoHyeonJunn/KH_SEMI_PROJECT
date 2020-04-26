package com.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(//
		name = "member", // Controller Mapping name
		//
		urlPatterns = { //
				"loginsns.do", // SNS 로 로그인
		//////////
		})
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	HttpSession session;

	public MemberController() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("<" + command + ">");
		/*
		 * 로그인 관련 요청
		 */

		if (command.endsWith("/loginpage.do")) {
			doLoginPage(request, response); // SNS 로 로그인
		} else if (command.endsWith("/loginsns.do")) {
			doLoginSns(request, response); // SNS 로 로그인
		}

		/*
		 * 기타 요청
		 */
		else {
			doError(request, response); // 에러 처리
		}
	}

	private void doLoginPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/snslogin.jsp", request, response);
	}

	// KAKAO SNS 로 로그인
	private void doLoginSns(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String snsType = request.getParameter("snsType");
		if (snsType.equals("KAKAO")) {

			String nickname = request.getParameter("nickname");
			String kaccount_email = request.getParameter("account_email");
			String SNS_ID = request.getParameter("SNS_ID");
			String access_token = request.getParameter("access_token");

			System.out.println(snsType + "로그인 : \n" + " nickname : " + nickname + "\n account_email : " + kaccount_email
					+ "\n SNS_ID : " + SNS_ID + "\n access_token : " + access_token);

			jsResponse("eclipse console 창에서 정보 확인", "/DEVCA_SnsLogin/member/loginpage.do", response);
		} else if (snsType.equals("NAVER")) {

			String nickname = request.getParameter("nickname");
			String kaccount_email = request.getParameter("account_email");
			String SNS_ID = request.getParameter("SNS_ID");

			System.out.println(snsType + "로그인 : \n" + " nickname : " + nickname + "\n account_email : " + kaccount_email
					+ "\n SNS_ID : " + SNS_ID);

			jsResponse("eclipse console 창에서 정보 확인", "/DEVCA_SnsLogin/member/loginpage.do", response);
		}

	}

	// 에러 페이지
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