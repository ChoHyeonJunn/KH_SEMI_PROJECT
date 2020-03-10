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

import com.devca.model.biz.protfolio.ActionBiz;
import com.devca.model.biz.protfolio.ActionBizImpl;
import com.devca.model.biz.protfolio.CareerBiz;
import com.devca.model.biz.protfolio.CareerBizImpl;
import com.devca.model.biz.protfolio.CertificateBiz;
import com.devca.model.biz.protfolio.CertificateBizImpl;
import com.devca.model.biz.protfolio.LanguageBiz;
import com.devca.model.biz.protfolio.LanguageBizImpl;
import com.devca.model.biz.protfolio.ProjectBiz;
import com.devca.model.biz.protfolio.ProjectBizImpl;
import com.devca.model.biz.protfolio.SchoolBiz;
import com.devca.model.biz.protfolio.SchoolBizImpl;
import com.devca.model.biz.protfolio.SkillBiz;
import com.devca.model.biz.protfolio.SkillBizImpl;
import com.devca.model.biz.protfolio.SurveyBiz;
import com.devca.model.biz.protfolio.SurveyBizImpl;
import com.devca.model.biz.protfolio.WorkBiz;
import com.devca.model.biz.protfolio.WorkBizImpl;
import com.devca.model.dto.member.KAKAO_MEMBER;
import com.devca.model.dto.member.MEMBER;
import com.devca.model.dto.member.NAVER_MEMBER;
import com.devca.model.dto.member.SURVEY;
import com.devca.model.dto.profile.ACTION_DTO;
import com.devca.model.dto.profile.CAREER;
import com.devca.model.dto.profile.CERTIFICATE;
import com.devca.model.dto.profile.LANGUAGE;
import com.devca.model.dto.profile.PROJECT;
import com.devca.model.dto.profile.SCHOOL;
import com.devca.model.dto.profile.SKILL;
import com.devca.model.dto.profile.WORK;

@WebServlet(//
		name = "portfolio", // Controller Mapping name
		//
		urlPatterns = { //
				"portfoliopage.do", // 헤더 > 프로필버튼 입력 (프로필페이지 입장시 경력페이지 출력)
				"sideportfoliopage.do", // 프로젝트 페이지 > 경력 페이지
				"projectpage.do", // 경력 프로필 > 프로젝트 페이지
				"sideprojectpage.do", // 사이드바 > 프로젝트 페이지
				"skillpage.do", // 경력 > 주요 기술 페이지
				"sideskillpage.do", // 사이드바 > 주요 기술 페이지
				"sidelanguagepage.do", // 사이드바 > 외국어 페이지
				"languagepage.do", // 주요 기술 > 외국어 페이지
				"sideschoolpage.do", // 사이드 바 > 학력 페이지
				"schoolpage.do", // 외국어 > 학력 페이지
				"sideactionpage.do", // 사이드 바 > 활동 페이지
				"actionpage.do", // 학력 > 활동 페이지
				"sidecertificatepage.do", // 사이드 바 > 자격증 페이지
				"certificatepage.do", // 활동 > 자격증 페이지
				"sideworkpage.do", // 사이드 바 > 직종/연봉 페이지
				"workpage.do", // 자격증 > 직종/연봉 페이지
				"previewpage.do", // 직종/연봉 > 미리보기 페이지
				"sidepreviewpage.do", // 프로필 > 미리보기 페이지
				"surveypage.do", // 설문조사 결과 페이지

		})
