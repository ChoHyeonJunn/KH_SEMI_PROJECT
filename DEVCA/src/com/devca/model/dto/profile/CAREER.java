package com.devca.model.dto.profile;

import java.sql.Date;

public class CAREER {

	/* 커리어 테이블 변수*/
	private int CAREER_MEMBER_CODE;
	private int CAREER_SEQ;
	private String COMPANY_NAME;
	private String DUTY;
	private String DAY_OF_ENTRY;
	private String DATE_OF_DEPARTURE;
	private String STACK;
	private String LINK;
	private String EXPLANATION;
	
	public CAREER() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CAREER(int cAREER_MEMBER_CODE, int cAREER_SEQ, String cOMPANY_NAME, String dUTY, String dAY_OF_ENTRY,
			String dATE_OF_DEPARTURE, String sTACK, String lINK, String eXPLANATION) {
		super();
		CAREER_MEMBER_CODE = cAREER_MEMBER_CODE;
		CAREER_SEQ = cAREER_SEQ;
		COMPANY_NAME = cOMPANY_NAME;
		DUTY = dUTY;
		DAY_OF_ENTRY = dAY_OF_ENTRY;
		DATE_OF_DEPARTURE = dATE_OF_DEPARTURE;
		STACK = sTACK;
		LINK = lINK;
		EXPLANATION = eXPLANATION;
	}

	public int getCAREER_MEMBER_CODE() {
		return CAREER_MEMBER_CODE;
	}

	public void setCAREER_MEMBER_CODE(int cAREER_MEMBER_CODE) {
		CAREER_MEMBER_CODE = cAREER_MEMBER_CODE;
	}

	public int getCAREER_SEQ() {
		return CAREER_SEQ;
	}

	public void setCAREER_SEQ(int cAREER_SEQ) {
		CAREER_SEQ = cAREER_SEQ;
	}

	public String getCOMPANY_NAME() {
		return COMPANY_NAME;
	}

	public void setCOMPANY_NAME(String cOMPANY_NAME) {
		COMPANY_NAME = cOMPANY_NAME;
	}

	public String getDUTY() {
		return DUTY;
	}

	public void setDUTY(String dUTY) {
		DUTY = dUTY;
	}

	public String getDAY_OF_ENTRY() {
		return DAY_OF_ENTRY;
	}

	public void setDAY_OF_ENTRY(String dAY_OF_ENTRY) {
		DAY_OF_ENTRY = dAY_OF_ENTRY;
	}

	public String getDATE_OF_DEPARTURE() {
		return DATE_OF_DEPARTURE;
	}

	public void setDATE_OF_DEPARTURE(String dATE_OF_DEPARTURE) {
		DATE_OF_DEPARTURE = dATE_OF_DEPARTURE;
	}

	public String getSTACK() {
		return STACK;
	}

	public void setSTACK(String sTACK) {
		STACK = sTACK;
	}

	public String getLINK() {
		return LINK;
	}

	public void setLINK(String lINK) {
		LINK = lINK;
	}

	public String getEXPLANATION() {
		return EXPLANATION;
	}

	public void setEXPLANATION(String eXPLANATION) {
		EXPLANATION = eXPLANATION;
	}

	

	
}
