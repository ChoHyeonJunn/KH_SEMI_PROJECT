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

	// 이메일로 회원번호 가져오기 (sns로 가입시 먼저 member테이블에 insert 후 seq 를 가져오기 위함)
	public MEMBER getMEMBER_CODE(String MEMBER_EMAIL);

	/*
	 * 로그인 관련
	 */
	// 로그인
	public MEMBER memberLogin(MEMBER member);

	// 카카오 계정으로 로그인
	public KAKAO_MEMBER memberLogin(KAKAO_MEMBER kakao_member);

	// 카카오 계정으로 로그인
	public NAVER_MEMBER memberLogin(NAVER_MEMBER naver_member);
	
	// 카카오 이메일로 가입된 적이 있는지 체크
	public int isKakaoMember(String KAKAO_ID); 
	
	// 네이버 id로 가입된 적이 있는지 체크
	public int isNaverMember(String NAVER_ID);

}
