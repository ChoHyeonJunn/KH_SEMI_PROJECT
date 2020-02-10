package com.devca.model.dao.member;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.KAKAO_MEMBER;
import com.devca.model.dto.MEMBER;
import com.devca.model.dto.NAVER_MEMBER;
import com.devca.mybatis.SqlMapConfig;

public class MemberDaoImpl extends SqlMapConfig implements MemberDao {

	final String namespace = "com.devca.memberMapper";

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

	// 로그인
	@Override
	public MEMBER memberLogin(MEMBER member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		MEMBER loginMember = session.selectOne(namespace + ".login", member);
		session.close();
		return loginMember;
	}

	@Override
	public int memberJoinWithSNS(MEMBER member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".joinWithSns", member);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	@Override
	public int kakaoJoin(KAKAO_MEMBER kakao_member) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".kakaojoin", kakao_member);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	@Override
	public int naverJoin(NAVER_MEMBER naver_member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public MEMBER getMEMBER_CODE(String MEMBER_EMAIL) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		MEMBER memberCode = session.selectOne(namespace + ".getMEMBER_CODE", MEMBER_EMAIL);
		session.close();
		return memberCode;
	}

}
