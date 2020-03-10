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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.devca.model.biz.lecture.LectureBiz;
import com.devca.model.biz.lecture.LectureBizImpl;
import com.devca.model.biz.review.ReviewBiz;
import com.devca.model.biz.review.ReviewBizImpl;
import com.devca.model.dto.lecture.LECTURE;
import com.devca.model.dto.lecture.REVIEW;
import com.devca.model.dto.member.KAKAO_MEMBER;
import com.devca.model.dto.member.MEMBER;
import com.devca.model.dto.member.NAVER_MEMBER;
import com.devca.utility.string.HtmlString;
import com.google.gson.Gson;

@WebServlet(//
		name = "lecture", // Controller Mapping name
		//
		urlPatterns = { //
				"lecturelistpage.do", // 강의 리스트 페이지로 이동
				"lecturedetailpage.do", // 강의 디테일 페이지로 이동
		})
public class LectureController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	LectureBiz biz = new LectureBizImpl();
	ReviewBiz reviewBiz = new ReviewBizImpl();

	public LectureController() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String command = request.getRequestURI();
		System.out.println("<" + command + ">");

		/* jobData를 통해 최근 기술 동향 crawling */
		if (command.endsWith("/CrawlingJobData.do")) {
			doCrawlingJobData(request, response);
		}
		/* 여러 사이트를 통해 강의 데이터를 crawling */
		else if (command.endsWith("/CrawlingLectureList.do")) {
			doCrawlingLectureList(request, response);
		}

		/* 강의 관련 요청들 */
		else if (command.endsWith("/lecturelistpage.do")) {
			doLectureListPage(request, response); // 강의 리스트 페이지로 이동
		} else if (command.endsWith("/lecturelistajax.do")) {
			doLectureListAjax(request, response); // 강의 리스트 가져오기 ajax
		} else if (command.endsWith("/lectureSearchAutoComplete.do")) {
			doLectureSearchAutoComplete(request, response); // 강의 검색 자동완성
		} else if (command.endsWith("/lecturesearchlistajax.do")) {
			doLectureSearchListAjax(request, response); // 강의 검색 리스트 가져오기 ajax
		} else if (command.endsWith("/lecturedetailpage.do")) {
			doLectureDetailPage(request, response); // 강의 디테일 페이지로 이동
		} else if (command.endsWith("/mylecturelistpage.do")) {
			doMyLectureListPage(request, response); // 내강의 리스트 페이지로 이동
		} else if (command.endsWith("/mylecturelistajax.do")) {
			doMyLectureListAjax(request, response); // 내강의 리스트 가져오기 ajax
		} else if (command.endsWith("/addmylectureajax.do")) {
			doAddMyLectureAjax(request, response); // 내강의에 추가하기
		} else if (command.endsWith("/deleteMyGarbageLecture.do")) {
			doDeleteMyGarbageLecture(request, response); // 내강의에 추가하기
		}

		/* 후기 관련 요청들 */
		else if (command.endsWith("/selectReviewList.do")) {
			doselectReviewList(request, response); // 해당 강의의 후기 셀렉트
		} else if (command.endsWith("/insertReview.do")) {
			doInsertReview(request, response); // 해당 강의의 후기 셀렉트
		} else if (command.endsWith("/updateReview.do")) {
			doUpdateReview(request, response); // 해당 강의의 후기 셀렉트
		} else if (command.endsWith("/deleteReview.do")) {
			doDeleteReview(request, response); // 해당 강의의 후기 셀렉트
		} else {
			doError(request, response); // 에러 페이지로 이동
		}

	}

	/* jobData를 통해 최근 기술 동향 crawling */
	private void doCrawlingJobData(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		biz.crawlingSetJOB_RANK_FREQUENCY();

		dispatch("/views/main/home.jsp", request, response);
	}

	/* 여러 사이트를 통해 강의 데이터를 crawling multiInsert */
	private void doCrawlingLectureList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int res = biz.crawlingLectureList();

		System.out.println("crawling 완료! insert 갯수 = " + res);

		dispatch("/views/main/home.jsp", request, response);
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

		System.out.println(no + "번째 scroll selectList");

		List<LECTURE> lectureList = biz.selectLectureList(no);
		// payFlag 에서 html 태그 제거
		for (LECTURE lecture : lectureList)
			lecture.setLECTURE_PAYFLAG(HtmlString.removeTag(lecture.getLECTURE_PAYFLAG()));

		for (int i = 0; i < lectureList.size(); i++) {
			System.out.println("lecture[" + i + "]" + lectureList.get(i).getLECTURE_CODE());
		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(lectureList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 강의 검색 자동완성
	private void doLectureSearchAutoComplete(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String search = request.getParameter("search");

		List<LECTURE> lectureList = biz.selectLectureAutoCompleteList(search);

		Gson gson = new Gson();
		String jsonList = gson.toJson(lectureList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 강의 검색 리스트 가져오기 ajax
	private void doLectureSearchListAjax(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		String search = request.getParameter("search");

		System.out.println(no + "번째 scroll selectList");

		List<LECTURE> lectureList = biz.selectLectureList(no, search);
		// payFlag 에서 html 태그 제거
		for (LECTURE lecture : lectureList)
			lecture.setLECTURE_PAYFLAG(HtmlString.removeTag(lecture.getLECTURE_PAYFLAG()));

		for (int i = 0; i < lectureList.size(); i++) {
			System.out.println("lecture[" + i + "]" + lectureList.get(i).getLECTURE_CODE());
		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(lectureList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 내강의 리스트 페이지로 이동
	private void doMyLectureListPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/lecture/mylecturelist.jsp", request, response);
	}

	// 내 강의 리스트 가져오기 ajax
	private void doMyLectureListAjax(HttpServletRequest request, HttpServletResponse response)
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

		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println(no + "번째 scroll selectList");

		List<LECTURE> lectureList = biz.selectMyLectureList(MEMBER_CODE, no);
		// payFlag 에서 html 태그 제거
		for (LECTURE lecture : lectureList)
			lecture.setLECTURE_PAYFLAG(HtmlString.removeTag(lecture.getLECTURE_PAYFLAG()));

		for (int i = 0; i < lectureList.size(); i++) {
			System.out.println("lecture[" + i + "]" + lectureList.get(i).getLECTURE_CODE());
		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(lectureList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 내 강의에 추가
	@SuppressWarnings("unchecked")
	private void doAddMyLectureAjax(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		int LECTURE_CODE = Integer.parseInt(request.getParameter("LECTURE_CODE"));

		int res = biz.addMyLecture(MEMBER_CODE, LECTURE_CODE);

		JSONObject json = new JSONObject();
		json.put("res", res);
		PrintWriter out = response.getWriter();
		out.println(json);
	}

	// 강의 디테일 페이지로 이동
	private void doLectureDetailPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int LECTURE_CODE = Integer.parseInt(request.getParameter("lecture_code"));

		LECTURE lecture_detail = biz.selectLectureDetail(LECTURE_CODE);
		List<REVIEW> reviewList = reviewBiz.selectReviewList(LECTURE_CODE);

		request.setAttribute("lecture_detail", lecture_detail);
		request.setAttribute("reviewList", reviewList);

		dispatch("/views/lecture/lecturedetail.jsp", request, response);
	}

	// 만료된 강의 삭제
	private void doDeleteMyGarbageLecture(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int LECTURE_CODE = Integer.parseInt(request.getParameter("LECTURE_CODE"));
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		
		System.out.println(MEMBER_CODE+" : "+LECTURE_CODE);
		
		int res = biz.deleteMyGarbageLecture(LECTURE_CODE, MEMBER_CODE);

		JSONObject json = new JSONObject();
		json.put("res", res);
		PrintWriter out = response.getWriter();
		out.println(json);
	}

	/*
	 * 리뷰 관련 요청들
	 */
	@SuppressWarnings("unchecked")
	private void doselectReviewList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int LECTURE_CODE = Integer.parseInt(request.getParameter("LECTURE_CODE"));
		System.out.println(LECTURE_CODE);
		List<REVIEW> reviewList = reviewBiz.selectReviewList(LECTURE_CODE);

		JSONArray reviewArray = new JSONArray();
		for (REVIEW review : reviewList) {
			JSONObject reviewObj = new JSONObject();

			reviewObj.put("REVIEW_CODE", review.getREVIEW_CODE());
			reviewObj.put("MEMBER_CODE", review.getMEMBER_CODE());
			reviewObj.put("LECTURE_CODE", review.getLECTURE_CODE());

			reviewObj.put("REVIEW_WRITER", review.getREVIEW_WRITER());
			reviewObj.put("REVIEW_TITLE", review.getREVIEW_TITLE());
			reviewObj.put("REVIEW_CONTENT", review.getREVIEW_CONTENT());
			reviewObj.put("REVIEW_REGDATE", review.getREVIEW_REGDATE());
			reviewObj.put("REVIEW_RATE", review.getREVIEW_RATE());

			reviewArray.add(reviewObj);
		}

		PrintWriter out = response.getWriter();
		out.println(reviewArray);
	}

	// 후기 인서트 요청
	private void doInsertReview(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		int LECTURE_CODE = Integer.parseInt(request.getParameter("LECTURE_CODE"));
		String REVIEW_WRITER = request.getParameter("REVIEW_WRITER");
		String REVIEW_TITLE = request.getParameter("REVIEW_TITLE");
		String REVIEW_CONTENT = request.getParameter("REVIEW_CONTENT");
		String REVIEW_RATE = request.getParameter("REVIEW_RATE");
		int REVIEW_COUNT = Integer.parseInt(request.getParameter("REVIEW_COUNT"));

		REVIEW review = new REVIEW();
		review.setMEMBER_CODE(MEMBER_CODE);
		review.setLECTURE_CODE(LECTURE_CODE);
		review.setREVIEW_WRITER(REVIEW_WRITER);
		review.setREVIEW_TITLE(REVIEW_TITLE);
		review.setREVIEW_CONTENT(REVIEW_CONTENT);
		review.setREVIEW_RATE(REVIEW_RATE);

		int res = reviewBiz.insertReview(review);

		LECTURE lecture = biz.selectLectureDetail(LECTURE_CODE);

		lecture.setLECTURE_RATE(Double.toString(
				(Double.parseDouble(lecture.getLECTURE_RATE()) * REVIEW_COUNT + Double.parseDouble(REVIEW_RATE))
						/ (REVIEW_COUNT + 1)));
		lecture.setLECTURE_READCOUNT(lecture.getLECTURE_READCOUNT() + 1); // READCOUNT는 후기의 갯수로 사용,,,
		System.out.println(lecture.getLECTURE_READCOUNT());
		int Rres = biz.updateRate(lecture);

		if (res > 0 && Rres > 0) {
			jsResponse("후기 작성", "/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + LECTURE_CODE, response);
		} else {
			jsResponse("후기 작성 실패", "/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + LECTURE_CODE, response);
		}
	}

	// 후기 업데이트 요청
	private void doUpdateReview(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int REVIEW_CODE = Integer.parseInt(request.getParameter("REVIEW_CODE"));
		int LECTURE_CODE = Integer.parseInt(request.getParameter("LECTURE_CODE"));
		String REVIEW_TITLE = request.getParameter("REVIEW_TITLE");
		String REVIEW_CONTENT = request.getParameter("REVIEW_CONTENT");

		REVIEW newReview = new REVIEW();
		newReview.setREVIEW_CODE(REVIEW_CODE);
		newReview.setLECTURE_CODE(LECTURE_CODE);
		newReview.setREVIEW_TITLE(REVIEW_TITLE);
		newReview.setREVIEW_CONTENT(REVIEW_CONTENT);
		System.out.println(newReview);
		int res = reviewBiz.updateReview(newReview);
		if (res > 0) {
			jsResponse("후기 수정", "/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + LECTURE_CODE, response);
		} else {
			jsResponse("후기 수정 실패", "/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + LECTURE_CODE, response);
		}
	}

	// 후기 삭제 요청
	private void doDeleteReview(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int REVIEW_CODE = Integer.parseInt(request.getParameter("REVIEW_CODE"));
		int LECTURE_CODE = Integer.parseInt(request.getParameter("LECTURE_CODE"));
		double REVIEW_RATE = Double.parseDouble(request.getParameter("REVIEW_RATE"));
		int REVIEW_COUNT = Integer.parseInt(request.getParameter("REVIEW_COUNT"));

		int res = reviewBiz.deleteReview(REVIEW_CODE);

		LECTURE lecture = biz.selectLectureDetail(LECTURE_CODE);
		if (REVIEW_COUNT == 1) {
			lecture.setLECTURE_RATE("0");
		} else {
			lecture.setLECTURE_RATE(Double.toString(
					(Double.parseDouble(lecture.getLECTURE_RATE()) * REVIEW_COUNT - REVIEW_RATE) / (REVIEW_COUNT - 1)));
		}

		lecture.setLECTURE_READCOUNT(lecture.getLECTURE_READCOUNT() - 1); // READCOUNT는 후기의 갯수로 사용,,,

		int Rres = biz.updateRate(lecture);

		if (res > 0 && Rres > 0) {
			jsResponse("후기 삭제", "/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + LECTURE_CODE, response);
		} else {
			jsResponse("후기 삭제 실패", "/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + LECTURE_CODE, response);
		}
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