public class PortfolioController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	HttpSession session;
	CareerBiz careerbiz = new CareerBizImpl();
	ProjectBiz projectbiz = new ProjectBizImpl();
	SkillBiz skillbiz = new SkillBizImpl();
	LanguageBiz languagebiz = new LanguageBizImpl();
	SchoolBiz schoolbiz = new SchoolBizImpl();
	ActionBiz actionbiz = new ActionBizImpl();
	CertificateBiz certificatebiz = new CertificateBizImpl();
	WorkBiz workbiz = new WorkBizImpl();
	SurveyBiz surveybiz = new SurveyBizImpl();
	
	public PortfolioController() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// command에 따른 로직 처리

		String command = request.getRequestURI();
		System.out.println("<" + command + ">");

		if (command.endsWith("/portfoliopage.do")) {
			doProfilePage(request, response);// 프로필 페이지로 이동
		} else if (command.endsWith("/sideportfoliopage.do")) {
			doSideProfilePage(request, response);
		} else if (command.endsWith("/projectpage.do")) {
			doProjectPage(request, response);// 경력페이지 > 프로젝트
		} else if (command.endsWith("/sideprojectpage.do")) {
			doSideProjectPage(request, response);// 포트폴리오 사이드바 > 프로젝트
		} else if (command.endsWith("/skillpage.do")) {
			doSkillPage(request, response);
		} else if (command.endsWith("/sideskillpage.do")) {
			doSideSkillPage(request, response);
		} else if (command.endsWith("/sidelanguagepage.do")) {
			doSideLanguagePage(request, response);
		} else if (command.endsWith("/languagepage.do")) {
			doLanguagePage(request, response);
		} else if (command.endsWith("/schoolpage.do")) {
			doSchoolPage(request, response);
		} else if (command.endsWith("/sideschoolpage.do")) {
			doSideSchoolPage(request, response);
		} else if (command.endsWith("/sideactionpage.do")) {
			doSideActionPage(request, response);
		} else if (command.endsWith("/actionpage.do")) {
			doActionPage(request, response);
		} else if (command.endsWith("/sidecertificatepage.do")) {
			doSideCertificatePage(request, response);
		} else if (command.endsWith("/certificatepage.do")) {
			doCertificatePage(request, response);
		} else if (command.endsWith("/sideworkpage.do")) {
			doSideWorkPage(request, response);
		} else if (command.endsWith("/workpage.do")) {
			doWorkPage(request, response);// 자격증 > 직종 /연봉
		} else if (command.endsWith("/previewpage.do")) {
			doPreviewPage(request, response);
		} else if (command.endsWith("/sidepreviewpage.do")) {
			doSidePreviewPage(request, response);
		} else if (command.endsWith("/surveypage.do")) {
			doSurveyPage(request, response);
		}
		// 에러 처리
		else {
			doError(request, response);
		}

	}

	private void doSidePreviewPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}

		List<CAREER> careerList = careerbiz.career_select(member_code);
		request.setAttribute("careerList", careerList);
		if(careerList.isEmpty()||careerList.get(0).getDAY_OF_ENTRY()!=null) {
			int career_year = 0;
			int year = 0;
			int month = 0;
			int career_month = 0;
			int[] careerdate = new int[2];
			
			for(int i =0; i< careerList.size();i++) {
				careerdate = careerbiz.career_date(member_code,careerList.get(i).getCAREER_SEQ());
				year = careerdate[0];
				month = careerdate[1];
				career_year = career_year + year;
				career_month = career_month + month;
				System.out.println("년수:"+career_year);
				System.out.println("개월수 :"+career_month);
				if(career_month >11) {
					career_year++;
					career_month = career_month - 12;
					System.out.println("개월 년으로 치환"+career_month);
				}
			}
		
		System.out.println("경력 년수 : "+career_year);
		System.out.println("경력 년수 : "+career_month);
		request.setAttribute("careerdate_year", career_year);
		request.setAttribute("careerdate_month", career_month);
		}
		
		List<PROJECT> project_List = projectbiz.project_select(member_code);
		request.setAttribute("projectList", project_List);
		List<SKILL> skillList = skillbiz.skill_select(member_code);
		request.setAttribute("skillList", skillList);
		List<LANGUAGE> languageList = languagebiz.language_select(member_code);
		request.setAttribute("languageList", languageList);
		List<SCHOOL> schoolList = schoolbiz.school_select(member_code);
		request.setAttribute("schoolList", schoolList);
		List<ACTION_DTO> actionList = actionbiz.action_select(member_code);
		request.setAttribute("actionList", actionList);
		List<CERTIFICATE> certificateList = certificatebiz.certificate_select(member_code);
		request.setAttribute("certificateList", certificateList);
		List<WORK> workList = workbiz.work_select(member_code);
		request.setAttribute("workList", workList);

		dispatch("/views/portfolio/preview.jsp", request, response);
	}

	private void doPreviewPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		int res = 0;
		int cnt = 0;
		// 직군 연봉 데이터 저장
		res = workbiz.work_delete(member_code);
		if(res > 0) {
			System.out.println("삭제완료");
		}
		res = 0;
		String[] work_count = request.getParameterValues("work_count");
		String[] work_name = request.getParameterValues("work_name");
		String[] income = request.getParameterValues("income");
		WORK work_dto = null;
		
		System.out.println(work_count.length);
		for(int i = 0; i < work_count.length; i++) {
			work_dto = new WORK(member_code,work_name[i],income[i]);
			
			res = workbiz.work_insert(work_dto);
			if(res > 0) {
				cnt++;
			}
			res = 0;
		}
		System.out.println("직군/연봉 데이터 저장중");
		// 직군 연봉 데이터 저장 종료
		if (cnt == work_count.length) {
			System.out.println("직군/연봉 데이터 저장성공");


			List<CAREER> careerList = careerbiz.career_select(member_code);
			request.setAttribute("careerList", careerList);
			if(careerList.isEmpty()||careerList.get(0).getDAY_OF_ENTRY()!=null) {
				int career_year = 0;
				int year = 0;
				int month = 0;
				int career_month = 0;
				int[] careerdate = new int[2];
				
				for(int i =0; i< careerList.size();i++) {
					careerdate = careerbiz.career_date(member_code,careerList.get(i).getCAREER_SEQ());
					year = careerdate[0];
					month = careerdate[1];
					career_year = career_year + year;
					career_month = career_month + month;
					System.out.println("년수:"+career_year);
					System.out.println("개월수 :"+career_month);
					if(career_month >11) {
						career_year++;
						career_month = career_month - 12;
						System.out.println("개월 년으로 치환"+career_month);
					}
				}
			
			System.out.println("경력 년수 : "+career_year);
			System.out.println("경력 년수 : "+career_month);
			request.setAttribute("careerdate_year", career_year);
			request.setAttribute("careerdate_month", career_month);
			}
			
			List<PROJECT> project_List = projectbiz.project_select(member_code);
			request.setAttribute("projectList", project_List);
			List<SKILL> skillList = skillbiz.skill_select(member_code);
			request.setAttribute("skillList", skillList);
			List<LANGUAGE> languageList = languagebiz.language_select(member_code);
			request.setAttribute("languageList", languageList);
			List<SCHOOL> schoolList = schoolbiz.school_select(member_code);
			request.setAttribute("schoolList", schoolList);
			List<ACTION_DTO> actionList = actionbiz.action_select(member_code);
			request.setAttribute("actionList", actionList);
			List<CERTIFICATE> certificateList = certificatebiz.certificate_select(member_code);
			request.setAttribute("certificateList", certificateList);
			List<WORK> workList = workbiz.work_select(member_code);
			request.setAttribute("workList", workList);

			dispatch("/views/portfolio/preview.jsp", request, response);
		} else {
			jsResponse("잘못입력", "/DEVCA/portfolio/sideworkpage.do?member_code=" + member_code, response);
		}
	}

	// 사이드바 > 직종/연봉페이지
	private void doSideWorkPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		// 뉴비 진입시 테이블 생성용
		int work_count = workbiz.work_count(member_code);
		// 경력 번호로 상세 항목 테이블 참조
		if (work_count == 0) {
			workbiz.work_insert_new(member_code);
		}
		// 뉴비 진입시 테이블 생성용

		List<WORK> workList = workbiz.work_select(member_code);
		request.setAttribute("workList", workList);
		dispatch("/views/portfolio/workpage.jsp", request, response);

	}

	// 자격증 > 직종/연봉페이지
	private void doWorkPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		int res = 0;
		int cnt = 0;
		res = certificatebiz.certificate_delete(member_code);
		if(res > 0) {
			System.out.println("자격증 테이블 삭제 성공");
		}
		// 자격증 데이터 > DB 저장 시작
		String[] certificate_count = request.getParameterValues("certificate_count");
		String[] certificate_name = request.getParameterValues("certificate_name");
		String[] certificate_start_date = request.getParameterValues("certificate_start_date");
		String[] certificate_link = request.getParameterValues("certificate_link");
		String[] certificate_ex_text = request.getParameterValues("certificate_ex_text");
		CERTIFICATE certificate = null;
		for(int i = 0; i < certificate_count.length; i++) {
			certificate = new CERTIFICATE(member_code, certificate_name[i],
					certificate_start_date[i], certificate_link[i], certificate_ex_text[i]);
			
			res = certificatebiz.certificate_insert(certificate);
			
			if(res > 0) {
				cnt++;
			}
			res = 0;
		}
		
		// 자격증 데이터 > DB 저장 종료
		if (cnt == certificate_count.length) {
			// 뉴비 진입시 테이블 생성용
			int work_count = workbiz.work_count(member_code);
			// 경력 번호로 상세 항목 테이블 참조
			if (work_count == 0) {
				workbiz.work_insert_new(member_code);
			}
			// 뉴비 진입시 테이블 생성용
			List<WORK> workList = workbiz.work_select(member_code);
			request.setAttribute("workList", workList);
			dispatch("/views/portfolio/workpage.jsp", request, response);
		} else {
			jsResponse("잘못입력", "/DEVCA/portfolio/sidecertificatepage.do?member_code=" + member_code, response);
		}
	}

	// 사이드바 > 자격증 페이지
	private void doSideCertificatePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		// 뉴비 진입시 테이블 생성용
		int certificate_count = certificatebiz.certificate_count(member_code);
		// 경력 번호로 상세 항목 테이블 참조
		if (certificate_count == 0) {
			certificatebiz.certificate_insert_new(member_code);
		}
		// 뉴비 진입시 테이블 생성용
		List<CERTIFICATE> certificateList = certificatebiz.certificate_select(member_code);
			String[] date = new String[certificateList.size()];
			for(int i =0; i < certificateList.size();i++) {
				System.out.println(certificateList.get(i).getCERTIFICATE_DATE());
				if(certificateList.get(i).getCERTIFICATE_DATE()!=null) {
				date[i] = certificateList.get(i).getCERTIFICATE_DATE().substring(0, 10);
				System.out.println("시분초 제거"+date[i]);
				certificateList.get(i).setCERTIFICATE_DATE(date[i]);
				}
			}
		request.setAttribute("certificateList", certificateList);
		dispatch("/views/portfolio/certificatepage.jsp", request, response);
	}

	// 활동 > 자격증 페이지
	private void doCertificatePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		int res = 0;
		int cnt = 0;
		actionbiz.action_delete(member_code);
		// 활동 데이터 > DB 저장 시작
		String[] action_count = request.getParameterValues("action_count"); // 테이블 생성 갯수
		String[] action_name = request.getParameterValues("action_name");
		String[] action_start_date = request.getParameterValues("action_start_date");
		String[] action_end_date = request.getParameterValues("action_end_date");
		String[] action_link = request.getParameterValues("action_link");
		String[] action_ex_text = request.getParameterValues("action_ex_text");
		ACTION_DTO action = null;
		for(int i = 0; i < action_count.length; i++) {
			action = new ACTION_DTO(member_code,action_name[i],action_start_date[i],action_end_date[i],action_link[i],action_ex_text[i]);
			res = actionbiz.action_insert(action);
			if(res > 0) {
				cnt++;
			}
			res = 0;
		}
		// 활동 데이터 > DB 저장 종료
		if (cnt == action_count.length) {
			System.out.println("활동 데이터 저장 성공");
			// 뉴비 진입시 테이블 생성용
			int certificate_count = certificatebiz.certificate_count(member_code);
			// 경력 번호로 상세 항목 테이블 참조
			if (certificate_count == 0) {
				certificatebiz.certificate_insert_new(member_code);
			}
			// 뉴비 진입시 테이블 생성용
			List<CERTIFICATE> certificateList = certificatebiz.certificate_select(member_code);
			String[] date = new String[certificateList.size()];
			
			for(int i =0; i < certificateList.size();i++) {
				System.out.println(certificateList.get(i).getCERTIFICATE_DATE());
				if(certificateList.get(i).getCERTIFICATE_DATE()!=null) {
				date[i] = certificateList.get(i).getCERTIFICATE_DATE().substring(0, 10);
				System.out.println("시분초 제거"+date[i]);
				certificateList.get(i).setCERTIFICATE_DATE(date[i]);
				}
			}
			request.setAttribute("certificateList", certificateList);
			dispatch("/views/portfolio/certificatepage.jsp", request, response);
		} else {
			jsResponse("잘못입력", "/DEVCA/portfolio/sideactionpage.do?member_code=" + member_code, response);
		}
	}

	// 사이드바 > 활동 페이지
	private void doSideActionPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		// 뉴비 진입시 테이블 생성용
		int action_count = actionbiz.action_count(member_code);
		// 경력 번호로 상세 항목 테이블 참조
		if (action_count == 0) {
			actionbiz.action_insert_new(member_code);
		}
		// 뉴비 진입시 테이블 생성용

		List<ACTION_DTO> actionList = actionbiz.action_select(member_code);
		String[] start_dates = new String[actionList.size()];
		String[] end_dates = new String[actionList.size()];
		for(int i =0; i < actionList.size();i++) {
			System.out.println(actionList.get(i).getACTION_START_DATE());
			System.out.println(actionList.get(i).getACTION_END_DATE());
			if(actionList.get(i).getACTION_START_DATE()!=null) {
				start_dates[i] = actionList.get(i).getACTION_START_DATE().substring(0, 10);
				System.out.println("시분초 제거"+start_dates[i]);
				actionList.get(i).setACTION_START_DATE(start_dates[i]);
			}
			if(actionList.get(i).getACTION_END_DATE()!=null) {
				end_dates[i] = actionList.get(i).getACTION_END_DATE().substring(0, 10);
				System.out.println("시분초 제거"+end_dates[i]);
				actionList.get(i).setACTION_END_DATE(end_dates[i]);
			}
		}
		request.setAttribute("actionList", actionList);

		dispatch("/views/portfolio/actionpage.jsp", request, response);
	}

	// 학력 > 활동 페이지
	private void doActionPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		int res = 0;
		SCHOOL school = null;
		// 학력 데이터 > DB저장
		int school_seq = Integer.parseInt(request.getParameter("school_seq"));
		String schoolname = request.getParameter("schoolname");
		String major = request.getParameter("major");
		String degree = request.getParameter("degree");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		double mycredit = 0;
		double maxcredit = 0;
		if(request.getParameter("mycredit") != "") {
			mycredit = Double.parseDouble(request.getParameter("mycredit"));
		}
		if(request.getParameter("maxcredit") != "") {
			maxcredit = Double.parseDouble(request.getParameter("maxcredit"));
		}
		String othertext = request.getParameter("othertext");

		school = new SCHOOL(member_code, school_seq, schoolname, major, degree, start_date, end_date, mycredit,
				maxcredit, othertext);
		res = schoolbiz.school_update(school);
		if (res > 0) {
			// 학력 데이터 > DB 저장 종료

			// 뉴비 진입시 테이블 생성용
			int action_count = actionbiz.action_count(member_code);
			// 경력 번호로 상세 항목 테이블 참조
			if (action_count == 0) {
				actionbiz.action_insert_new(member_code);
			}
			// 뉴비 진입시 테이블 생성용

			List<ACTION_DTO> actionList = actionbiz.action_select(member_code);
			String[] start_dates = new String[actionList.size()];
			String[] end_dates = new String[actionList.size()];
			for(int i =0; i < actionList.size();i++) {
				System.out.println(actionList.get(i).getACTION_START_DATE());
				System.out.println(actionList.get(i).getACTION_END_DATE());
				if(actionList.get(i).getACTION_START_DATE()!=null) {
					start_dates[i] = actionList.get(i).getACTION_START_DATE().substring(0, 10);
					System.out.println("시분초 제거"+start_dates[i]);
					actionList.get(i).setACTION_START_DATE(start_dates[i]);
				}
				if(actionList.get(i).getACTION_END_DATE()!=null) {
					end_dates[i] = actionList.get(i).getACTION_END_DATE().substring(0, 10);
					System.out.println("시분초 제거"+end_dates[i]);
					actionList.get(i).setACTION_END_DATE(end_dates[i]);
				}
			}
			request.setAttribute("actionList", actionList);
			dispatch("/views/portfolio/actionpage.jsp", request, response);
		} else {
			jsResponse("잘못입력", "/DEVCA/portfolio/sideschoolpage.do?member_code=" + member_code, response);
		}
	}

	// 사이드바 > 학력 페이지
	private void doSideSchoolPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		// 뉴비 진입시 테이블 생성용
		int school_count = schoolbiz.school_count(member_code);
		// 경력 번호로 상세 항목 테이블 참조
		if (school_count == 0) {
			schoolbiz.school_insert_new(member_code);
		}
		// 뉴비 진입시 테이블 생성용
		List<SCHOOL> schoolList = schoolbiz.school_select(member_code);
		
		String[] start_dates = new String[schoolList.size()];
		String[] end_dates = new String[schoolList.size()];
		for(int i =0; i < schoolList.size();i++) {
			System.out.println(schoolList.get(i).getSCHOOL_OF_START());
			System.out.println(schoolList.get(i).getSCHOOL_OF_END());
			if(schoolList.get(i).getSCHOOL_OF_START()!=null) {
				start_dates[i] = schoolList.get(i).getSCHOOL_OF_START().substring(0, 10);
				System.out.println("시분초 제거"+start_dates[i]);
				schoolList.get(i).setSCHOOL_OF_START(start_dates[i]);
			}
			if(schoolList.get(i).getSCHOOL_OF_END()!=null) {
				end_dates[i] = schoolList.get(i).getSCHOOL_OF_END().substring(0, 10);
				System.out.println("시분초 제거"+end_dates[i]);
				schoolList.get(i).setSCHOOL_OF_END(end_dates[i]);
			}
		}
		request.setAttribute("schoolList", schoolList);
		dispatch("/views/portfolio/schoolpage.jsp", request, response);
	}

	// 외국어 > 학력 페이지
	private void doSchoolPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		int res = 0;
		int cnt = 0;
		res = languagebiz.language_delete(member_code);
		if(res > 0) {
			System.out.println("외국어테이블 데이터 삭제완료");
		}
		res = 0;
		String[] language_count = request.getParameterValues("language_count");
		String[] language_otherLanguage = request.getParameterValues("otherlanguage");
		String[] language = request.getParameterValues("otherselect");
		String[] language_name = request.getParameterValues("language_name");
		String[] language_grade = request.getParameterValues("language_grade");
		LANGUAGE lang = null;
		for(int i =0;i< language_count.length;i++) {
			if(language[i]==("other")) {
				lang = new LANGUAGE(member_code,language[i],language_otherLanguage[i],language_name[i],language_grade[i]);
				System.out.println("other:"+lang);
			}else {
				lang = new LANGUAGE(member_code,language[i],null,language_name[i],language_grade[i]);
				System.out.println("language:"+lang);
			}
			res = languagebiz.language_insert(lang);
			
			if(res > 0) {
				cnt++;
			}
			res = 0;
		}
		
		
		if (cnt == language_count.length) {

			// 뉴비 진입시 테이블 생성용
			int school_count = schoolbiz.school_count(member_code);
			// 경력 번호로 상세 항목 테이블 참조
			if (school_count == 0) {
				schoolbiz.school_insert_new(member_code);
			}
			// 뉴비 진입시 테이블 생성용
			List<SCHOOL> schoolList = schoolbiz.school_select(member_code);
			String[] start_dates = new String[schoolList.size()];
			String[] end_dates = new String[schoolList.size()];
			for(int i =0; i < schoolList.size();i++) {
				System.out.println(schoolList.get(i).getSCHOOL_OF_START());
				System.out.println(schoolList.get(i).getSCHOOL_OF_END());
				if(schoolList.get(i).getSCHOOL_OF_START()!=null) {
					start_dates[i] = schoolList.get(i).getSCHOOL_OF_START().substring(0, 10);
					System.out.println("시분초 제거"+start_dates[i]);
					schoolList.get(i).setSCHOOL_OF_START(start_dates[i]);
				}
				if(schoolList.get(i).getSCHOOL_OF_END()!=null) {
					end_dates[i] = schoolList.get(i).getSCHOOL_OF_END().substring(0, 10);
					System.out.println("시분초 제거"+end_dates[i]);
					schoolList.get(i).setSCHOOL_OF_END(end_dates[i]);
				}
			}
			request.setAttribute("schoolList", schoolList);

			dispatch("/views/portfolio/schoolpage.jsp", request, response);
		} else {
			jsResponse("잘못입력", "/DEVCA/protfolio/sidelanguagepage.do?member_code=" + member_code, response);
		}

	}

	// 사이드바 > 외국어 페이지
	private void doSideLanguagePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		int language_seq = 0;
		LANGUAGE language = null;
		// 외국어 테이블 정보 조회
		// 뉴비 진입시 테이블 생성용
		int language_count = languagebiz.language_count(member_code);
		// 경력 번호로 상세 항목 테이블 참조
		if (language_count == 0) {
			languagebiz.language_insert_new(member_code); // 경력 테이블 생성
		}
		// 뉴비 진입시 테이블 생성용
		List<LANGUAGE> languageList = languagebiz.language_select(member_code);
		
		request.setAttribute("languageList", languageList);

		dispatch("/views/portfolio/languagepage.jsp", request, response);
	}



	// 기술 > 외국어 페이지
	private void doLanguagePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 기술 테이블 insert
		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		skillbiz.skill_delete(member_code);
		int res = 0;
		int cnt = 0;
		SKILL skill_dto = null;
		String[] skill_name = request.getParameterValues("skill_name");
		if (skill_name != null) {
			for (int i = 0; i < skill_name.length; i++) {
				skill_dto = new SKILL();
				skill_dto.setSKILL_MEMBER_CODE(member_code);
				skill_dto.setSKILL(skill_name[i]);
				res = skillbiz.skill_insert(skill_dto);

				if (res > 0) {
					cnt++;
				}
				res = 0;
			}
			if (cnt == skill_name.length) {
				// 외국어 테이블 정보 조회
				// 뉴비 진입시 테이블 생성용
				int language_count = languagebiz.language_count(member_code);
				// 경력 번호로 상세 항목 테이블 참조
				if (language_count == 0) {
					languagebiz.language_insert_new(member_code); // 경력 테이블 생성
				}
				// 뉴비 진입시 테이블 생성용
				List<LANGUAGE> languageList = languagebiz.language_select(member_code);

				request.setAttribute("languageList", languageList);

				dispatch("/views/portfolio/languagepage.jsp", request, response);
			} else {
				jsResponse("저장실패", "/DEVCA/protfolio/sideskillpage.do?member_code=" + member_code, response);
			}
		} else {
			// 외국어 테이블 정보 조회
			// 뉴비 진입시 테이블 생성용
			int language_count = languagebiz.language_count(member_code);
			// 경력 번호로 상세 항목 테이블 참조
			if (language_count == 0) {
				languagebiz.language_insert_new(member_code); // 경력 테이블 생성
			}
			// 뉴비 진입시 테이블 생성용
			List<LANGUAGE> languageList = languagebiz.language_select(member_code);
			LANGUAGE language = languagebiz.language_select_seq(member_code);
			int language_seq = language.getLANGUAGE_SEQ();

			request.setAttribute("languageList", languageList);

			dispatch("/views/portfolio/languagepage.jsp", request, response);
		}
	}

	// 사이드바 > 기술 페이지
	private void doSideSkillPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		// 뉴비 진입시 테이블 생성용
		int skill_count = skillbiz.skill_count(member_code);
		if (skill_count == 0) {
			skillbiz.skill_insert_new(member_code); // 주요기술 테이블 생성
			System.out.println("주요기술 테이블 생성");
		}
		// 뉴비 진입시 테이블 생성용
		// 멤버코드로 스킬페이지 테이블 참조
		List<SKILL> skillList = skillbiz.skill_select(member_code);

		request.setAttribute("skillList", skillList);

		dispatch("/views/portfolio/skillpage.jsp", request, response);

	}

	// 프로젝트 > 주요 기술 페이지
	private void doSkillPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		int res = 0;
		int cnt = 0;
		System.out.println(member_code);
		res = projectbiz.project_delete(member_code);
		if(res > 0) {
			System.out.println("삭제성공");
		}
		String[] project_count = request.getParameterValues("project_count");
		String[] project_name = request.getParameterValues("project_name");
		String[] create_year_str = request.getParameterValues("create_year");
		int[] create_year= new int[project_count.length];
		for(int i = 0; i < project_count.length;i++) {
			create_year[i] = Integer.parseInt(create_year_str[i]);
			System.out.println("project_name"+project_name[i]);
			System.out.println("create_year"+create_year[i]);
		}
		
		String[] project_oneline_ex = request.getParameterValues("project_oneline_ex");
		String[] project_team = request.getParameterValues("project_team");
		String[] project_member_count = request.getParameterValues("project_member");
		String[] project_usestack = request.getParameterValues("project_usestack");
		String[] project_detail = request.getParameterValues("project_detail");
		String[] project_storage_link = request.getParameterValues("project_storage_link");
		String[] Website = request.getParameterValues("Website");
		String[] Android = request.getParameterValues("Android");
		String[] iOS = request.getParameterValues("iOS");
		int[] project_member = new int[project_count.length];
		for(int i = 0; i < project_count.length;i++) {
			if(project_member_count[i] == null && project_member_count[i] == "") {
				project_member[i] = 1;
			}else {
				project_member[i] = Integer.parseInt(project_member_count[i]);
			}
			System.out.println("oneline_ex"+project_oneline_ex[i]);
			System.out.println("team"+project_team[i]);
			System.out.println("**member"+project_count[i]);
			System.out.println("usestack"+project_usestack[i]);
			System.out.println("detail"+project_detail[i]);
			System.out.println("link"+project_storage_link[i]);
			System.out.println("web"+Website[i]);
			System.out.println("iOS"+iOS[i]);
			System.out.println("Android"+Android[i]);
		}
		
		PROJECT PROJECT_DTO = null;
		for(int i = 0; i < project_count.length;i++) {
			PROJECT_DTO = new PROJECT(member_code, project_name[i], create_year[i], project_oneline_ex[i],
					project_team[i], project_member[i], project_usestack[i], project_detail[i], project_storage_link[i], Website[i], Android[i],
					iOS[i]);
			
			res = projectbiz.project_insert(PROJECT_DTO);
			System.out.println("res :"+res);
			if(res >0 ) {
				cnt++;
				System.out.println("cnt :"+cnt);
			}
			res = 0;
		}
		if (cnt == project_count.length) {
			// 멤버코드로 스킬페이지 테이블 참조
			// 뉴비 진입시 테이블 생성용
			int skill_count = skillbiz.skill_count(member_code);
			if (skill_count == 0) {
				skillbiz.skill_insert_new(member_code); // 주요 기술 테이블 생성
				System.out.println("주요기술 테이블 생성");
			}
			// 뉴비 진입시 테이블 생성용
			List<SKILL> skillList = skillbiz.skill_select(member_code);
			request.setAttribute("skillList", skillList);

			dispatch("/views/portfolio/skillpage.jsp", request, response);
		} else {
			jsResponse("잘못입력", "/DEVCA/protfolio/sideprojectpage.do?member_code=" + member_code, response);
		}

	}

	// 경력 > 개인 프로젝트 페이지
	private void doProjectPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		int career_res = 0;
		int cnt = 0;
		
		careerbiz.career_delete(member_code);
		System.out.println("경력 삭제");
		String[] profile_count = request.getParameterValues("profile_count");
		// career_table 값 업데이트
		String[] COMPANY_NAME = request.getParameterValues("COMPANYNAME");
		String[] DUTY = request.getParameterValues("DUTY");
		String[] DAY_OF_ENTRY = request.getParameterValues("DAY_OF_ENTRY");
		String[] DATE_OF_DEPARTURE = request.getParameterValues("DATE_OF_DEPARTURE");
		String[] STACK = request.getParameterValues("STACK");
		String[] LINK = request.getParameterValues("LINK");
		String[] EXPLANATION = request.getParameterValues("EXPLANATION");
		String[] PERFORMANCE = request.getParameterValues("PERFORMANCE");
		String[] START_DATE = request.getParameterValues("START_DATE");
		String[] END_DATE = request.getParameterValues("END_DATE");
		String[] DETAIL_CONTEXT = request.getParameterValues("DETAIL_CONTEXT");
		CAREER CAREER_DTO = null;
		
		for(int i = 0; i< profile_count.length;i++) {
			CAREER_DTO = new CAREER(member_code, COMPANY_NAME[i], DUTY[i], DAY_OF_ENTRY[i], DATE_OF_DEPARTURE[i],
					STACK[i],PERFORMANCE[i],START_DATE[i],END_DATE[i],DETAIL_CONTEXT[i] ,LINK[i], EXPLANATION[i]);
			
			career_res = careerbiz.career_insert(CAREER_DTO);
			if (career_res > 0) {
				cnt++;
				System.out.println(cnt);
			}
			career_res = 0;
		}
		if (cnt == profile_count.length) {
			// 뉴비 진입시 테이블 생성용
			int project_count = projectbiz.project_count_row(member_code);
			if (project_count == 0) {
				projectbiz.project_insert_new(member_code); // 경력 테이블 생성
			}
			// 뉴비 진입시 테이블 생성용
			List<PROJECT> project_List = projectbiz.project_select(member_code);
			request.setAttribute("projectList", project_List);

			dispatch("/views/portfolio/projectpage.jsp", request, response);
		} else {
			doProfilePage(request, response);
		}

	}

	// 사이드바 > 개인 프로젝트 페이지
	private void doSideProjectPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}
		// 뉴비 진입시 테이블 생성용
		int project_count = projectbiz.project_count_row(member_code);
		if (project_count == 0) {
			projectbiz.project_insert_new(member_code); // 경력 테이블 생성
		}
		// 뉴비 진입시 테이블 생성용
		// 멤버코드로 경력페이지 테이블 참조
		List<PROJECT> projectList = projectbiz.project_select(member_code);

		request.setAttribute("projectList", projectList);

		dispatch("/views/portfolio/projectpage.jsp", request, response);

	}

	// 사이드바 > 경력 페이지
	private void doSideProfilePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}

		int count = careerbiz.career_count(member_code);
		if (count == 0) {
			careerbiz.career_insert_new(member_code); // 경력 테이블 생성
		}
		List<CAREER> careerList = careerbiz.career_select(member_code);
		String[] start_dates = new String[careerList.size()];
		String[] end_dates = new String[careerList.size()];
		String[] end_day = new String[careerList.size()];
		String[] entry_day = new String[careerList.size()];
		for(int i =0; i < careerList.size();i++) {
			System.out.println(careerList.get(i).getDAY_OF_ENTRY());
			System.out.println(careerList.get(i).getDATE_OF_DEPARTURE());
			System.out.println(careerList.get(i).getSTART_DATE());
			System.out.println(careerList.get(i).getEND_DATE());
			if(careerList.get(i).getDAY_OF_ENTRY()!=null) {
				entry_day[i] = careerList.get(i).getDAY_OF_ENTRY().substring(0, 10);
				System.out.println("시분초 제거"+entry_day[i]);
				careerList.get(i).setDAY_OF_ENTRY(entry_day[i]);
			}
			if(careerList.get(i).getDATE_OF_DEPARTURE()!=null) {
				end_day[i] = careerList.get(i).getDATE_OF_DEPARTURE().substring(0, 10);
				System.out.println("시분초 제거"+end_day[i]);
				careerList.get(i).setDATE_OF_DEPARTURE(end_day[i]);
			}
			if(careerList.get(i).getSTART_DATE()!=null) {
				start_dates[i] = careerList.get(i).getSTART_DATE().substring(0, 10);
				System.out.println("시분초 제거"+start_dates[i]);
				careerList.get(i).setSTART_DATE(start_dates[i]);
			}
			if(careerList.get(i).getEND_DATE()!=null) {
				end_dates[i] = careerList.get(i).getEND_DATE().substring(0, 10);
				System.out.println("시분초 제거"+end_dates[i]);
				careerList.get(i).setEND_DATE(end_dates[i]);
			}
		}
		request.setAttribute("careerList", careerList);

		dispatch("/views/portfolio/portfoliopage.jsp", request, response);
	}

	// 프로필 페이지 + 초기화면 경력페이지
	private void doProfilePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int member_code = 0;
		if (session.getAttribute("loginMember") != null) {
			member_code = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginKakao") != null) {
			member_code = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
		}
		if (session.getAttribute("loginNaver") != null) {
			member_code = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
		}

			// 뉴비 진입시 테이블 생성용
				int CAREER_COUNT = careerbiz.career_count(member_code);
				// 경력 번호로 상세 항목 테이블 참조
				if (CAREER_COUNT == 0) {
					careerbiz.career_insert_new(member_code); // 경력 테이블 생성
				}
			// 뉴비 진입시 테이블 생성용
		
		// 멤버코드로 경력페이지 테이블 참조
		List<CAREER> careerList = careerbiz.career_select(member_code);
		String[] start_dates = new String[careerList.size()];
		String[] end_dates = new String[careerList.size()];
		String[] end_day = new String[careerList.size()];
		String[] entry_day = new String[careerList.size()];
		for(int i =0; i < careerList.size();i++) {
			System.out.println(careerList.get(i).getDAY_OF_ENTRY());
			System.out.println(careerList.get(i).getDATE_OF_DEPARTURE());
			System.out.println(careerList.get(i).getSTART_DATE());
			System.out.println(careerList.get(i).getEND_DATE());
			if(careerList.get(i).getDAY_OF_ENTRY()!=null) {
				entry_day[i] = careerList.get(i).getDAY_OF_ENTRY().substring(0, 10);
				System.out.println("시분초 제거"+entry_day[i]);
				careerList.get(i).setDAY_OF_ENTRY(entry_day[i]);
			}
			if(careerList.get(i).getDATE_OF_DEPARTURE()!=null) {
				end_day[i] = careerList.get(i).getDATE_OF_DEPARTURE().substring(0, 10);
				System.out.println("시분초 제거"+end_day[i]);
				careerList.get(i).setDATE_OF_DEPARTURE(end_day[i]);
			}
			if(careerList.get(i).getSTART_DATE()!=null) {
				start_dates[i] = careerList.get(i).getSTART_DATE().substring(0, 10);
				System.out.println("시분초 제거"+start_dates[i]);
				careerList.get(i).setSTART_DATE(start_dates[i]);
			}
			if(careerList.get(i).getEND_DATE()!=null) {
				end_dates[i] = careerList.get(i).getEND_DATE().substring(0, 10);
				System.out.println("시분초 제거"+end_dates[i]);
				careerList.get(i).setEND_DATE(end_dates[i]);
			}
		}
		request.setAttribute("careerList", careerList);

		dispatch("/views/portfolio/portfoliopage.jsp", request, response);
	}

	// 설문조사 결과 페이지
	private void doSurveyPage(HttpServletRequest request, HttpServletResponse response)
	         throws ServletException, IOException {
	      // 설문조사 결과 페이지
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
	      List<SURVEY> surveyList = surveybiz.selectMySurvey(MEMBER_CODE);

	      request.setAttribute("surveyList", surveyList);
	      dispatch("/views/portfolio/surveypage.jsp", request, response);
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
