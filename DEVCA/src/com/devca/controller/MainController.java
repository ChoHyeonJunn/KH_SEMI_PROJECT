package com.devca.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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

import com.devca.model.biz.lecture.LectureBiz;
import com.devca.model.biz.lecture.LectureBizImpl;
import com.devca.model.biz.main.MainBiz;
import com.devca.model.biz.main.MainBizImpl;
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
import com.devca.model.biz.protfolio.WorkBiz;
import com.devca.model.biz.protfolio.WorkBizImpl;
import com.devca.model.biz.study.StudyBiz;
import com.devca.model.biz.study.StudyBizImpl;
import com.devca.model.dto.lecture.JOB_RANK;
import com.devca.model.dto.lecture.LECTURE;
import com.devca.model.dto.member.KAKAO_MEMBER;
import com.devca.model.dto.member.MEMBER;
import com.devca.model.dto.member.NAVER_MEMBER;
import com.devca.model.dto.member.ROADMAP;
import com.devca.model.dto.profile.ACTION_DTO;
import com.devca.model.dto.profile.CAREER;
import com.devca.model.dto.profile.CERTIFICATE;
import com.devca.model.dto.profile.LANGUAGE;
import com.devca.model.dto.profile.PROJECT;
import com.devca.model.dto.profile.SCHOOL;
import com.devca.model.dto.profile.SKILL;
import com.devca.model.dto.profile.WORK;
import com.devca.model.dto.study.STUDY;
import com.devca.utility.crawling.WikiSearch;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet(//
		name = "main", // Controller Mapping name
		//
		urlPatterns = { //
				"mainpage.do", // main 페이지로 이동
		})
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	MainBiz biz = new MainBizImpl();
	LectureBiz lectureBiz = new LectureBizImpl();
	StudyBiz studyBiz = new StudyBizImpl();

	SkillBiz skillbiz = new SkillBizImpl();// 6각 다이어그램 아래 주요기술
	WorkBiz workbiz = new WorkBizImpl();// 6각 다이어그램 아래 희망직종
	CareerBiz careerbiz = new CareerBizImpl();// 6각 다이어그램 경력
	ProjectBiz projectbiz = new ProjectBizImpl();// 6각 다이어그램 경력
	SchoolBiz schoolBiz = new SchoolBizImpl();// 6각 다이어그램 학력
	LanguageBiz languagebiz = new LanguageBizImpl();// 6각 다이어그램 외국어
	ActionBiz actionbiz = new ActionBizImpl();// 6각 다이어그램 활동
	CertificateBiz certificateBiz = new CertificateBizImpl();// 6각 다이어그램 수상,자격증

	public MainController() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// command에 따른 로직 처리

		String command = request.getRequestURI();
		System.out.println("<" + command + ">");

		if (command.endsWith("/mainpage.do")) {
			doMainPage(request, response);
		}
		// 스킬체크해보기
		else if (command.endsWith("/survey.do")) {
			doSurvey(request, response);
		}
		/*
		 * 기술스택 순위, 로드맵 요청
		 */
		else if (command.endsWith("/getBarChartData.do")) {
			doGetBarChartData(request, response); // 기술 요구사항 데이터 요청 처리
		} else if (command.endsWith("/getRoadMapData.do")) {
			doGetRoadMapData(request, response); // 로드맵 데이터 요청 처리
		} else if (command.endsWith("/addRoadMapData.do")) {
			doAddRoadMapData(request, response); // 로드맵 데이터 추가 요청 처리
		} else if (command.endsWith("/addRoadMapCategory.do")) {
			doAddRoadMapCategory(request, response); // 로드맵 중분류 추가 요청 처리
		} else if (command.endsWith("/removeRoadMapData.do")) {
			doRemoveRoadMapData(request, response); // 로드맵 데이터 삭제 요청 처리
		} else if (command.endsWith("/linkRoadMapData.do")) {
			doLinkRoadMapData(request, response); // 로드맵 데이터 연결 요청 처리
		} else if (command.endsWith("/getDescriptionWikiSearchingAjax.do")) {
			doGetDescriptionWikiSearchingAjax(request, response); // 기술 간단설명 크롤링
		}

		/*
		 * 메인에 뿌릴 강의 관련 요청
		 */
		else if (command.endsWith("/recommandlistajax.do")) {
			doRecommandListAjax(request, response); // 추천 강의 리스트 가져오기 ajax
		} else if (command.endsWith("/mylistajax.do")) {
			doMyListAjax(request, response); // 내 강의 리스트 가져오기 ajax
		} else if (command.endsWith("/frontendlistajax.do")) {
			doFrontEndListAjax(request, response); // 프론트 추천강의 리스트 가져오기 ajax
		} else if (command.endsWith("/backendlistajax.do")) {
			doBackEndListAjax(request, response); // 백엔드 추천 강의 리스트 가져오기 ajax
		} else if (command.endsWith("/fullstacklistajax.do")) {
			doFullStackListAjax(request, response); // 풀스택 추천 강의 리스트 가져오기 ajax
		}

		/*
		 * error 처리
		 */
		else {
			doError(request, response);
		}
		// ,,,,,
	}

	private void doMainPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		if (session.getAttribute("loginMember") != null || session.getAttribute("loginKakao") != null
				|| session.getAttribute("loginNaver") != null) {
			// 로그인 상태일 때
			System.out.println("로그인 상태로 main 접근");

			// 스터디
			List<STUDY> studyList = studyBiz.selectStudyList();
			request.setAttribute("studyList", studyList);

			// 육각다이어그램 데이터(temp)
			int MEMBER_CODE = 0;
			if (session.getAttribute("loginMember") != null) {
				MEMBER_CODE = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
			} else if (session.getAttribute("loginKakao") != null) {
				MEMBER_CODE = ((KAKAO_MEMBER) session.getAttribute("loginKakao")).getMEMBER_CODE();
			} else if (session.getAttribute("loginNaver") != null) {
				MEMBER_CODE = ((NAVER_MEMBER) session.getAttribute("loginNaver")).getMEMBER_CODE();
			}

			List<SKILL> skillList = skillbiz.skill_select(MEMBER_CODE);
	          String[] skill = new String[skillList.size()];
	          
	          for(int i = 0; i< skillList.size(); i++) {
	             skill[i] = skillList.get(i).getSKILL();
	             
	             request.setAttribute("skill", skill);
	         }
	         
	         List<WORK> workList = workbiz.work_select(MEMBER_CODE);
	         String[] work = new String[workList.size()];
	         
	         for(int i = 0; i< workList.size(); i++) {
	            work[i] = workList.get(i).getLINE_OF_WORK();
	            
	            request.setAttribute("work", work);
	         }
	         /*경력 */
	         List<CAREER> career = careerbiz.career_select(MEMBER_CODE);
	         int career_count = 0;
	         if(career.isEmpty()) {// 프로필 창 진입 x
	        	 career_count = 0;
	         }else if(career.get(0).getCOMPANY_NAME() == null) {
	        	 career_count = 0;
	         }else {
	        	 career_count = career.size();
	         }
	         if(career_count > 3) {
	        	career_count = 3;
	         }
	         request.setAttribute("career_count", career_count);
	         
	         /*프로젝트 */
	         List<PROJECT> project = projectbiz.project_select(MEMBER_CODE);
	         int project_count = 0;
	         if(project.isEmpty()) {//프로필 창 진입 x
	        	 project_count = 0;
	         }else if(project.get(0).getPROJECT_NAME() == null) {
	        	 project_count = 0;
	         }else {
	        	 project_count = project.size();
	         }
	         if(project_count > 3) {
	        	 project_count = 3;
	         }
	         request.setAttribute("project_count", project_count);
	         
			 /*학력 */
	         List<SCHOOL> list = schoolBiz.school_select(MEMBER_CODE);
	         int credit = 0;
	         int school_credit = 0;
	         if(list.isEmpty()) {
	        	 credit = 0;
	         }else {
	        	 credit = (int)(list.get(0).getSCHOOL_CREDIT());
	             if(credit < 2) {
	            	 school_credit = 0;
	             }else if(credit < 3){
	            	 school_credit = 1;
	             }else if(credit < 4){
	            	 school_credit = 2;
	             }else {
	            	 school_credit = 3;
	             }
	         }
	         
	        
	         request.setAttribute("school_credit", school_credit);
			 /*외국어 */
	         List<LANGUAGE> language = languagebiz.language_select(MEMBER_CODE);
	         int language_count = 0;
	         if(language.isEmpty()) {// 프로필 창 진입 x
	        	 language_count = 0;
	         }else if(language.get(0).getLANGUAGE_NAME() == null) {
	        	 language_count = 0;
	         }else {
	        	 language_count = language.size();
	         }
	         if(career_count > 3) {
	        	career_count = 3;
	         }
	         request.setAttribute("language_count", language_count);
	         
			 /*활동 */
	         List<ACTION_DTO> action = actionbiz.action_select(MEMBER_CODE);
	         int action_count = 0;
	         if(action.isEmpty()) {// 프로필 창 진입 x
	        	 action_count = 0;
	         }else if(action.get(0).getACTION_NAME()== null) {
	        	 action_count = 0;
	         }else {
	        	 action_count = action.size();
	         }
	         if(career_count > 3) {
	        	career_count = 3;
	         }
	         request.setAttribute("action_count", action_count);
	         
			 /*수상/자격증 */
	         List<CERTIFICATE> certificate = certificateBiz.certificate_select(MEMBER_CODE);
	         int certificate_count = 0;
	         if(certificate.isEmpty()) {// 프로필 창 진입 x
	        	 certificate_count = 0;
	         }else if(certificate.get(0).getCERTIFICATE_NAME()== null) {
	        	 certificate_count = 0;
	         }else {
	        	 certificate_count = certificate.size();
	         }
	         if(career_count > 3) {
	        	career_count = 3;
	         }
	         request.setAttribute("certificate_count", certificate_count);
	         
	         int[] data = { career_count, project_count, school_credit, language_count, action_count, certificate_count };
	           request.setAttribute("data", data);

			dispatch("/views/main/main.jsp", request, response);
		} else {
			// 미 로그인 상태일 때
			System.out.println("로그아웃 상태로 home 접근");
			dispatch("/views/main/home.jsp", request, response);
		}

	}

	// 스킬체크해보기
	private void doSurvey(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/main/survey.jsp", request, response);
	}

	/*
	 * 기술스택 순위 요청
	 */

	// 기술 요구사항 데이터 요청 처리
	@SuppressWarnings("unchecked")
	private void doGetBarChartData(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String verify = request.getParameter("param");
		System.out.println(verify);
		List<JOB_RANK> job_rankList = biz.getBarChartData(verify);

		JSONArray array = new JSONArray();
		for (JOB_RANK job : job_rankList) {
			JSONObject obj = new JSONObject();
			obj.put("tech", job.getJOB_RANK_STACK());
			obj.put("requireNum", job.getJOB_RANK_NUM());
			array.add(obj);
		}

		PrintWriter out = response.getWriter();
		out.println(array);
	}

	// 로드맵 데이터 요청 처리
	@SuppressWarnings("unchecked")
	private void doGetRoadMapData(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		ROADMAP roadMap = biz.getRoadMapData(MEMBER_CODE);

		JSONObject obj = new JSONObject();
		obj.put("field", roadMap.getROADMAP_FIELD());
		obj.put("roadMap", roadMap.getROADMAP_TECH());
		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 로드맵 데이터 추가 요청 처리
	@SuppressWarnings("unchecked")
	private void doAddRoadMapData(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		String item = request.getParameter("item");

		int res = biz.addRoadMapData(MEMBER_CODE, item);

		ROADMAP roadMap = biz.getRoadMapData(MEMBER_CODE);

		JSONObject obj = new JSONObject();
		obj.put("roadMap", roadMap.getROADMAP_TECH());
		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 로드맵 중분류 추가 요청 처리
	@SuppressWarnings("unchecked")
	private void doAddRoadMapCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		String item = request.getParameter("item");

		int res = biz.addRoadMapCategory(MEMBER_CODE, item);

		ROADMAP roadMap = biz.getRoadMapData(MEMBER_CODE);

		JSONObject obj = new JSONObject();
		obj.put("roadMap", roadMap.getROADMAP_TECH());
		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 로드맵 데이터 삭제 요청 처리
	@SuppressWarnings("unchecked")
	private void doRemoveRoadMapData(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		String item = request.getParameter("item");

		int res = biz.removeRoadMapData(MEMBER_CODE, item);

		ROADMAP roadMap = biz.getRoadMapData(MEMBER_CODE);

		JSONObject obj = new JSONObject();
		obj.put("roadMap", roadMap.getROADMAP_TECH());
		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 로드맵 데이터 연결 요청 처리
	@SuppressWarnings("unchecked")
	private void doLinkRoadMapData(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		String selectedItem = request.getParameter("selectedItem");
		String Item = request.getParameter("Item");

		int res = biz.linkRoadMapData(MEMBER_CODE, selectedItem, Item);

		ROADMAP roadMap = biz.getRoadMapData(MEMBER_CODE);

		JSONObject obj = new JSONObject();
		obj.put("roadMap", roadMap.getROADMAP_TECH());
		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 기술 간단설명 크롤링
	@SuppressWarnings("unchecked")
	private void doGetDescriptionWikiSearchingAjax(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String word = request.getParameter("word");
		String description = WikiSearch.wikiSearching(word);

		JSONObject obj = new JSONObject();
		obj.put("description", description.replace("\n", ""));
		PrintWriter out = response.getWriter();
		out.println(obj);
	}
	/*
	 * 메인에 뿌릴 강의 관련 요청
	 */

	// 추천강의 리스트 가져오기 ajax
	private void doRecommandListAjax(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		ROADMAP roadMap = biz.getRoadMapData(MEMBER_CODE);

		System.out.println(roadMap.getROADMAP_TECH());

		JsonParser parser = new JsonParser();
		JsonArray roadMapData = (JsonArray) parser.parse(roadMap.getROADMAP_TECH());

		List<String> keyWordList = new ArrayList<String>();

		for (int i = 0; i < roadMapData.size(); i++) {
			JsonObject obj = roadMapData.get(i).getAsJsonObject();

			keyWordList.add(obj.get("name").toString().replace("\"", ""));

			if (obj.get("children") != null) {
				JsonArray array = obj.get("children").getAsJsonArray();
				for (int j = 0; j < array.size(); j++) {
					JsonObject sobj = array.get(j).getAsJsonObject();
					keyWordList.add(sobj.get("name").toString().replace("\"", ""));
				}
			}
		}

		for (String s : keyWordList) {
			System.out.println(s);
		}

		List<LECTURE> lectureList = lectureBiz.selectRecommandList(keyWordList);

//		for (int i = 0; i < lectureList.size(); i++) {
//			System.out.println("lecture[" + i + "]" + lectureList.get(i).getLECTURE_CODE());
//		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(lectureList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 내 강의 리스트 가져오기 ajax
	private void doMyListAjax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		List<LECTURE> myList = lectureBiz.selectMyLectureList(MEMBER_CODE, 0);

//		for (int i = 0; i < myList.size(); i++) {
//			System.out.println("lecture[" + i + "]" + myList.get(i).getLECTURE_CODE());
//		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(myList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 프론트 추천강의 리스트 가져오기 ajax
	private void doFrontEndListAjax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<LECTURE> frontEndList = lectureBiz.selectFrontEndList();

//		for (int i = 0; i < frontEndList.size(); i++) {
//			System.out.println("lecture[" + i + "]" + frontEndList.get(i).getLECTURE_CODE());
//		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(frontEndList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 백엔드 추천강의 리스트 가져오기 ajax
	private void doBackEndListAjax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<LECTURE> backEndList = lectureBiz.selectBackEndList();

//		for (int i = 0; i < backEndList.size(); i++) {
//			System.out.println("lecture[" + i + "]" + backEndList.get(i).getLECTURE_CODE());
//		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(backEndList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 풀스택 추천강의 리스트 가져오기 ajax
	private void doFullStackListAjax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<LECTURE> fullStackList = lectureBiz.selectFullStackList();

//		for (int i = 0; i < fullStackList.size(); i++) {
//			System.out.println("lecture[" + i + "]" + fullStackList.get(i).getLECTURE_CODE());
//		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(fullStackList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
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
