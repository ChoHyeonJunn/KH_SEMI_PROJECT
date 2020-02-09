package com.devca.model.biz.member;

import com.devca.model.dto.KAKAO_MEMBER;
import com.devca.model.dto.MEMBER;

public interface MemberBiz {
	/*
	 * 회원가입 코드
	 */
	// 회원가입
	public int memberJoin(MEMBER member);
	
	// 카카오 회원가입
	public int kakaoJoin(KAKAO_MEMBER kakao_member);
	// 네이버 회원가입
	/*
	 * 로그인 코드
	 */
	// 로그인
	public MEMBER memberLogin(MEMBER member);
	
}
