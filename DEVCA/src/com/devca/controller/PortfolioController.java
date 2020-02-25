package com.devca.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.devca.model.biz.protfolio.ActionBiz;
import com.devca.model.biz.protfolio.ActionBizImpl;
import com.devca.model.biz.protfolio.CareerBiz;
import com.devca.model.biz.protfolio.CareerBizImpl;
import com.devca.model.biz.protfolio.CareerDetailBiz;
import com.devca.model.biz.protfolio.CareerDetailBizImpl;
import com.devca.model.biz.protfolio.CertificateBiz;
import com.devca.model.biz.protfolio.CertificateBizImpl;
import com.devca.model.biz.protfolio.LanguageBiz;
import com.devca.model.biz.protfolio.LanguageBizImpl;
import com.devca.model.biz.protfolio.LanguageCertificateBiz;
import com.devca.model.biz.protfolio.LanguageCertificateBizImpl;
import com.devca.model.biz.protfolio.ProfileBiz;
import com.devca.model.biz.protfolio.ProfileBizImpl;
import com.devca.model.biz.protfolio.ProjectBiz;
import com.devca.model.biz.protfolio.ProjectBizImpl;
import com.devca.model.biz.protfolio.SchoolBiz;
import com.devca.model.biz.protfolio.SchoolBizImpl;
import com.devca.model.biz.protfolio.SkillBiz;
import com.devca.model.biz.protfolio.SkillBizImpl;
import com.devca.model.biz.protfolio.WorkBiz;
import com.devca.model.biz.protfolio.WorkBizImpl;
import com.devca.model.dto.ACTION_DTO;
import com.devca.model.dto.CAREER;
import com.devca.model.dto.CAREER_DETAIL;
import com.devca.model.dto.CERTIFICATE;
import com.devca.model.dto.KAKAO_MEMBER;
import com.devca.model.dto.LANGUAGE;
import com.devca.model.dto.LANGUAGE_CERTIFICATE;
import com.devca.model.dto.MEMBER;
import com.devca.model.dto.PROFILE;
import com.devca.model.dto.PROJECT;
import com.devca.model.dto.SCHOOL;
import com.devca.model.dto.SKILL;
import com.devca.model.dto.WORK;

@WebServlet(//
		name = "portfolio", // Controller Mapping name
		//
		urlPatterns = { //
				"portfoliopage.do", 		// 헤더 > 프로필버튼 입력 (프로필페이지 입장시 경력페이지 출력)
				"projectpage.do", 			// 경력 프로필 > 프로젝트 페이지
				"sideprojectpage.do",		// 사이드바 > 프로젝트 페이지
				"skillpage.do",				// 경력 > 주요 기술 페이지
				"sideskillpage.do",			// 사이드바 > 주요 기술 페이지
				"sidelanguagepage.do", 		// 사이드바 > 외국어 페이지
				"languagepage.do",			// 주요 기술 > 외국어 페이지
				"sideschoolpage.do",		// 사이드 바 > 학력 페이지
				"schoolpage.do",			// 외국어 > 학력 페이지
				"sideactionpage.do",		// 사이드 바 > 활동 페이지
				"actionpage.do",			// 학력 > 활동 페이지
				"sidecertificatepage.do",	// 사이드 바 > 자격증 페이지
				"certificatepage.do",		// 활동 > 자격증 페이지
				"sideworkpage.do",			// 사이드 바 > 직종/연봉 페이지
				"workpage.do",				// 자격증 > 직종/연봉 페이지
				
				
		})
