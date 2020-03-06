package com.devca.model.dto.profile;

public class LANGUAGE {
	
	/* 언어(LANGUAGE) 테이블 */
	private int LANGUAGE_MEMBER_CODE;
	private int LANGUAGE_SEQ;
	private String LANGUAGE;
	
	public LANGUAGE() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LANGUAGE(int lANGUAGE_MEMBER_CODE, int lANGUAGE_SEQ, String lANGUAGE) {
		super();
		LANGUAGE_MEMBER_CODE = lANGUAGE_MEMBER_CODE;
		LANGUAGE_SEQ = lANGUAGE_SEQ;
		LANGUAGE = lANGUAGE;
	}

	public int getLANGUAGE_MEMBER_CODE() {
		return LANGUAGE_MEMBER_CODE;
	}

	public void setLANGUAGE_MEMBER_CODE(int lANGUAGE_MEMBER_CODE) {
		LANGUAGE_MEMBER_CODE = lANGUAGE_MEMBER_CODE;
	}

	public int getLANGUAGE_SEQ() {
		return LANGUAGE_SEQ;
	}

	public void setLANGUAGE_SEQ(int lANGUAGE_SEQ) {
		LANGUAGE_SEQ = lANGUAGE_SEQ;
	}

	public String getLANGUAGE() {
		return LANGUAGE;
	}

	public void setLANGUAGE(String lANGUAGE) {
		LANGUAGE = lANGUAGE;
	}

	
	
}
