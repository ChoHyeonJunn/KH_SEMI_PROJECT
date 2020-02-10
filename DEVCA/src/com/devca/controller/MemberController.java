package com.devca.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.devca.model.biz.member.MemberBiz;
import com.devca.model.biz.member.MemberBizImpl;
import com.devca.model.dto.KAKAO_MEMBER;
import com.devca.model.dto.MEMBER;

@WebServlet(//
		name = "member", // Controller Mapping name
		//
		urlPatterns = { //
				"joinpage.do", // 회원가입 페이지로 이동
				"join.do", // 회원가입 수행
				"loginpage.do", // 로그인 페이지로 이동
				"login.do", // 로그인 수행
				"logout.do", // 로그아웃 수행
				"profilepage.do", // 프로필 페이지로 이동
				"snsjoin.do", })
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	HttpSession session;
	MemberBiz biz = new MemberBizImpl();

	public MemberController() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// command에 따른 로직 처리

		String command = request.getRequestURI();
		System.out.println("<" + command + ">");

		// 회원가입 창으로 이동
		if (command.endsWith("/joinpage.do")) {
			doJoinPage(request, response);
		}

		// 회원가입 요청 처리
		else if (command.endsWith("/join.do")) {
			doJoin(request, response);
		}

		// SNS 회원가입 요청처리
		else if (command.endsWith("/snsjoin.do")) {
			doSNSJoin(request, response);
		}

		// 로그인 페이지로 이동
		else if (command.endsWith("/loginpage.do")) {
			doLoginPage(request, response);
		}

		// 로그인 요청 처리
		else if (command.endsWith("/login.do")) {
			doLogin(request, response);
		}

		// SNS 로 가입된 이메일이 존재하는지 체크
		else if (command.endsWith("/snslogincheck.do")) {
			doSnsLoginCheck(request, response);
		}

		// 로그아웃 요청 처리
		else if (command.endsWith("/logout.do")) {
			doLogout(request, response);
		}

		// 프로필 페이지로 이동
		else if (command.endsWith("/profilepage.do")) {
			doProfilePage(request, response);
		}

		// 에러 처리
		else {
			doError(request, response);
		}
		// ,,,,,
	}

	// 회원가입 페이지
	private void doJoinPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/user/joinpage.jsp", request, response);
	}

	// 회원가입
	private void doJoin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MEMBER member = new MEMBER();

		String MEMBER_NAME = request.getParameter("MEMBER_NAME");
		String MEMBER_EMAIL = request.getParameter("MEMBER_EMAIL");
		String MEMBER_PW = request.getParameter("MEMBER_PW");
		String MEMBER_PHONE = request.getParameter("MEMBER_PHONE");

		member.setMEMBER_NAME(MEMBER_NAME);
		member.setMEMBER_EMAIL(MEMBER_EMAIL);
		member.setMEMBER_PW(MEMBER_PW);
		member.setMEMBER_PHONE(MEMBER_PHONE);

		int res = biz.memberJoin(member);
		if (res > 0) {
			jsResponse("회원가입 성공", "/DEVCA/member/loginpage.do", response);
		} else {
			jsResponse("회원가입 실패", "/DEVCA/member/joinpage.do", response);
		}
	}

	// SNS 회원가입
	private void doSNSJoin(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String snsType = request.getParameter("snsType");

		String MEMBER_NAME = request.getParameter("MEMBER_NAME");
		String MEMBER_EMAIL = request.getParameter("MEMBER_EMAIL");
		String MEMBER_PHONE = request.getParameter("MEMBER_PHONE");

		String SNS_ID = request.getParameter("SNS_ID");
		String SNS_NICKNAME = request.getParameter("SNS_NICKNAME");
		String access_token = request.getParameter("access_token");

		if (snsType.equals("KAKAO")) {

			KAKAO_MEMBER kakao_member = new KAKAO_MEMBER();

			kakao_member.setMEMBER_NAME(MEMBER_NAME);
			kakao_member.setMEMBER_EMAIL(MEMBER_EMAIL);
			kakao_member.setMEMBER_PHONE(MEMBER_PHONE);

			kakao_member.setKAKAO_ID(SNS_ID);
			kakao_member.setKAKAO_NICKNAME(SNS_NICKNAME);

			int res = biz.kakaoJoin(kakao_member);

			if (res > 0) {
				// test 회원가입 후 바로 로그인
				session = request.getSession();
				session.setAttribute("loginKakao", kakao_member);
				session.setAttribute("access_token", access_token);
				jsResponse("KAKAO 회원가입 성공", "/DEVCA/main/mainpage.do", response);
			} else {
				jsResponse("KAKAO 회원가입 실패", "/DEVCA/member/joinpage.do", response);
			}
		}
		if (snsType == "NAVER") {

		}
	}

	// 로그인 페이지
	private void doLoginPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/user/loginpage.jsp", request, response);
	}

	// 로그인
	private void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MEMBER member = new MEMBER();

		String MEMBER_EMAIL = request.getParameter("MEMBER_EMAIL");
		String MEMBER_PW = request.getParameter("MEMBER_PW");

		member.setMEMBER_EMAIL(MEMBER_EMAIL);
		member.setMEMBER_PW(MEMBER_PW);

		MEMBER loginMember = biz.memberLogin(member);

		if (loginMember != null) {
			session = request.getSession();
			session.setAttribute("loginMember", loginMember);
			jsResponse("로그인 성공", "/DEVCA/main/mainpage.do", response);
		} else {
			jsResponse("로그인 실패", "/DEVCA/member/loginpage.do", response);
		}
	}

	// SNS 로 가입된 이메일이 존재하는지 체크
	private void doSnsLoginCheck(HttpServletRequest request, HttpServletResponse response) {
		
	}

	// 로그아웃
	private void doLogout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().invalidate();
		jsResponse("로그아웃", "/DEVCA/main/mainpage.do", response);
	}

	// 프로필 페이지
	private void doProfilePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/user/profilepage.jsp", request, response);
	}

	// 에러 페이지
	private void doError(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("error.jsp", request, response);
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
