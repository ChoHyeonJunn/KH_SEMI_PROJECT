package com.devca.model.biz.member;

import java.util.List;

import com.devca.model.dto.member.KAKAO_MEMBER;
import com.devca.model.dto.member.MEMBER;
import com.devca.model.dto.member.MEMBER_PROFILE;
import com.devca.model.dto.member.NAVER_MEMBER;

public interface MemberBiz {
	/*
	 * 회원가입 코드
	 */
	// 회원가입
	public int memberJoin(MEMBER member);

	// 카카오 회원가입
	public int kakaoJoin(KAKAO_MEMBER kakao_member);

	// 네이버 회원가입
	public int naverJoin(NAVER_MEMBER naver_member);

	// 이름 중복체크
	public int nameConfirm(String mEMBER_NAME);

	// 이메일 중복체크
	public int emailConfirm(String MEMBER_EMAIL);

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

	/*
	 * 회원 정보 조회 업데이트 관련
	 */
	// 회원 정보 조회 (MEMBER_CODE)
	public MEMBER_PROFILE selectMemberProfile(int MEMBER_CODE);

	// 회원 정보 입력
	public int insertMemberProfile(MEMBER_PROFILE member_profile);

	// 회원 정보 업데이트
	public int updateMember(MEMBER_PROFILE member_profile);

	// 회원 정보 업데이트
	public int updateMemberProfile(MEMBER_PROFILE member_profile);

	// 회원 정보(이미지) 업데이트
	public int updateMemberProfileImage(MEMBER_PROFILE member_profile);

	// 회원 정보(위치정보) 업데이트
	public int updateMemberProfileGps(MEMBER_PROFILE member_profile);

	// 비밀번호 업데이트
	public int updateMemberPassword(MEMBER_PROFILE member);

	// email or name 검색 자동완성 ajax
	public List<MEMBER_PROFILE> searchMemberEmailName(String eMAIL_NAME, int MY_MEMBER_CODE);

	// email 로 멤버 정보 가져오기
	public MEMBER getMEMBER_CODE(String MEMBER_EMAIL);

	// 정기결제 후 멤버 등급 up
	public int updateMemberRole(int MEMBER_CODE);

}
