package com.devca.model.biz.member;

import com.devca.model.dao.member.MemberDao;
import com.devca.model.dao.member.MemberDaoImpl;
import com.devca.model.dto.member.KAKAO_MEMBER;
import com.devca.model.dto.member.MEMBER;
import com.devca.model.dto.member.MEMBER_PROFILE;
import com.devca.model.dto.member.NAVER_MEMBER;
import com.devca.model.dto.member.ROADMAP;
import com.devca.utility.sha.SHA256_Util;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

public class MemberBizImpl implements MemberBiz {

	MemberDao dao = new MemberDaoImpl();

	private final String FrontEnd = "[" + "{name: 'General', children: ["
			+ "	{name: 'Git', value: 3},{name: 'Github', value: 3}" + "]}," + "{name: 'Language', children: ["
			+ "	{name: 'JavaScript', value: 3},{name: 'HTML', value: 3},{name: 'CSS', value: 3}" + "]},"
			+ "{name: 'FrameWork&Library', children: ["
			+ "	{name: 'React.js', value: 3},{name: 'Vue.js', value: 3},{name: 'Angular.js', value: 3},{name: 'BootStrap', value: 3},{name: 'jQuery', value: 3}"
			+ "]}" + "]";
	private final String BackEnd = "[" + "{name: 'General', children: ["
			+ "	{name: 'Git', value: 3},{name: 'Github', value: 3},{name: 'Maven', value: 3},{name: 'Linux', value: 3}"
			+ "]}," + "{name: 'Language', children: [" + "	{name: 'Java', value: 3}" + "]},"
			+ "{name: 'FrameWork', children: [" + "	{name: 'Spring', value: 3}" + "]}," + "{name: 'Web', children: ["
			+ "	{name: 'WAS', value: 3}" + "]}," + "{name: 'DB', children: [" + "	{name: 'Oracle', value: 3}" + "]},"
			+ "{name: 'Library', children: [" + "	{name: 'ORM', value: 3},{name: 'Mybatis', value: 3}" + "]}" + "]";
	private final String FullStack = "[" + "{name: 'General', children: ["
			+ "	{name: 'Git', value: 3},{name: 'Github', value: 3},{name: 'Maven', value: 3},{name: 'Linux', value: 3}"
			+ "]}," + "{name: 'Language', children: ["
			+ "	{name: 'Java', value: 3},{name: 'JavaScript', value: 3},{name: 'HTML', value: 3},{name: 'CSS', value: 3}"
			+ "]}," + "{name: 'Library', children: ["
			+ "	{name: 'ORM', value: 3},{name: 'Mybatis', value: 3},{name: 'BootStrap', value: 3}" + "]},"
			+ "{name: 'Framework', children: [" + "	{name: 'Spring', value: 3}" + "]}," + "{name: 'Web', children: ["
			+ "	{name: 'WAS', value: 3}" + "]}," + "{name: 'DB', children: ["
			+ "	{name: 'Oracle', value: 3},{name: 'MongoDB', value: 3}" + "]}," + "]";

	/*
	 * 회원가입 코드
	 */
	// 회원가입
	@SuppressWarnings("deprecation")
	@Override
	public int memberJoin(MEMBER member) {
		// 비밀번호 암호화
		member.setMEMBER_PW(new SHA256_Util().encryptSHA256(member.getMEMBER_PW()));

		int res = dao.memberJoin(member);

		if (res > 0) {
			MEMBER member_seq = dao.getMEMBER_CODE(member.getMEMBER_EMAIL());

			MEMBER_PROFILE member_profile = new MEMBER_PROFILE(member_seq.getMEMBER_CODE(), "", "", "", "", "", "", "",
					"");
			int profile_result = dao.insertMemberProfile(member_profile);

			// 로드맵 데이터 입력
			JsonParser jsonParser = new JsonParser();

			JsonElement jsonFrontEnd = jsonParser.parse(FrontEnd);
			JsonElement jsonBackEnd = jsonParser.parse(BackEnd);
			JsonElement jsonFullStack = jsonParser.parse(FullStack);

			ROADMAP FrontRoadmap = new ROADMAP();

			FrontRoadmap.setMEMBER_CODE(member_seq.getMEMBER_CODE());
			FrontRoadmap.setROADMAP_FIELD("FrontEnd");
			FrontRoadmap.setROADMAP_TECH(jsonFrontEnd.toString());

			int roadmap_result = dao.insertRoadMap(FrontRoadmap);

			return (profile_result > 0 && roadmap_result > 0) ? 1 : 0;
		} else {
			return res;
		}
	}

