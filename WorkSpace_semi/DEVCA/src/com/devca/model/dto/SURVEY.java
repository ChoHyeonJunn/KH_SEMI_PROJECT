package com.devca.model.dto;

public class SURVEY {
	
	/* 설문조사 테이블 */
	private int SURVEY_SEQ;
	private int MEMBER_CODE;
	private String SURVEY_DATA;
	public SURVEY() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SURVEY(int sURVEY_SEQ, int mEMBER_CODE, String sURVEY_DATA) {
		super();
		SURVEY_SEQ = sURVEY_SEQ;
		MEMBER_CODE = mEMBER_CODE;
		SURVEY_DATA = sURVEY_DATA;
	}
	public int getSURVEY_SEQ() {
		return SURVEY_SEQ;
	}
	public void setSURVEY_SEQ(int sURVEY_SEQ) {
		SURVEY_SEQ = sURVEY_SEQ;
	}
	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}
	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}
	public String getSURVEY_DATA() {
		return SURVEY_DATA;
	}
	public void setSURVEY_DATA(String sURVEY_DATA) {
		SURVEY_DATA = sURVEY_DATA;
	}
	
	
}
