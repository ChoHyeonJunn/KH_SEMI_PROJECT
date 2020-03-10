package com.devca.model.dto.profile;

public class LANGUAGE {
	
	/* 언어(LANGUAGE) 테이블 */
	private int LANGUAGE_MEMBER_CODE;
	private int LANGUAGE_SEQ;
	private String LANGUAGE;
	private String LANGUAGE_OTHER;
	private String LANGUAGE_NAME;
	private String LANGUAGE_GRADE;
	
	public LANGUAGE() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LANGUAGE(int lANGUAGE_MEMBER_CODE, int lANGUAGE_SEQ, String lANGUAGE, String lANGUAGE_OTHER,
			String lANGUAGE_NAME, String lANGUAGE_GRADE) {
		super();
		LANGUAGE_MEMBER_CODE = lANGUAGE_MEMBER_CODE;
		LANGUAGE_SEQ = lANGUAGE_SEQ;
		LANGUAGE = lANGUAGE;
		LANGUAGE_OTHER = lANGUAGE_OTHER;
		LANGUAGE_NAME = lANGUAGE_NAME;
		LANGUAGE_GRADE = lANGUAGE_GRADE;
	}

	public LANGUAGE(int lANGUAGE_MEMBER_CODE, String lANGUAGE, String lANGUAGE_OTHER, String lANGUAGE_NAME,
			String lANGUAGE_GRADE) {
		super();
		LANGUAGE_MEMBER_CODE = lANGUAGE_MEMBER_CODE;
		LANGUAGE = lANGUAGE;
		LANGUAGE_OTHER = lANGUAGE_OTHER;
		LANGUAGE_NAME = lANGUAGE_NAME;
		LANGUAGE_GRADE = lANGUAGE_GRADE;
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

	public String getLANGUAGE_OTHER() {
		return LANGUAGE_OTHER;
	}

	public void setLANGUAGE_OTHER(String lANGUAGE_OTHER) {
		LANGUAGE_OTHER = lANGUAGE_OTHER;
	}

	public String getLANGUAGE_NAME() {
		return LANGUAGE_NAME;
	}

	public void setLANGUAGE_NAME(String lANGUAGE_NAME) {
		LANGUAGE_NAME = lANGUAGE_NAME;
	}

	public String getLANGUAGE_GRADE() {
		return LANGUAGE_GRADE;
	}

	public void setLANGUAGE_GRADE(String lANGUAGE_GRADE) {
		LANGUAGE_GRADE = lANGUAGE_GRADE;
	}

	
}
