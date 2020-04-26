package com.map;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.map.biz.MemberBiz;
import com.map.biz.MemberBizImpl;
import com.map.dto.MemberDto;

@WebServlet(//
	name = "member", // Controller Mapping name
	//
	urlPatterns = { //
			"map.do",
			"privacyprofilegpsupdate.do", // 계정관리(정보) 업데이트
	//////////
	})
public class controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	MemberBiz biz = new MemberBizImpl();
	
	public controller() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("<" + command + ">");
		/*
		 * 회원가입 관련 요청
		 */
		if(command.endsWith("/map.do")) {
			doMapPage(request,response);
		}
		else if (command.endsWith("/privacyprofilegpsupdate.do")) {
			doPrivacyProfileGpsUpdate(request, response); // 계정관리(위치정보) 업데이트
		}
	}

	private void doMapPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<MemberDto> List = biz.selectList();

		request.setAttribute("studyList", List);

		dispatch("/map.jsp", request, response);
		
	}

	// 계정관리(위치정보) 수정처리
		@SuppressWarnings("unchecked")
		private void doPrivacyProfileGpsUpdate(HttpServletRequest request, HttpServletResponse response)
				throws IOException {
			String MEMBER_PROFILE_LATITUDE = request.getParameter("MEMBER_PROFILE_LATITUDE");
			String MEMBER_PROFILE_LOGITUDE = request.getParameter("MEMBER_PROFILE_LOGITUDE");

			MemberDto member_profile = new MemberDto();

			member_profile.setMEMBER_PROFILE_LATITUDE(MEMBER_PROFILE_LATITUDE);
			member_profile.setMEMBER_PROFILE_LOGITUDE(MEMBER_PROFILE_LOGITUDE);

			int res = biz.insert(member_profile);

//			if (res > 0) {
//				// 프로필 정보를 session에 리셋
//				session = request.getSession();
//				MEMBER_PROFILE new_member_profile = biz.selectMemberProfile(MEMBER_CODE);
//				session.removeAttribute("member_profile");
//				session.setAttribute("member_profile", new_member_profile);
//			}

			JSONObject obj = new JSONObject();
			obj.put("res", res);
			PrintWriter out = response.getWriter();
			out.println(obj);

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