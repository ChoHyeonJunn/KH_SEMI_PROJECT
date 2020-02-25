package com.devca.model.dto;

import java.sql.Date;

public class CAREER_DETAIL {

	/* 커리어 세부 항목 테이블*/
	private int CAREER_DETAIL_SEQ;
	private int CAREER_DETAIL_CAREER_SEQ;
	private String PERFORMANCE;
	private String START_DATE;
	private String END_DATE;
	private String DETAIL_CONTEXT;
	
	public CAREER_DETAIL() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CAREER_DETAIL(int cAREER_DETAIL_SEQ, int cAREER_DETAIL_CAREER_SEQ, String pERFORMANCE, String sTART_DATE,
			String eND_DATE, String dETAIL_CONTEXT) {
		super();
		CAREER_DETAIL_SEQ = cAREER_DETAIL_SEQ;
		CAREER_DETAIL_CAREER_SEQ = cAREER_DETAIL_CAREER_SEQ;
		PERFORMANCE = pERFORMANCE;
		START_DATE = sTART_DATE;
		END_DATE = eND_DATE;
		DETAIL_CONTEXT = dETAIL_CONTEXT;
	}

	public int getCAREER_DETAIL_SEQ() {
		return CAREER_DETAIL_SEQ;
	}

	public void setCAREER_DETAIL_SEQ(int cAREER_DETAIL_SEQ) {
		CAREER_DETAIL_SEQ = cAREER_DETAIL_SEQ;
	}

	public int getCAREER_DETAIL_CAREER_SEQ() {
		return CAREER_DETAIL_CAREER_SEQ;
	}

	public void setCAREER_DETAIL_CAREER_SEQ(int cAREER_DETAIL_CAREER_SEQ) {
		CAREER_DETAIL_CAREER_SEQ = cAREER_DETAIL_CAREER_SEQ;
	}

	public String getPERFORMANCE() {
		return PERFORMANCE;
	}

	public void setPERFORMANCE(String pERFORMANCE) {
		PERFORMANCE = pERFORMANCE;
	}

	public String getSTART_DATE() {
		return START_DATE;
	}

	public void setSTART_DATE(String sTART_DATE) {
		START_DATE = sTART_DATE;
	}

	public String getEND_DATE() {
		return END_DATE;
	}

	public void setEND_DATE(String eND_DATE) {
		END_DATE = eND_DATE;
	}

	public String getDETAIL_CONTEXT() {
		return DETAIL_CONTEXT;
	}

	public void setDETAIL_CONTEXT(String dETAIL_CONTEXT) {
		DETAIL_CONTEXT = dETAIL_CONTEXT;
	}

	
	
}
