package com.devca.model.biz.member;

import com.devca.model.dao.member.MemberDao;
import com.devca.model.dao.member.MemberDaoImpl;
import com.devca.model.dto.KAKAO_MEMBER;
import com.devca.model.dto.MEMBER;
import com.devca.model.dto.NAVER_MEMBER;

public class MemberBizImpl implements MemberBiz {

	MemberDao dao = new MemberDaoImpl();

	/*
	 * 회원가입 코드
	 */
	// 회원가입
	@Override
	public int memberJoin(MEMBER member) {
		return dao.memberJoin(member);
	}

	// 카카오 회원가입
	@Override
	public int kakaoJoin(KAKAO_MEMBER kakao_member) {
		MEMBER member = new MEMBER();
		KAKAO_MEMBER kakao = new KAKAO_MEMBER();

		member.setMEMBER_NAME(kakao_member.getMEMBER_NAME());
		member.setMEMBER_EMAIL(kakao_member.getMEMBER_EMAIL());
		member.setMEMBER_PHONE(kakao_member.getMEMBER_PHONE());

		int kakao_res = 0;
		int res = dao.memberJoinWithSNS(member);
		if (res > 0) {
			MEMBER member_seq = dao.getMEMBER_CODE(kakao_member.getMEMBER_EMAIL());

			kakao.setMEMBER_CODE(member_seq.getMEMBER_CODE());
			kakao.setKAKAO_ID(kakao_member.getKAKAO_ID());
			kakao.setKAKAO_NICKNAME(kakao_member.getKAKAO_NICKNAME());

			kakao_res = dao.kakaoJoin(kakao);
		}

		return kakao_res;
	}

	/*
	 * 로그인 코드
	 */
	// 로그인
	@Override
	public MEMBER memberLogin(MEMBER member) {
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



}