	// 카카오 회원가입
	@SuppressWarnings("deprecation")
	@Override
	public int kakaoJoin(KAKAO_MEMBER kakao_member) {
		MEMBER member = new MEMBER(); // 회원테이블
		KAKAO_MEMBER kakao = new KAKAO_MEMBER(); // sns정보 테이블

		member.setMEMBER_NAME(kakao_member.getMEMBER_NAME());
		member.setMEMBER_EMAIL(kakao_member.getMEMBER_EMAIL());
		member.setMEMBER_PHONE(kakao_member.getMEMBER_PHONE());

		int res = dao.memberJoinWithSNS(member);
		if (res > 0) {
			MEMBER member_seq = dao.getMEMBER_CODE(kakao_member.getMEMBER_EMAIL());

			kakao.setMEMBER_CODE(member_seq.getMEMBER_CODE());
			kakao.setKAKAO_ID(kakao_member.getKAKAO_ID());
			kakao.setKAKAO_NICKNAME(kakao_member.getKAKAO_NICKNAME());
			int kakao_res = dao.kakaoJoin(kakao);

			MEMBER_PROFILE member_profile = new MEMBER_PROFILE(member_seq.getMEMBER_CODE(), "", "", "", "", "", "", "",
					"");
			int profile_result = dao.insertMemberProfile(member_profile);

			// 로드맵 데이터 입력
			JsonParser jsonParser = new JsonParser();

			JsonElement jsonFrontEnd = jsonParser.parse(FrontEnd);
			JsonElement jsonBackEnd = jsonParser.parse(BackEnd);
			JsonElement jsonFullStack = jsonParser.parse(FullStack);

			ROADMAP FrontRoadmap = new ROADMAP();

			FrontRoadmap.setMEMBER_CODE(member_seq.getMEMBER_CODE());
			FrontRoadmap.setROADMAP_FIELD("FrontEnd");
			FrontRoadmap.setROADMAP_TECH(jsonFrontEnd.toString());

			int roadmap_result = dao.insertRoadMap(FrontRoadmap);

			return (kakao_res > 0 && profile_result > 0 && roadmap_result > 0) ? 1 : 0;
		} else {
			return res;
		}

	}

	// 네이버 회원가입
	@SuppressWarnings("deprecation")
	@Override
	public int naverJoin(NAVER_MEMBER naver_member) {
		MEMBER member = new MEMBER(); // 회원테이블
		NAVER_MEMBER naver = new NAVER_MEMBER(); // sns정보 테이블

		member.setMEMBER_NAME(naver_member.getMEMBER_NAME());
		member.setMEMBER_EMAIL(naver_member.getMEMBER_EMAIL());
		member.setMEMBER_PHONE(naver_member.getMEMBER_PHONE());

		int res = dao.memberJoinWithSNS(member);
		if (res > 0) {
			MEMBER member_seq = dao.getMEMBER_CODE(naver_member.getMEMBER_EMAIL());

			naver.setMEMBER_CODE(member_seq.getMEMBER_CODE());
			naver.setNAVER_ID(naver_member.getNAVER_ID());
			naver.setNAVER_NICKNAME(naver_member.getNAVER_NICKNAME());
			int naver_res = dao.naverJoin(naver);

			MEMBER_PROFILE member_profile = new MEMBER_PROFILE(member_seq.getMEMBER_CODE(), "", "", "", "", "", "", "",
					"");
			int profile_result = dao.insertMemberProfile(member_profile);

			// 로드맵 데이터 입력
			JsonParser jsonParser = new JsonParser();

			JsonElement jsonFrontEnd = jsonParser.parse(FrontEnd);
			JsonElement jsonBackEnd = jsonParser.parse(BackEnd);
			JsonElement jsonFullStack = jsonParser.parse(FullStack);

			ROADMAP FrontRoadmap = new ROADMAP();

			FrontRoadmap.setMEMBER_CODE(member_seq.getMEMBER_CODE());
			FrontRoadmap.setROADMAP_FIELD("FrontEnd");
			FrontRoadmap.setROADMAP_TECH(jsonFrontEnd.toString());

			int roadmap_result = dao.insertRoadMap(FrontRoadmap);

			return (naver_res > 0 && profile_result > 0 && roadmap_result > 0) ? 1 : 0;
		} else {
			return res;
		}
	}

