package com.devca.model.dao.member;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.KAKAO_MEMBER;
import com.devca.model.dto.MEMBER;
import com.devca.model.dto.NAVER_MEMBER;
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
		// TODO Auto-generated method stub
		return 0;
	}

	// 이메일로 회원번호 가져오기 (sns로 가입시 먼저 member테이블에 insert 후 seq 를 가져오기 위함)
	@Override
	public MEMBER getMEMBER_CODE(String MEMBER_EMAIL) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		MEMBER memberCode = session.selectOne(namespace + ".getMEMBER_CODE", MEMBER_EMAIL);
		session.close();
		return memberCode;
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
	
	
	

}
