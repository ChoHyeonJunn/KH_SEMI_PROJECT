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
import com.devca.model.dto.lecture.JOB_RANK;
import com.devca.model.dto.lecture.LECTURE;
import com.devca.model.dto.member.ROADMAP;
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

		/*
		 * 기술스택 순위, 로드맵 요청
		 */
		else if (command.endsWith("/getBarChartData.do")) {
			doGetBarChartData(request, response); // 기술 요구사항 데이터 요청 처리
		} else if (command.endsWith("/getRoadMapData.do")) {
			doGetRoadMapData(request, response); // 로드맵 데이터 요청 처리
		} else if (command.endsWith("/addRoadMapData.do")) {
			doAddRoadMapData(request, response); // 로드맵 데이터 추가 요청 처리
		} else if (command.endsWith("/removeRoadMapData.do")) {
			doRemoveRoadMapData(request, response); // 로드맵 데이터 삭제 요청 처리
		} else if (command.endsWith("/linkRoadMapData.do")) {
			doLinkRoadMapData(request, response); // 로드맵 데이터 연결 요청 처리
		}

		/*
		 * 메인에 뿌릴 강의 관련 요청
		 */
		else if (command.endsWith("/recommandlistajax.do")) {
			doRecommandListAjax(request, response); // 추천 강의 리스트 가져오기 ajax
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
			dispatch("/views/main/main.jsp", request, response);
		} else {
			// 미 로그인 상태일 때
			System.out.println("로그아웃 상태로 home 접근");
			dispatch("/views/main/home.jsp", request, response);
		}

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

		for (int i = 0; i < lectureList.size(); i++) {
			System.out.println("lecture[" + i + "]" + lectureList.get(i).getLECTURE_CODE());
		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(lectureList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 프론트 추천강의 리스트 가져오기 ajax
	private void doFrontEndListAjax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<LECTURE> frontEndList = lectureBiz.selectFrontEndList();

		for (int i = 0; i < frontEndList.size(); i++) {
			System.out.println("lecture[" + i + "]" + frontEndList.get(i).getLECTURE_CODE());
		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(frontEndList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 백엔드 추천강의 리스트 가져오기 ajax
	private void doBackEndListAjax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<LECTURE> backEndList = lectureBiz.selectBackEndList();

		for (int i = 0; i < backEndList.size(); i++) {
			System.out.println("lecture[" + i + "]" + backEndList.get(i).getLECTURE_CODE());
		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(backEndList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 풀스택 추천강의 리스트 가져오기 ajax
	private void doFullStackListAjax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<LECTURE> fullStackList = lectureBiz.selectFullStackList();

		for (int i = 0; i < fullStackList.size(); i++) {
			System.out.println("lecture[" + i + "]" + fullStackList.get(i).getLECTURE_CODE());
		}

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