	// 이름 중복체크
	@Override
	public int nameConfirm(String MEMBER_NAME) {
		return dao.nameConfirm(MEMBER_NAME);
	}

	// 이메일 중복체크
	@Override
	public int emailConfirm(String MEMBER_EMAIL) {
		return dao.emailConfirm(MEMBER_EMAIL);
	}

	/*
	 * 로그인 코드
	 */
	// 로그인
	@Override
	public MEMBER memberLogin(MEMBER member) {
		// 비밀번호 암호화
		member.setMEMBER_PW(new SHA256_Util().encryptSHA256(member.getMEMBER_PW()));

		return dao.memberLogin(member);
	}

	// kakao 로 로그인
	@Override
	public KAKAO_MEMBER memberLogin(KAKAO_MEMBER kakao_member) {
		return dao.memberLogin(kakao_member);
	}

	// 네이버 계정으로 로그인
	@Override
	public NAVER_MEMBER memberLogin(NAVER_MEMBER naver_member) {
		return dao.memberLogin(naver_member);
	}

	// 카카오 이메일로 가입된 적이 있는지 체크
	@Override
	public int isKakaoMember(String KAKAO_ID) {
		return dao.isKakaoMember(KAKAO_ID);
	}

	// 네이버 id로 가입된 적이 있는지 체크
	@Override
	public int isNaverMember(String NAVER_ID) {
		return dao.isNaverMember(NAVER_ID);
	}

	/*
	 * 회원 정보 조회 업데이트 관련
	 */
	// 회원 정보 조회 (MEMBER_CODE)
	@Override
	public MEMBER_PROFILE selectMemberProfile(int MEMBER_CODE) {
		return dao.selectMemberProfile(MEMBER_CODE);
	}

	// 회원 정보 입력
	@Override
	public int insertMemberProfile(MEMBER_PROFILE member_profile) {
		return dao.insertMemberProfile(member_profile);
	}

	// 회원 정보 업데이트
	@Override
	public int updateMember(MEMBER_PROFILE member_profile) {
		return dao.updateMember(member_profile);
	}

	// 회원 정보 업데이트
	@Override
	public int updateMemberProfile(MEMBER_PROFILE member_profile) {
		return dao.updateMemberProfile(member_profile);
	}

	// 회원 정보(이미지) 업데이트
	@Override
	public int updateMemberProfileImage(MEMBER_PROFILE member_profile) {
		return dao.updateMemberProfileImage(member_profile);
	}

	// 회원 정보(위치정보) 업데이트
	@Override
	public int updateMemberProfileGps(MEMBER_PROFILE member_profile) {
		return dao.updateMemberProfileGps(member_profile);
	}

	// 비밀번호 업데이트
	@Override
	public int updateMemberPassword(MEMBER_PROFILE member) {
		member.setMEMBER_PW(new SHA256_Util().encryptSHA256(member.getMEMBER_PW()));

		return dao.updateMemerPassword(member);
	}

}
