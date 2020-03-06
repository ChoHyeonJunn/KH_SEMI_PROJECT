package com.devca.model.biz.member;

import com.devca.model.dto.KAKAO_MEMBER;
import com.devca.model.dto.MEMBER;
import com.devca.model.dto.NAVER_MEMBER;

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
	// 카카오 계정으로 로그인
	public KAKAO_MEMBER memberLogin(KAKAO_MEMBER kakao_member);
	// 네이버 계정으로 로그인
	public NAVER_MEMBER memberLogin(NAVER_MEMBER naver_member);
	// 카카오 id로 가입된 적이 있는지 체크
	public int isKakaoMember(String KAKAO_ID);
	// 네이버 id로 가입된 적이 있는지 체크
	public int isNaverMember(String NAVER_ID);

}
