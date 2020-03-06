package com.devca.model.dto.profile;

public class SKILL {
	
	/* 주요 기술 테이블 (테이블이 필요 없을듯 "어떻게 만들지 회의필요")*/
	private int SKILL_MEMBER_CODE;
	private int SKILL_SEQ;
	private String SKILL;

	
	public SKILL() {
		super();
		// TODO Auto-generated constructor stub
	}


	public SKILL(int sKILL_MEMBER_CODE, int sKILL_SEQ, String sKILL) {
		super();
		SKILL_MEMBER_CODE = sKILL_MEMBER_CODE;
		SKILL_SEQ = sKILL_SEQ;
		SKILL = sKILL;
	}


	public int getSKILL_MEMBER_CODE() {
		return SKILL_MEMBER_CODE;
	}


	public void setSKILL_MEMBER_CODE(int sKILL_MEMBER_CODE) {
		SKILL_MEMBER_CODE = sKILL_MEMBER_CODE;
	}


	public int getSKILL_SEQ() {
		return SKILL_SEQ;
	}


	public void setSKILL_SEQ(int sKILL_SEQ) {
		SKILL_SEQ = sKILL_SEQ;
	}


	public String getSKILL() {
		return SKILL;
	}


	public void setSKILL(String sKILL) {
		SKILL = sKILL;
	}


	
	
}