public class PortfolioController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	HttpSession session ;
	CareerBiz careerbiz = new CareerBizImpl();
	CareerDetailBiz careerdetailbiz = new CareerDetailBizImpl(); 
	ProjectBiz projectbiz = new ProjectBizImpl();
	SkillBiz skillbiz = new SkillBizImpl();
	LanguageBiz languagebiz = new LanguageBizImpl();
	LanguageCertificateBiz langcertbiz = new LanguageCertificateBizImpl();
	SchoolBiz schoolbiz = new SchoolBizImpl();
	ActionBiz actionbiz = new ActionBizImpl();
	CertificateBiz certificatebiz = new CertificateBizImpl();
	WorkBiz workbiz = new WorkBizImpl();
	
	public PortfolioController() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// command에 따른 로직 처리
		
		
		String command = request.getRequestURI();
		System.out.println("<" + command + ">");

		// 프로필 페이지로 이동
		if (command.endsWith("/portfoliopage.do")) {
			doProfilePage(request, response);
		}
		// 경력페이지 > 프로젝트 
		else if(command.endsWith("/projectpage.do")){
			doProjectPage(request, response);
		}
		// 포트폴리오 사이드바 > 프로젝트
		else if(command.endsWith("/sideprojectpage.do")) {
			doSideProjectPage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/skillpage.do")) {
			doSkillPage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/sideskillpage.do")) {
			doSideSkillPage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/sidelanguagepage.do")) {
			doSideLanguagePage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/languagepage.do")) {
			doLanguagePage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/schoolpage.do")) {
			doSchoolPage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/sideschoolpage.do")) {
			doSideSchoolPage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/sideactionpage.do")) {
			doSideActionPage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/actionpage.do")) {
			doActionPage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/sidecertificatepage.do")) {
			doSideCertificatePage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/certificatepage.do")) {
			doCertificatePage(request, response);
		}
		// 에러 처리
		else if(command.endsWith("/sideworkpage.do")) {
			doSideWorkPage(request, response);
		}
		// 자격증 > 직종 /연봉
		else if(command.endsWith("/workpage.do")) {
			doWorkPage(request, response);
		}
		// 에러 처리
		else {
			doError(request, response);
		}
		
		
	}
	// 사이드바 > 직종/연봉페이지
	private void doSideWorkPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		List<WORK> workList = workbiz.work_select(member_code);
		request.setAttribute("workList", workList);
		dispatch("/views/portfolio/workpage.jsp", request, response);
		
	}
	// 자격증 > 직종/연봉페이지
	private void doWorkPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		List<WORK> workList = workbiz.work_select(member_code);
		request.setAttribute("workList", workList);
		dispatch("/views/portfolio/workpage.jsp", request, response);
		
	}
	// 사이드바 > 자격증 페이지
	private void doSideCertificatePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		List<CERTIFICATE> certificateList = certificatebiz.certificate_select(member_code);
		request.setAttribute("certificateList", certificateList);
		dispatch("/views/portfolio/certificatepage.jsp", request, response);
			}
	// 활동 > 자격증 페이지
	private void doCertificatePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		List<CERTIFICATE> certificateList = certificatebiz.certificate_select(member_code);
		request.setAttribute("certificateList", certificateList);
		dispatch("/views/portfolio/certificatepage.jsp", request, response);
		
	}
	// 사이드바 > 활동 페이지
	private void doSideActionPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		List<ACTION_DTO> actionList = actionbiz.action_select(member_code);
		request.setAttribute("actionList", actionList);
		dispatch("/views/portfolio/actionpage.jsp", request, response);
	}
	// 학력 > 활동 페이지
	private void doActionPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		

		int member_code = Integer.parseInt(request.getParameter("member_code"));
		List<ACTION_DTO> actionList = actionbiz.action_select(member_code);
		request.setAttribute("actionList", actionList);
		dispatch("/views/portfolio/actionpage.jsp", request, response);
		
	}
	// 사이드바 > 학력 페이지
	private void doSideSchoolPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		
		List<SCHOOL> schoolList = schoolbiz.school_select(member_code);

		request.setAttribute("schoolList", schoolList);
		
		dispatch("/views/portfolio/schoolpage.jsp", request, response);
	}
	// 외국어 > 학력 페이지
	private void doSchoolPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		int language_seq = Integer.parseInt(request.getParameter("language_seq"));
		
		String language_name = request.getParameter("otherselect");
		if(language_name.equals("other")) {
			language_name = request.getParameter("otherlanguage");
		}
		
		//어학 시험 테이블
		int language_certificate_seq = Integer.parseInt(request.getParameter("languagecertificate_seq"));
		String[] language_certificate_name = request.getParameterValues("language_name");
		String[] language_certificate_grade = request.getParameterValues("language_grade");
		int res = 0;

		for(int i = 0; i < language_certificate_name.length;i++) {
			LANGUAGE_CERTIFICATE LANGUAGE_CERTIFICATE_DTO = new LANGUAGE_CERTIFICATE(1+i, language_seq,
					language_certificate_name[i],language_certificate_grade[i]);
					res = langcertbiz.language_certificate_update(LANGUAGE_CERTIFICATE_DTO);
		}	
		
		if(res >0) {
			List<SCHOOL> school_list = schoolbiz.school_select(member_code);
			request.setAttribute("schoolList", school_list);
			dispatch("/views/portfolio/schoolpage.jsp", request, response);
		}else {
			jsResponse("잘못입력", "/DEVCA/protfolio/sidelanguagepage.do", response);
		}
		
	}
	// 사이드바 > 외국어 페이지
	private void doSideLanguagePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		
		List<LANGUAGE> languageList = languagebiz.language_select(member_code);
		LANGUAGE language = languagebiz.language_select_seq(member_code);
		int language_seq = language.getLANGUAGE_SEQ();
		List<LANGUAGE_CERTIFICATE> langcertList = langcertbiz.language_certificate_select(language_seq);
		
		request.setAttribute("languageList", languageList);
		request.setAttribute("langcertList", langcertList);
		
		dispatch("/views/portfolio/languagepage.jsp", request, response);
		
	}
	// 기술 > 외국어 페이지
	private void doLanguagePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 기술 테이블 insert
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		skillbiz.skill_delete(member_code);
		int res = 0;
		int cnt = 0;
		SKILL skill_dto = null;
		String[] skill_name= request.getParameterValues("skill_name");
		
		System.out.println(member_code);
		for(int j = 0; j<skill_name.length;j++) {
			System.out.println(skill_name[j]);
		}
		for(int i = 0; i< skill_name.length; i++) {
		skill_dto = new SKILL();
		skill_dto.setSKILL_MEMBER_CODE(member_code);
		skill_dto.setSKILL(skill_name[i]);
		res = skillbiz.skill_insert(skill_dto);
		
			if(res > 0 ) {
				cnt++;
			}
		res = 0;
		}
		if(cnt == skill_name.length) {
			// 외국어 테이블 정보 조회
				// 뉴비 진입시 테이블 생성용
					int language_count = languagebiz.language_count(member_code);
					// 경력 번호로 상세 항목 테이블 참조
					if(language_count == 0) {
						languagebiz.language_insert_new(member_code);	//경력 테이블 생성
					}
				//뉴비 진입시 테이블 생성용
			List<LANGUAGE> languageList = languagebiz.language_select(member_code);
			LANGUAGE language = languagebiz.language_select_seq(member_code);
			int language_seq = language.getLANGUAGE_SEQ();
			List<LANGUAGE_CERTIFICATE> langcertList = langcertbiz.language_certificate_select(language_seq);
			
			request.setAttribute("languageList", languageList);
			request.setAttribute("langcertList", langcertList);
			
			dispatch("/views/portfolio/languagepage.jsp", request, response);
		}
		else {
			jsResponse("저장실패", "/DEVCA/protfolio/sideskillpage.do?member_code="+member_code, response);
		}
	}
	// 사이드바 > 기술 페이지
	private void doSideSkillPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		
			// 뉴비 진입시 테이블 생성용
				int skill_count = skillbiz.skill_count(member_code);
				if(skill_count == 0) {
					skillbiz.skill_insert_new(member_code);	//주요기술 테이블 생성
					System.out.println("주요기술 테이블 생성");
				}
			//뉴비 진입시 테이블 생성용
		// 멤버코드로 스킬페이지 테이블 참조
		List<SKILL> skillList = skillbiz.skill_select(member_code);
		
		request.setAttribute("skillList", skillList);

		dispatch("/views/portfolio/skillpage.jsp", request, response);
		
	}

	// 주요 기술 페이지
	private void doSkillPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		int project_seq = Integer.parseInt(request.getParameter("project_seq"));
		
		String project_name = request.getParameter("project_name");
		int create_year = Integer.parseInt(request.getParameter("create_year"));
		String project_oneline_ex = request.getParameter("project_oneline_ex");
		String project_team = request.getParameter("project_team");
		int project_member = Integer.parseInt(request.getParameter("project_member"));
		String project_usestack = request.getParameter("project_usestack");
		String project_detail = request.getParameter("project_detail");
		String project_storage_link = request.getParameter("project_storage_link");
		
		String Website = request.getParameter("Website");
		String Android = request.getParameter("Android");
		String iOS = request.getParameter("iOS");
		
		PROJECT PROJECT_DTO = new PROJECT(member_code,project_seq,project_name,create_year,project_oneline_ex,project_team,project_member,project_usestack,project_detail,project_storage_link,Website,Android,iOS);
		
		int project_res = projectbiz.project_update(PROJECT_DTO);
		
		if(project_res > 0) {			
			// 멤버코드로 스킬페이지 테이블 참조
				// 뉴비 진입시 테이블 생성용
					int skill_count = skillbiz.skill_count(member_code);
					if(skill_count == 0) {
						skillbiz.skill_insert_new(member_code);	//주요 기술 테이블 생성
						System.out.println("주요기술 테이블 생성");
					}
				//뉴비 진입시 테이블 생성용
			List<SKILL> skillList = skillbiz.skill_select(member_code);
			request.setAttribute("skillList", skillList);
			dispatch("/views/portfolio/skillpage.jsp", request, response);
		}else {
			jsResponse("잘못입력", "/DEVCA/protfolio/sideprojectpage.do?member_code="+member_code, response);
		}
		
		
	}
	// 개인 프로젝트 페이지
	private void doProjectPage(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		// 멤버코드로 상세 항목 테이블 번호 참조
		CAREER career_seq_dto = careerbiz.career_select_seq(member_code);
		int career_seq = career_seq_dto.getCAREER_SEQ();
		
		//career_table 값 업데이트
		String COMPANY_NAME = request.getParameter("COMPANYNAME");
		String DUTY = request.getParameter("DUTY");
		String DAY_OF_ENTRY = request.getParameter("DAY_OF_ENTRY");
		String DATE_OF_DEPARTURE = request.getParameter("DATE_OF_DEPARTURE");
		String STACK = request.getParameter("STACK");
		String LINK = request.getParameter("LINK");
		String EXPLANATION = request.getParameter("EXPLANATION");
		
		CAREER CAREER_DTO = new CAREER(member_code,career_seq,COMPANY_NAME,DUTY,DAY_OF_ENTRY,
				DATE_OF_DEPARTURE,STACK,LINK,EXPLANATION);
		
		int career_update_res = careerbiz.career_update(CAREER_DTO);

		
		//career_detail_table 값 업데이트
		int career_detail_seq = Integer.parseInt(request.getParameter("CAREER_SEQ"));
		String PERFORMANCE  = request.getParameter("PERFORMANCE");
		String START_DATE = request.getParameter("START_DATE");
		String END_DATE = request.getParameter("END_DATE");
		String DETAIL_CONTEXT = request.getParameter("DETAIL_CONTEXT");
		
		CAREER_DETAIL CAREER_DETAIL_DTO = new CAREER_DETAIL(career_detail_seq, career_seq,
				PERFORMANCE,START_DATE,END_DATE,DETAIL_CONTEXT);
		
		int career_detail_update_res = careerdetailbiz.career_detail_update(CAREER_DETAIL_DTO);
		
		if(career_update_res > 0 && career_detail_update_res > 0) {
			// 뉴비 진입시 테이블 생성용
				int project_count = projectbiz.project_count(member_code);
				if(project_count == 0) {
					projectbiz.project_insert_new(member_code);	//경력 테이블 생성
				}
			//뉴비 진입시 테이블 생성용
			List<PROJECT> project_List = projectbiz.project_select(member_code);
			request.setAttribute("projectList", project_List);
			dispatch("/views/portfolio/projectpage.jsp",request, response);
		} else {
			doProfilePage(request, response);
		}
		
	}
	
	private void doSideProjectPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int member_code = Integer.parseInt(request.getParameter("member_code"));
		
		// 뉴비 진입시 테이블 생성용
			int project_count = projectbiz.project_count(member_code);
			if(project_count == 0) {
				projectbiz.project_insert_new(member_code);	//경력 테이블 생성
			}
		//뉴비 진입시 테이블 생성용
		// 멤버코드로 경력페이지 테이블 참조
		List<PROJECT> projectList = projectbiz.project_select(member_code);
			
		request.setAttribute("projectList", projectList);

		dispatch("/views/portfolio/projectpage.jsp", request, response);
			
	}
	
	// 프로필 페이지 + 초기화면 경력페이지
	private void doProfilePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int member_code = Integer.parseInt(request.getParameter("member_code"));
			
			// 뉴비 진입시 테이블 생성용
				int CAREER_COUNT = careerbiz.career_count(member_code);
				// 경력 번호로 상세 항목 테이블 참조
				if(CAREER_COUNT == 0) {
					careerbiz.career_insert_new(member_code);	//경력 테이블 생성
				}
				CAREER CAREER_SEQ = careerbiz.career_select_seq(member_code);
				int career_seq = CAREER_SEQ.getCAREER_SEQ();
				int CAREER_DETAIL_COUNT = careerdetailbiz.career_detail_count(career_seq);
				if(CAREER_DETAIL_COUNT == 0) {
					careerdetailbiz.career_detail_insert_new(member_code); // 경력 상세 항목 테이블 생성
				}
			//뉴비 진입시 테이블 생성용
			
		// 멤버코드로 경력페이지 테이블 참조
		List<CAREER> careerList = careerbiz.career_select(member_code);
		List<CAREER_DETAIL> career_detailList = careerdetailbiz.career_detail_select(career_seq);
		
		request.setAttribute("career_detailList", career_detailList);
		request.setAttribute("careerList", careerList);

		dispatch("/views/portfolio/portfoliopage.jsp", request, response);
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
