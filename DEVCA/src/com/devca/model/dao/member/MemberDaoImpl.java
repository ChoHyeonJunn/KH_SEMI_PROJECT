package com.devca.model.dao.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.member.KAKAO_MEMBER;
import com.devca.model.dto.member.MEMBER;
import com.devca.model.dto.member.MEMBER_PROFILE;
import com.devca.model.dto.member.NAVER_MEMBER;
import com.devca.model.dto.member.ROADMAP;
import com.devca.mybatis.SqlMapConfig;

public class MemberDaoImpl extends SqlMapConfig implements MemberDao {

	final String namespace = "com.devca.memberMapper";

	/*
	 * 회원가입 관련
	 */
	// 회원가입
	@Override
	public int memberJoin(MEMBER member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".join", member);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// 로드맵 데이터 입력!
	@Override
	public int insertRoadMap(ROADMAP roadmap) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".insertRoadMap", roadmap);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// 로드맵 데이터 추가
	@Override
	public int updateRoadMap(ROADMAP newRoadMap) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateRoadMap", newRoadMap);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// SNS 회원가입 (제한된 정보로 MEMBER 테이블 insert)
	@Override
	public int memberJoinWithSNS(MEMBER member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".joinWithSns", member);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// KAKAO 회원가입
	@Override
	public int kakaoJoin(KAKAO_MEMBER kakao_member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".kakaojoin", kakao_member);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// NAVER 회원가입
	@Override
	public int naverJoin(NAVER_MEMBER naver_member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".naverjoin", naver_member);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// 이메일로 회원번호 가져오기 (sns로 가입시 먼저 member테이블에 insert 후 seq 를 가져오기 위함)
	@Override
	public MEMBER getMEMBER_CODE(String MEMBER_EMAIL) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		MEMBER memberCode = session.selectOne(namespace + ".getMEMBER_CODE", MEMBER_EMAIL);
		session.close();
		return memberCode;
	}

	// 이름 중복체크
	@Override
	public int nameConfirm(String MEMBER_NAME) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int result = session.selectOne(namespace + ".nameConfirm", MEMBER_NAME);
		session.close();
		return result;
	}

	// 이메일 중복체크
	@Override
	public int emailConfirm(String MEMBER_EMAIL) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int result = session.selectOne(namespace + ".emailConfirm", MEMBER_EMAIL);
		session.close();
		return result;
	}

	/*
	 * 로그인 관련
	 */
	// 로그인
	@Override
	public MEMBER memberLogin(MEMBER member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		MEMBER loginMember = session.selectOne(namespace + ".login", member);
		session.close();
		return loginMember;
	}

	// 카카오 계정으로 로그인
	@Override
	public KAKAO_MEMBER memberLogin(KAKAO_MEMBER kakao_member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		KAKAO_MEMBER kakao_loginMember = session.selectOne(namespace + ".loginkakao", kakao_member);
		session.close();
		return kakao_loginMember;
	}

	// 카카오 계정으로 로그인
	@Override
	public NAVER_MEMBER memberLogin(NAVER_MEMBER naver_member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		NAVER_MEMBER naver_loginMember = session.selectOne(namespace + ".loginnaver", naver_member);
		session.close();
		return naver_loginMember;
	}

	// 카카오 이메일로 가입된 적이 있는지 체크
	@Override
	public int isKakaoMember(String KAKAO_ID) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.selectOne(namespace + ".isKakaoMember", KAKAO_ID);
		session.close();
		return res;
	}

	// 네이버 id로 가입된 적이 있는지 체크
	@Override
	public int isNaverMember(String NAVER_ID) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.selectOne(namespace + ".isNaverMember", NAVER_ID);
		session.close();
		return res;
	}
	// 회원 정보 조회 (MEMBER_CODE)
	@Override
	public MEMBER_PROFILE selectMemberProfile(int MEMBER_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		MEMBER_PROFILE member_profile = session.selectOne(namespace + ".selectMemberProfile", MEMBER_CODE);
		session.close();
		return member_profile;
	}

	// 회원 정보 입력
	@Override
	public int insertMemberProfile(MEMBER_PROFILE member_profile) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".insertMemberProfile", member_profile);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// 회원 정보 업데이트
	@Override
	public int updateMember(MEMBER_PROFILE member_profile) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateMember", member_profile);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// 회원 정보 업데이트
	@Override
	public int updateMemberProfile(MEMBER_PROFILE member_profile) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateMemberProfile", member_profile);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// 회원 정보(이미지) 업데이트
	@Override
	public int updateMemberProfileImage(MEMBER_PROFILE member_profile) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateMemberProfileImage", member_profile);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// 회원 정보(위치정보) 업데이트
	@Override
	public int updateMemberProfileGps(MEMBER_PROFILE member_profile) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateMemberProfileGps", member_profile);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// 비밀번호 업데이트
	@Override
	public int updateMemerPassword(MEMBER_PROFILE member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateMemberPw", member);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// email or name 검색 자동완성 ajax
	@Override
	public List<MEMBER_PROFILE> searchMemberEmailName(String EMAIL_NAME, int MY_MEMBER_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("EMAIL_NAME", EMAIL_NAME);
		map.put("MY_MEMBER_CODE", MY_MEMBER_CODE);
		List<MEMBER_PROFILE> searchProfileList = session.selectList(namespace + ".searchMemberEmailName", map);

		session.close();
		return searchProfileList;
	}

	// 정기결제 후 멤버 등급 up
	@Override
	public int updateMemberRole(int MEMBER_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateMemberRole", MEMBER_CODE);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

}
