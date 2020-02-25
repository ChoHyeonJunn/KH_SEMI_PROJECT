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

import com.devca.model.biz.member.MemberBiz;
import com.devca.model.biz.member.MemberBizImpl;
import com.devca.model.biz.study.StudyBiz;
import com.devca.model.biz.study.StudyBizImpl;
import com.devca.model.dto.member.KAKAO_MEMBER;
import com.devca.model.dto.member.MEMBER;
import com.devca.model.dto.member.MEMBER_PROFILE;
import com.devca.model.dto.member.NAVER_MEMBER;
import com.devca.model.dto.study.APPLY_STUDY;
import com.devca.model.dto.study.STUDY;

@WebServlet(//
		name = "study", // Controller Mapping name
		//
		urlPatterns = { //
				"studypage.do", // study 페이지로 이동
		})
public class StudyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	HttpSession session;
	StudyBiz biz = new StudyBizImpl();
	MemberBiz memberBiz = new MemberBizImpl();

	public StudyController() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("<" + command + ">");

		/*
		 * 스터디 기본 기능
		 */
		if (command.endsWith("/studylistpage.do")) {
			doStudyPage(request, response);// STUDY 페이지로 이동
		} else if (command.endsWith("/studydetailpage.do")) {
			doStudyDetail(request, response);// STUDY 디테일로 이동
		} else if (command.endsWith("/studywritepage.do")) {
			doStudyWritePage(request, response);// STUDY 글쓰기로 이동
		} else if (command.endsWith("/studywrite.do")) {
			doStudyWrite(request, response);// STUDY 글쓰기
		} else if (command.endsWith("/studyupdatepage.do")) {
			doStudyUpdatePage(request, response);// STUDY 글 업데이트
		} else if (command.endsWith("/studyupdate.do")) {
			doStudyUpdate(request, response);// STUDY 글 업데이트
		} else if (command.endsWith("/studydelete.do")) {
			doStudyDelete(request, response);// STUDY 글 삭제
		}

		/*
		 * 스터디 신청 관련
		 */
		else if (command.endsWith("/applyStudy.do")) {
			doApplyStudy(request, response);// STUDY 글 삭제
		}

		/*
		 * error 처리 페이지
		 */
		else {
			doError(request, response);// error 페이지로 이동
		}
	}

	// STUDY 페이지로 이동
	private void doStudyPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<STUDY> studyList = biz.selectStudyList();

		session = request.getSession();
		int MEMBER_CODE = 0;
		if (session.getAttribute("loginMember") != null) {
			MEMBER_CODE = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			MEMBER_CODE = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			MEMBER_CODE = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}

		MEMBER_PROFILE member = memberBiz.selectMemberProfile(MEMBER_CODE);

		request.setAttribute("member", member);
		request.setAttribute("studyList", studyList);

		dispatch("/views/study/studylist.jsp", request, response);
	}

	// STUDY 디테일로 이동
	private void doStudyDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int STUDY_CODE = Integer.parseInt(request.getParameter("STUDY_CODE"));

		STUDY study = biz.selectStudyDetail(STUDY_CODE);
		request.setAttribute("study", study);

		dispatch("/views/study/studydetail.jsp", request, response);
	}

	// STUDY 글쓰기로 이동
	private void doStudyWritePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		int MEMBER_CODE = 0;
		if (session.getAttribute("loginMember") != null) {
			MEMBER_CODE = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			MEMBER_CODE = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			MEMBER_CODE = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}

		MEMBER_PROFILE member = memberBiz.selectMemberProfile(MEMBER_CODE);

		request.setAttribute("member", member);

		dispatch("/views/study/studywrite.jsp", request, response);
	}

	// STUDY 글쓰기
	private void doStudyWrite(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		String STUDY_TITLE = request.getParameter("STUDY_TITLE");
		String STUDY_CONTENT = request.getParameter("STUDY_CONTENT");
		String STUDY_LATITUDE = request.getParameter("STUDY_LATITUDE");
		String STUDY_LOGITUDE = request.getParameter("STUDY_LOGITUDE");
		STUDY study = new STUDY();

		study.setMEMBER_CODE(MEMBER_CODE);
		study.setSTUDY_TITLE(STUDY_TITLE);
		study.setSTUDY_CONTENT(STUDY_CONTENT);

		study.setSTUDY_LATITUDE(STUDY_LATITUDE);
		study.setSTUDY_LOGITUDE(STUDY_LOGITUDE);
		study.setSTUDY_ADDRESS("");

		int res = biz.studyWrite(study);

		if (res > 0) {
			jsResponse("스터디 등록 성공", "/DEVCA/study/studylistpage.do", response);
		} else {
			jsResponse("스터디 등록 실패", "/DEVCA/study/studywritepage.do", response);
		}
	}

	// STUDY 글 업데이트 페이지로 이동
	private void doStudyUpdatePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int STUDY_CODE = Integer.parseInt(request.getParameter("STUDY_CODE"));

		STUDY study = biz.selectStudyDetail(STUDY_CODE);
		request.setAttribute("study", study);
		dispatch("/views/study/studyupdate.jsp", request, response);
	}

	// STUDY 글 업데이트
	private void doStudyUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int STUDY_CODE = Integer.parseInt(request.getParameter("STUDY_CODE"));
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		String STUDY_TITLE = request.getParameter("STUDY_TITLE");
		String STUDY_CONTENT = request.getParameter("STUDY_CONTENT");

		STUDY study = new STUDY();

		study.setSTUDY_CODE(STUDY_CODE);
		study.setMEMBER_CODE(MEMBER_CODE);
		study.setSTUDY_TITLE(STUDY_TITLE);
		study.setSTUDY_CONTENT(STUDY_CONTENT);

		study.setSTUDY_LATITUDE("");
		study.setSTUDY_LOGITUDE("");
		study.setSTUDY_ADDRESS("");

		int res = biz.studyUpdate(study);

		if (res > 0) {
			jsResponse("스터디 업데이트 성공", "/DEVCA/study/studylistpage.do", response);
		} else {
			jsResponse("스터디 업데이트 실패", "/DEVCA/study/studywritepage.do", response);
		}
	}

	// STUDY 글 삭제
	private void doStudyDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int STUDY_CODE = Integer.parseInt(request.getParameter("STUDY_CODE"));
		int res = biz.studyDelete(STUDY_CODE);

		if (res > 0) {
			jsResponse("스터디 삭제 성공", "/DEVCA/study/studylistpage.do", response);
		} else {
			jsResponse("스터디 삭제 실패", "/DEVCA/study/studywritepage.do", response);
		}
	}

	/*
	 * 스터디 신청 관련
	 */

	// 스터디 신청 요청
	private void doApplyStudy(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		int STUDY_CODE = Integer.parseInt(request.getParameter("STUDY_CODE"));
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		APPLY_STUDY apply_study = new APPLY_STUDY();
		apply_study.setSTUDY_CODE(STUDY_CODE);
		apply_study.setMEMBER_CODE(MEMBER_CODE);
		apply_study.setAPPLY_STUDY_VERIFY("");

		int res = 0;// biz.applyStudy(apply_study);

		STUDY study = biz.selectStudyDetail(STUDY_CODE);
		request.setAttribute("study", study);
		
		dispatch("/views/study/studydetail.jsp", request, response);
	}

	/*
	 * 
	 */
	// error 페이지로 이동
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
