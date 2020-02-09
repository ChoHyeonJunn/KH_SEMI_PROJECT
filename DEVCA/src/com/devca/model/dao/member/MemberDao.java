package com.devca.model.dao.member;

import com.devca.model.dto.KAKAO_MEMBER;
import com.devca.model.dto.MEMBER;
import com.devca.model.dto.NAVER_MEMBER;

public interface MemberDao {
	/*
	 * 회원가입 관련
	 */
	// 회원가입
	public int memberJoin(MEMBER member);

	// SNS 회원가입 (제한된 정보로 MEMBER 테이블 insert)
	public int memberJoinWithSNS(MEMBER member);

	// KAKAO 회원가입
	public int kakaoJoin(KAKAO_MEMBER kakao_member);

	// NAVER 회원가입
	public int naverJoin(NAVER_MEMBER naver_member);

	/*
	 * 로그인 관련
	 */
	// 로그인
	public MEMBER memberLogin(MEMBER member);
	
	public MEMBER getMEMBER_CODE(String MEMBER_EMAIL);
}
