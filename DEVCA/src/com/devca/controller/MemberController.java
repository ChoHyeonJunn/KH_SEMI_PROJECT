package com.devca.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.security.InvalidKeyException;
import java.security.PrivateKey;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.devca.model.biz.member.MemberBiz;
import com.devca.model.biz.member.MemberBizImpl;
import com.devca.model.dto.member.KAKAO_MEMBER;
import com.devca.model.dto.member.MEMBER;
import com.devca.model.dto.member.MEMBER_PROFILE;
import com.devca.model.dto.member.NAVER_MEMBER;
import com.devca.utility.email.Email;
import com.devca.utility.email.Random;
import com.devca.utility.rsa.RSA;
import com.devca.utility.rsa.RSAUtil;
import com.devca.utility.sha.SHA256_Util;
import com.devca.utility.siot.IamportRestClient.IamportClient;
import com.devca.utility.siot.IamportRestClient.exception.IamportResponseException;
import com.devca.utility.siot.IamportRestClient.request.ScheduleData;
import com.devca.utility.siot.IamportRestClient.request.ScheduleEntry;
import com.devca.utility.siot.IamportRestClient.response.IamportResponse;
import com.devca.utility.siot.IamportRestClient.response.Schedule;
import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet(//
		name = "member", // Controller Mapping name
		//
		urlPatterns = { //
				"joinpage.do", // 회원가입 창으로 이동
				"join.do", // 회원가입 요청 처리
				"snsjoin.do", // SNS 회원가입 요청처리
				"nameconfirm.do", // 이름 중복체크
				"emailconfirm.do", // 이메일 중복체크
				"emailAuth.do", // 이메일 인증
				//////////
				"loginpage.do", // 로그인 페이지로 이동
				"login.do", // 로그인 요청 처리
				"loginsns.do", // SNS 로 로그인
				"issnsmember.do", // SNS 로 가입된 이메일이 존재하는지 체크
				"logout.do", // 로그아웃 요청 처리
				//////////
				"privacyprofilepage.do", // 계정관리(정보) 페이지로 이동
				"privacyprofileupdate.do", // 계정관리(정보) 업데이트
				"privacypasswordpage.do", // 계정관리(비밀번호) 페이지로 이동
				"privacypasswordupdate.do", // 계정관리(비밀번호) 수정 처리
				"privacypasswordresetpage.do", // 계정관리(비밀번호 재설정) 페이지로 이동
				"privacypasswordresetemail.do", // 계정관리(비밀번호 재설정) 이메일 발신 처리
				"privacypasswordresetemailpage.do", // 계정관리(비밀번호 재설정) 이메일을 통해 접근한 페이지
				"privacypaymentpage.do", // 계정관리(결제관리) 페이지로 이동
		//////////
		})
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	HttpSession session;
	MemberBiz biz = new MemberBizImpl();
	RSAUtil rsaUtil = new RSAUtil();

	// 아임포트 api key 설정
	IamportClient client = new IamportClient("5977466163046719",
			"xCXloO7UNQDhshr6FryjaKe7qxA2SPwpruKQiSL5IonaGOglgPEqATy0q93jYzIq3thml2s3rPe7EvtU");

	private String getRandomMerchantUid() {
		DateFormat df = new SimpleDateFormat("$$hhmmssSS");
		int n = (int) (Math.random() * 100) + 1;

		return df.format(new Date()) + "_" + n;
	}

	public MemberController() {
		super();
	}

	private void getRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("<" + command + ">");
		/*
		 * 회원가입 관련 요청
		 */
		if (command.endsWith("/joinpage.do")) {
			doJoinPage(request, response); // 회원가입 창으로 이동
		} else if (command.endsWith("/join.do")) {
			doJoin(request, response); // 회원가입 요청 처리
		} else if (command.endsWith("/snsjoin.do")) {
			doSNSJoin(request, response); // SNS 회원가입 요청처리
		} else if (command.endsWith("nameconfirm.do")) {
			doNameConfirm(request, response); // 이름 중복체크
		} else if (command.endsWith("emailconfirm.do")) {
			doEmailConfirm(request, response); // 이메일 중복체크
		} else if (command.endsWith("emailAuth.do")) {
			doEmailAuth(request, response); // 이메일 인증
		}

		/*
		 * 로그인 관련 요청
		 */
		else if (command.endsWith("/loginpage.do")) {
			doLoginPage(request, response); // 로그인 페이지로 이동
		} else if (command.endsWith("/login.do")) {
			doLogin(request, response); // 로그인 요청 처리
		} else if (command.endsWith("/loginsns.do")) {
			doLoginSns(request, response); // SNS 로 로그인
		} else if (command.endsWith("/issnsmember.do")) {
			doIsSnsMember(request, response); // SNS 로 가입된 이메일이 존재하는지 체크
		} else if (command.endsWith("/logout.do")) {
			doLogout(request, response); // 로그아웃 요청 처리

		}

		/*
		 * 기타 요청
		 */
		else if (command.endsWith("/privacyprofilepage.do")) {
			doPrivacyProfilePage(request, response); // 계정관리(정보) 페이지로 이동
		} else if (command.endsWith("/privacyprofileupdate.do")) {
			doPrivacyProfileUpdate(request, response); // 계정관리(정보) 업데이트
		} else if (command.endsWith("/privacyprofileimageupdate.do")) {
			doPrivacyProfileImageUpdate(request, response); // 계정관리(이미지) 업데이트
		} else if (command.endsWith("/privacyprofilegpsupdate.do")) {
			doPrivacyProfileGpsUpdate(request, response); // 계정관리(위치정보) 업데이트
		} else if (command.endsWith("/privacypasswordpage.do")) {
			doPrivacyPasswordPage(request, response); // 계정관리(비밀번호) 페이지로 이동
		} else if (command.endsWith("/privacypasswordupdate.do")) {
			doPrivacyPasswordUpdate(request, response); // 계정관리(비밀번호) 수정 처리
		} else if (command.endsWith("/privacypasswordresetpage.do")) {
			doPrivacyPasswordResetPage(request, response); // 계정관리(비밀번호 재설정) 페이지로 이동
		} else if (command.endsWith("/privacypasswordresetemail.do")) {
			doPrivacyPasswordResetEmail(request, response); // 계정관리(비밀번호 재설정) 이메일 발신 처리
		} else if (command.endsWith("/privacypasswordresetemailpage.do")) {
			doPrivacyPasswordResetEmailPage(request, response); // 계정관리(비밀번호 재설정) 이메일을 통해 접근한 페이지
		} else if (command.endsWith("/privacypaymentpage.do")) {
			doPrivacyPaymentPage(request, response); // 계정관리(결제관리) 페이지로 이동
		} else if (command.endsWith("/privacypaymentpageRegular.do")) {
			doPrivacyPaymentPageRegular(request, response); // 계정관리(결제관리) 정기결제 처리
		} else if (command.endsWith("/privacypaymentpageUpdateMemberRole.do")) {
			doPrivacyPaymentPageUpdateMemberRole(request, response); // 계정관리(결제관리) 정기결제 처리후 회원등급 up
		} else if (command.endsWith("/searchMemberEmailName.do")) {
			doSearchMemberEmailName(request, response); // email or name 검색 자동완성 ajax
		} else {
			doError(request, response); // 에러 처리
		}
	}

	// 회원가입 페이지
	private void doJoinPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 기존 생성되어있는 privateKey가 있다면 session에서 파기!
		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") != null)
			session.removeAttribute("RSAprivateKey");

		// 새로운 rsa 객체 생성
		RSA rsa = rsaUtil.createRSA();
		request.setAttribute("modulus", rsa.getModulus());
		request.setAttribute("exponent", rsa.getExponent());
		session.setAttribute("RSAprivateKey", rsa.getPrivateKey());

		dispatch("/views/member/joinpage.jsp", request, response);
	}

	// 회원가입
	private void doJoin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MEMBER member = new MEMBER();
		PrivateKey privateKey = null;

		if (session.getAttribute("RSAprivateKey") == null) {
			jsResponse("session 에 RSAprivateKey가 존재하지 않습니다!!", "/DEVCA/member/loginpage.do", response);
		} else {
			privateKey = (PrivateKey) session.getAttribute("RSAprivateKey");
		}

		try {
			String MEMBER_NAME = rsaUtil.getDecryptText(privateKey, request.getParameter("MEMBER_NAME"));
			String MEMBER_EMAIL = rsaUtil.getDecryptText(privateKey, request.getParameter("MEMBER_EMAIL"));
			String MEMBER_PW = rsaUtil.getDecryptText(privateKey, request.getParameter("MEMBER_PW"));
			String MEMBER_PHONE = rsaUtil.getDecryptText(privateKey, request.getParameter("MEMBER_PHONE"));

			member.setMEMBER_NAME(MEMBER_NAME);
			member.setMEMBER_EMAIL(MEMBER_EMAIL);
			member.setMEMBER_PW(MEMBER_PW);
			member.setMEMBER_PHONE(MEMBER_PHONE);

		} catch (InvalidKeyException | IllegalBlockSizeException | BadPaddingException
				| UnsupportedEncodingException e) {
			e.printStackTrace();
		}

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
//				session = request.getSession();
//				session.setAttribute("loginKakao", kakao_member);
//				session.setAttribute("access_token", access_token);
				jsResponse("KAKAO 회원가입 성공", "/DEVCA/main/loginpage.do", response);
			} else {
				jsResponse("KAKAO 회원가입 실패", "/DEVCA/member/joinpage.do", response);
			}
		}
		if (snsType.equals("NAVER")) {

			NAVER_MEMBER naver_member = new NAVER_MEMBER();

			naver_member.setMEMBER_NAME(MEMBER_NAME);
			naver_member.setMEMBER_EMAIL(MEMBER_EMAIL);
			naver_member.setMEMBER_PHONE(MEMBER_PHONE);

			naver_member.setNAVER_ID(SNS_ID);
			naver_member.setNAVER_NICKNAME(SNS_NICKNAME);

			int res = biz.naverJoin(naver_member);

			if (res > 0) {
				// test 회원가입 후 바로 로그인
//				session = request.getSession();
//				session.setAttribute("loginNaver", naver_member);
				jsResponse("NAVER 회원가입 성공", "/DEVCA/main/loginpage.do", response);
			} else {
				jsResponse("NAVER 회원가입 실패", "/DEVCA/member/joinpage.do", response);
			}
		}
	}

	// 이름 중복체크
	@SuppressWarnings("unchecked")
	private void doNameConfirm(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String MEMBER_NAME = request.getParameter("MEMBER_NAME");

		int result = biz.nameConfirm(MEMBER_NAME);

		JSONObject obj = new JSONObject();
		obj.put("result", result);
		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 이메일 중복체크
	@SuppressWarnings("unchecked")
	private void doEmailConfirm(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String MEMBER_EMAIL = request.getParameter("MEMBER_EMAIL");

		int result = biz.emailConfirm(MEMBER_EMAIL);

		JSONObject obj = new JSONObject();
		obj.put("result", result);
		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 이메일 인증
	@SuppressWarnings({ "static-access", "unchecked" })
	private void doEmailAuth(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String email = request.getParameter("MEMBER_EMAIL");
		String authNum = "";

		Random random = new Random();
		authNum = random.RandomNum();

		Email sendEmail = new Email();

		sendEmail.sendEmail(email, authNum);

		JSONObject obj = new JSONObject();
		obj.put("result", 1);
		obj.put("authNum", authNum);
		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 로그인 페이지
	private void doLoginPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 기존 생성되어있는 privateKey가 있다면 session에서 파기!
		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") != null)
			session.removeAttribute("RSAprivateKey");

		// 새로운 rsa 객체 생성
		RSA rsa = rsaUtil.createRSA();
		request.setAttribute("modulus", rsa.getModulus());
		request.setAttribute("exponent", rsa.getExponent());
		session.setAttribute("RSAprivateKey", rsa.getPrivateKey());

		dispatch("/views/member/loginpage.jsp", request, response);
	}

	// 로그인
	@SuppressWarnings("unchecked")
	private void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MEMBER member = new MEMBER();
		PrivateKey privateKey = null;

		if (session.getAttribute("RSAprivateKey") == null) {
			jsResponse("session 에 RSAprivateKey가 존재하지 않습니다!!", "/DEVCA/member/loginpage.do", response);
		} else {
			privateKey = (PrivateKey) session.getAttribute("RSAprivateKey");
		}

		try {
			String MEMBER_EMAIL = rsaUtil.getDecryptText(privateKey, request.getParameter("MEMBER_EMAIL"));
			String MEMBER_PW = rsaUtil.getDecryptText(privateKey, request.getParameter("MEMBER_PW"));

			member.setMEMBER_EMAIL(MEMBER_EMAIL);
			member.setMEMBER_PW(MEMBER_PW);
		} catch (InvalidKeyException | IllegalBlockSizeException | BadPaddingException
				| UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		MEMBER loginMember = biz.memberLogin(member);

		int result = 0;
		if (loginMember != null) {
			MEMBER_PROFILE member_profile = biz.selectMemberProfile(loginMember.getMEMBER_CODE());

			session = request.getSession();
			session.setAttribute("loginMember", loginMember);
			session.setAttribute("member_profile", member_profile);
			session.removeAttribute("RSAprivateKey");
			result = 1;
		}
		JSONObject obj = new JSONObject();
		obj.put("result", result);
		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// KAKAO SNS 로 로그인
	private void doLoginSns(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String snsType = request.getParameter("snsType");
		String SNS_ID = request.getParameter("SNS_ID");
		if (snsType.equals("KAKAO")) {
			KAKAO_MEMBER kakao_member = new KAKAO_MEMBER();

			kakao_member.setKAKAO_ID(SNS_ID);
			KAKAO_MEMBER kakao_loginMember = biz.memberLogin(kakao_member);

			if (kakao_loginMember != null) {
				MEMBER_PROFILE member_profile = biz.selectMemberProfile(kakao_loginMember.getMEMBER_CODE());

				String access_token = request.getParameter("access_token");

				session = request.getSession();
				session.setAttribute("loginKakao", kakao_loginMember);
				session.setAttribute("member_profile", member_profile);
				session.setAttribute("access_token", access_token);
				session.removeAttribute("RSAprivateKey");

				jsResponse("로그인 성공", "/DEVCA/main/mainpage.do", response);
			} else {
				jsResponse("로그인 실패", "/DEVCA/member/loginpage.do", response);
			}
		}
		if (snsType.equals("NAVER")) {
			NAVER_MEMBER naver_member = new NAVER_MEMBER();

			naver_member.setNAVER_ID(SNS_ID);
			NAVER_MEMBER naver_loginMember = biz.memberLogin(naver_member);

			if (naver_loginMember != null) {
				MEMBER_PROFILE member_profile = biz.selectMemberProfile(naver_loginMember.getMEMBER_CODE());

				session = request.getSession();
				session.setAttribute("loginNaver", naver_loginMember);
				session.setAttribute("member_profile", member_profile);
				session.removeAttribute("RSAprivateKey");

				jsResponse("로그인 성공", "/DEVCA/main/mainpage.do", response);
			} else {
				jsResponse("로그인 실패", "/DEVCA/member/loginpage.do", response);
			}
		}

	}

	// SNS로 가입된 ID 존재하는지 체크
	@SuppressWarnings("unchecked")
	private void doIsSnsMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String snsType = request.getParameter("snsType");
		String SNS_ID = request.getParameter("SNS_ID");

		int issns = 0;
		if (snsType.equals("KAKAO")) {
			issns = biz.isKakaoMember(SNS_ID);
		}
		if (snsType.equals("NAVER")) {
			issns = biz.isNaverMember(SNS_ID);
		}

		JSONObject obj = new JSONObject();
		obj.put("issns", issns);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 로그아웃
	private void doLogout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().invalidate();
		jsResponse("로그아웃", "/DEVCA/main/mainpage.do", response);
	}

	// 계정관리(정보) 페이지로 이동
	private void doPrivacyProfilePage(HttpServletRequest request, HttpServletResponse response)
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

		MEMBER_PROFILE member = biz.selectMemberProfile(MEMBER_CODE);
		request.setAttribute("member", member);
		dispatch("/views/member/privacyprofilepage.jsp", request, response);
	}

	// 계정관리(정보) 수정처리
	private void doPrivacyProfileUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		MEMBER_PROFILE member_profile = new MEMBER_PROFILE();

		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		String MEMBER_NAME = request.getParameter("MEMBER_NAME");
		String MEMBER_PHONE = request.getParameter("MEMBER_PHONE");

		String MEMBER_PROFILE_INTRODUCE = request.getParameter("MEMBER_PROFILE_INTRODUCE");
		String MEMBER_PROFILE_HOMEPAGE = request.getParameter("MEMBER_PROFILE_HOMEPAGE");
		String MEMBER_PROFILE_AREA = request.getParameter("MEMBER_PROFILE_AREA");

		member_profile.setMEMBER_CODE(MEMBER_CODE);

		member_profile.setMEMBER_NAME(MEMBER_NAME);
		member_profile.setMEMBER_PHONE((MEMBER_PHONE == null) ? "" : MEMBER_PHONE);

		member_profile.setMEMBER_PROFILE_INTRODUCE((MEMBER_PROFILE_INTRODUCE == null) ? "" : MEMBER_PROFILE_INTRODUCE);
		member_profile.setMEMBER_PROFILE_HOMEPAGE((MEMBER_PROFILE_HOMEPAGE == null) ? "" : MEMBER_PROFILE_HOMEPAGE);
		member_profile.setMEMBER_PROFILE_AREA((MEMBER_PROFILE_AREA == null) ? "" : MEMBER_PROFILE_AREA);

		int resP = biz.updateMemberProfile(member_profile);
		int resM = biz.updateMember(member_profile);
		if (resP > 0 && resM > 0) {
			jsResponse("프로필 수정", "/DEVCA/member/privacyprofilepage.do", response);
		} else {
			jsResponse("프로필 수정 실패", "/DEVCA/member/privacyprofilepage.do", response);
		}

	}

	// 계정관리(정보: 이미지) 수정처리
	@SuppressWarnings("unchecked")
	private void doPrivacyProfileImageUpdate(HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		// 업로드될 경로
		String filePath = "/resources/images/profileupload/";

		// 업로드될 실제 경로 (이클립스 상의 절대경로)
		String FILE_PATH = request.getSession().getServletContext().getRealPath(filePath);
		System.out.println("절대경로 : " + FILE_PATH);

		String encoding = "UTF-8";
		int maxSize = 1024 * 1024 * 3;

		MultipartRequest mr = null;

		try {

			mr = new MultipartRequest(request, FILE_PATH, // 파일이 저장될 폴더
					maxSize, // 최대 업로드크기 (5MB)
					encoding, // 인코딩 방식
					new DefaultFileRenamePolicy() // 동일한 파일명이 존재하면 파일명 뒤에 일련번호를 부여
			);

		} catch (IOException e1) {
			System.out.println("[ ERROR ] : BoardController - MultipartRequest 객체 생성 오류");
			e1.printStackTrace();
		}

		MEMBER_PROFILE member_profile = new MEMBER_PROFILE();

		// 파라미터 받기
		int MEMBER_CODE = Integer.parseInt(mr.getParameter("MEMBER_CODE"));
		// 파일 첨부
		String MEMBER_PROFILE_IMAGE_S_NAME = null;
		String MEMBER_PROFILE_IMAGE_NAME = null;
		String imgExtend = null;

		// 실제 저장된 파일명
		MEMBER_PROFILE_IMAGE_S_NAME = mr.getFilesystemName("MEMBER_PROFILE_IMAGE_NAME");

		if (MEMBER_PROFILE_IMAGE_S_NAME != null) {
			// 원래 이미지 이름
			MEMBER_PROFILE_IMAGE_NAME = mr.getOriginalFileName("MEMBER_PROFILE_IMAGE_NAME");

			// 이미지 확장자
			imgExtend = MEMBER_PROFILE_IMAGE_S_NAME.substring(MEMBER_PROFILE_IMAGE_S_NAME.lastIndexOf(".") + 1);

			if (!imgExtend.equals("jpg") && !imgExtend.equals("png") && !imgExtend.equals("jpeg")) {
				jsResponse("이미지만 첨부 가능합니다.", "/DEVCA/member/privacyprofilepage.jsp", response);
			}
		}

		member_profile.setMEMBER_CODE(MEMBER_CODE);

		member_profile.setMEMBER_PROFILE_IMAGE_NAME((MEMBER_PROFILE_IMAGE_NAME == null) ? "" : MEMBER_PROFILE_IMAGE_NAME);
		member_profile.setMEMBER_PROFILE_IMAGE_S_NAME(
				(MEMBER_PROFILE_IMAGE_S_NAME == null) ? "" : MEMBER_PROFILE_IMAGE_S_NAME);
		member_profile.setMEMBER_PROFILE_PATH(FILE_PATH);

		int res = biz.updateMemberProfileImage(member_profile);

		JSONObject obj = new JSONObject();
		obj.put("res", res);
		obj.put("img", biz.selectMemberProfile(MEMBER_CODE).getMEMBER_PROFILE_IMAGE_S_NAME());
		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 계정관리(위치정보) 수정처리
	@SuppressWarnings("unchecked")
	private void doPrivacyProfileGpsUpdate(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		String MEMBER_PROFILE_LATITUDE = request.getParameter("MEMBER_PROFILE_LATITUDE");
		String MEMBER_PROFILE_LOGITUDE = request.getParameter("MEMBER_PROFILE_LOGITUDE");

		MEMBER_PROFILE member_profile = new MEMBER_PROFILE();

		member_profile.setMEMBER_CODE(MEMBER_CODE);
		member_profile.setMEMBER_PROFILE_LATITUDE(MEMBER_PROFILE_LATITUDE);
		member_profile.setMEMBER_PROFILE_LOGITUDE(MEMBER_PROFILE_LOGITUDE);

		int res = biz.updateMemberProfileGps(member_profile);

		JSONObject obj = new JSONObject();
		obj.put("res", res);
		PrintWriter out = response.getWriter();
		out.println(obj);

	}

	// 계정관리(비밀번호) 페이지로 이동
	private void doPrivacyPasswordPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 기존 생성되어있는 privateKey가 있다면 session에서 파기!
		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") != null)
			session.removeAttribute("RSAprivateKey");

		// 새로운 rsa 객체 생성
		RSA rsa = rsaUtil.createRSA();
		request.setAttribute("modulus", rsa.getModulus());
		request.setAttribute("exponent", rsa.getExponent());
		session.setAttribute("RSAprivateKey", rsa.getPrivateKey());

		dispatch("/views/member/privacypasswordpage.jsp", request, response);
	}

	// 계정관리 비밀번호 수정 처리
	private void doPrivacyPasswordUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String MEMBER_PW = request.getParameter("MEMBER_PW");
		String NEW_MEMBER_PW = request.getParameter("NEW_MEMBER_PW");
		PrivateKey privateKey = null;

		if (session.getAttribute("RSAprivateKey") == null) {
			jsResponse("session 에 RSAprivateKey가 존재하지 않습니다!!", "/DEVCA/member/loginpage.do", response);
		} else {
			privateKey = (PrivateKey) session.getAttribute("RSAprivateKey");
		}

		System.out.println(MEMBER_PW + " : " + NEW_MEMBER_PW);

		try {
			if (MEMBER_PW != null) {
				MEMBER_PW = rsaUtil.getDecryptText(privateKey, MEMBER_PW);
			}
			NEW_MEMBER_PW = rsaUtil.getDecryptText(privateKey, NEW_MEMBER_PW);
		} catch (InvalidKeyException | IllegalBlockSizeException | BadPaddingException
				| UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println(MEMBER_PW + " : " + NEW_MEMBER_PW);

		session = request.getSession();
		int MEMBER_CODE = 0;
		if (session.getAttribute("loginMember") != null) {
			MEMBER_CODE = ((MEMBER) session.getAttribute("loginMember")).getMEMBER_CODE();
			MEMBER_PROFILE member = biz.selectMemberProfile(MEMBER_CODE);

			if (MEMBER_PW == null) {
				System.out.println("이메일을 통해 비밀번호를 바꾸러와서 기존 비밀번호가 null 이구나,,,");
				member.setMEMBER_PW(NEW_MEMBER_PW);
				int res = biz.updateMemberPassword(member);

				if (res > 0) {
					request.getSession().invalidate();
					jsResponse("비밀번호 변경, 다시 로그인해주세요", "/DEVCA/main/mainpage.do", response);
				} else {
					jsResponse("비밀번호 변경 실패", "/DEVCA/member/privacypasswordpage.do", response);
				}
			} else if (member.getMEMBER_PW().equals(new SHA256_Util().encryptSHA256(MEMBER_PW))) {
				member.setMEMBER_PW(NEW_MEMBER_PW);
				int res = biz.updateMemberPassword(member);

				if (res > 0) {
					request.getSession().invalidate();
					jsResponse("비밀번호 변경, 다시 로그인해주세요", "/DEVCA/main/mainpage.do", response);
				} else {
					jsResponse("비밀번호 변경 실패", "/DEVCA/member/privacypasswordpage.do", response);
				}
			} else {
				jsResponse("현재 비밀번호가 일치하지 않습니다.", "/DEVCA/member/privacypasswordpage.do", response);

			}
		} else {
			jsResponse("로그인 세션이 만료되었습니다.", "/DEVCA/main/mainpage.do", response);
		}
	}

	// 계정관리(비밀번호 변경 이메일) 페이지로 이동
	private void doPrivacyPasswordResetPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 기존 생성되어있는 privateKey가 있다면 session에서 파기!
		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") != null)
			session.removeAttribute("RSAprivateKey");

		// 새로운 rsa 객체 생성
		RSA rsa = rsaUtil.createRSA();
		request.setAttribute("modulus", rsa.getModulus());
		request.setAttribute("exponent", rsa.getExponent());
		session.setAttribute("RSAprivateKey", rsa.getPrivateKey());

		dispatch("/views/member/privacypasswordresetpage.jsp", request, response);
	}

	// 계정관리(비밀번호 변경 이메일) 페이지로 이동
	@SuppressWarnings("static-access")
	private void doPrivacyPasswordResetEmail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("MEMBER_EMAIL");
		String MEMBER_NAME = request.getParameter("MEMBER_NAME");

		Email sendEmail = new Email();
		sendEmail.sendPwEmail(email, MEMBER_NAME);

		jsResponse("비밀번호 설정 메일 발신", "/DEVCA/main/mainpage.do", response);
	}

	// 계정관리(비밀번호 변경 이메일) 페이지로 이동
	private void doPrivacyPasswordResetEmailPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 기존 생성되어있는 privateKey가 있다면 session에서 파기!
		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") != null)
			session.removeAttribute("RSAprivateKey");

		// 새로운 rsa 객체 생성
		RSA rsa = rsaUtil.createRSA();
		request.setAttribute("modulus", rsa.getModulus());
		request.setAttribute("exponent", rsa.getExponent());
		session.setAttribute("RSAprivateKey", rsa.getPrivateKey());

		System.out.println("이메일을 통해 비밀번호를 바꾸러 왔구나,,,");
		dispatch("/views/member/privacypasswordresetemail.jsp", request, response);
	}

	// 계정관리(결제) 페이지로 이동
	private void doPrivacyPaymentPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/member/privacypaymentpage.jsp", request, response);
	}

	// 계정관리(결제) 정기결제 처리 (6개월)
	private void doPrivacyPaymentPageRegular(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		JSONObject obj = new JSONObject();

		String customer_uid = request.getParameter("customer_uid");
//		String merchant_uid = request.getParameter("merchant_uid");
		int amount = Integer.parseInt(request.getParameter("amount"));
//		String schedule_at = request.getParameter("schedule_at");

		ScheduleData schedule_data = new ScheduleData(customer_uid);

		Calendar cal = Calendar.getInstance();

		cal.add(Calendar.SECOND, 30);
		Date d1 = cal.getTime();

		cal.add(Calendar.SECOND, 30);
		Date d2 = cal.getTime();

		cal.add(Calendar.SECOND, 30);
		Date d3 = cal.getTime();

		cal.add(Calendar.SECOND, 30);
		Date d4 = cal.getTime();

		cal.add(Calendar.SECOND, 30);
		Date d5 = cal.getTime();

		cal.add(Calendar.SECOND, 30);
		Date d6 = cal.getTime();

		System.out.println("time : " + d1);
		System.out.println("time : " + d2);
		System.out.println("time : " + d3);
		System.out.println("time : " + d4);
		System.out.println("time : " + d5);
		System.out.println("time : " + d6);
		// System.out.println("customer_uid : " + customer_uid);

		schedule_data.addSchedule(new ScheduleEntry(getRandomMerchantUid(), d1, BigDecimal.valueOf(100)));
		schedule_data.addSchedule(new ScheduleEntry(getRandomMerchantUid(), d2, BigDecimal.valueOf(100)));
		schedule_data.addSchedule(new ScheduleEntry(getRandomMerchantUid(), d3, BigDecimal.valueOf(100)));
		schedule_data.addSchedule(new ScheduleEntry(getRandomMerchantUid(), d4, BigDecimal.valueOf(100)));
		schedule_data.addSchedule(new ScheduleEntry(getRandomMerchantUid(), d5, BigDecimal.valueOf(100)));
		schedule_data.addSchedule(new ScheduleEntry(getRandomMerchantUid(), d6, BigDecimal.valueOf(100)));

		try {
			IamportResponse<List<Schedule>> schedule_response = client.subscribeSchedule(schedule_data);
			System.out.println("결제 예약 성공!");
			obj.put("result", schedule_response.toString());
			PrintWriter out = response.getWriter();
			out.println(obj);

		} catch (IamportResponseException | IOException e) {
			e.printStackTrace();
			System.out.println("결제 예약 실패!");
			obj.put("result", "0");
			PrintWriter out = response.getWriter();
			out.println(obj);
		}
	}

	// 계정관리(결제관리) 정기결제 처리후 회원등급 up
	private void doPrivacyPaymentPageUpdateMemberRole(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		int res = biz.updateMemberRole(MEMBER_CODE);
		
		MEMBER_PROFILE member_profile = biz.selectMemberProfile(MEMBER_CODE);
		
		// 세션 수정
		session = request.getSession();
		session.removeAttribute("member_profile");
		session.setAttribute("member_profile", member_profile);
		
		// ajax 응답
		JSONObject obj = new JSONObject();
		obj.put("res", res);
		PrintWriter out = response.getWriter();
		out.println(obj);

	}

	// email or name 검색 자동완성 ajax
	private void doSearchMemberEmailName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String EMAIL_NAME = request.getParameter("EMAIL_NAME");
		int MY_MEMBER_CODE = 0;

		if (request.getParameter("MY_MEMBER_CODE") != null && request.getParameter("MY_MEMBER_CODE") != "")
			MY_MEMBER_CODE = Integer.parseInt(request.getParameter("MY_MEMBER_CODE"));

		List<MEMBER_PROFILE> searchProfileList = biz.searchMemberEmailName(EMAIL_NAME, MY_MEMBER_CODE);

		Gson gson = new Gson();
		String jsonList = gson.toJson(searchProfileList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
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