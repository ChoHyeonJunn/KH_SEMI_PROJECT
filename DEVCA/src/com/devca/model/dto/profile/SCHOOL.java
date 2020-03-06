package com.devca.model.dto.profile;

import java.sql.Date;

public class SCHOOL {

	
	/* 학력 테이블 */
	private int SCHOOL_MEMBER_CODE;
	private int SCHOOL_SEQ;
	private String SCHOOL_NAME;
	private String SCHOOL_MAJOR;
	private String SCHOOL_DEGREE;
	private String SCHOOL_OF_START;
	private String SCHOOL_OF_END;
	private double SCHOOL_CREDIT;
	private double SCHOOL_MAXCREDIT;
	private String SCHOOL_EXPLANATION;
	
	public SCHOOL() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SCHOOL(int sCHOOL_MEMBER_CODE, int sCHOOL_SEQ, String sCHOOL_NAME, String sCHOOL_MAJOR, String sCHOOL_DEGREE,
			String start_date, String end_date, double sCHOOL_CREDIT, double sCHOOL_MAXCREDIT,
			String sCHOOL_EXPLANATION) {
		super();
		SCHOOL_MEMBER_CODE = sCHOOL_MEMBER_CODE;
		SCHOOL_SEQ = sCHOOL_SEQ;
		SCHOOL_NAME = sCHOOL_NAME;
		SCHOOL_MAJOR = sCHOOL_MAJOR;
		SCHOOL_DEGREE = sCHOOL_DEGREE;
		SCHOOL_OF_START = start_date;
		SCHOOL_OF_END = end_date;
		SCHOOL_CREDIT = sCHOOL_CREDIT;
		SCHOOL_MAXCREDIT = sCHOOL_MAXCREDIT;
		SCHOOL_EXPLANATION = sCHOOL_EXPLANATION;
	}

	public int getSCHOOL_MEMBER_CODE() {
		return SCHOOL_MEMBER_CODE;
	}

	public void setSCHOOL_MEMBER_CODE(int sCHOOL_MEMBER_CODE) {
		SCHOOL_MEMBER_CODE = sCHOOL_MEMBER_CODE;
	}

	public int getSCHOOL_SEQ() {
		return SCHOOL_SEQ;
	}

	public void setSCHOOL_SEQ(int sCHOOL_SEQ) {
		SCHOOL_SEQ = sCHOOL_SEQ;
	}

	public String getSCHOOL_NAME() {
		return SCHOOL_NAME;
	}

	public void setSCHOOL_NAME(String sCHOOL_NAME) {
		SCHOOL_NAME = sCHOOL_NAME;
	}

	public String getSCHOOL_MAJOR() {
		return SCHOOL_MAJOR;
	}

	public void setSCHOOL_MAJOR(String sCHOOL_MAJOR) {
		SCHOOL_MAJOR = sCHOOL_MAJOR;
	}

	public String getSCHOOL_DEGREE() {
		return SCHOOL_DEGREE;
	}

	public void setSCHOOL_DEGREE(String sCHOOL_DEGREE) {
		SCHOOL_DEGREE = sCHOOL_DEGREE;
	}

	public String getSCHOOL_OF_START() {
		return SCHOOL_OF_START;
	}

	public void setSCHOOL_OF_START(String sCHOOL_OF_START) {
		SCHOOL_OF_START = sCHOOL_OF_START;
	}

	public String getSCHOOL_OF_END() {
		return SCHOOL_OF_END;
	}

	public void setSCHOOL_OF_END(String sCHOOL_OF_END) {
		SCHOOL_OF_END = sCHOOL_OF_END;
	}

	public double getSCHOOL_CREDIT() {
		return SCHOOL_CREDIT;
	}

	public void setSCHOOL_CREDIT(double sCHOOL_CREDIT) {
		SCHOOL_CREDIT = sCHOOL_CREDIT;
	}

	public double getSCHOOL_MAXCREDIT() {
		return SCHOOL_MAXCREDIT;
	}

	public void setSCHOOL_MAXCREDIT(double sCHOOL_MAXCREDIT) {
		SCHOOL_MAXCREDIT = sCHOOL_MAXCREDIT;
	}

	public String getSCHOOL_EXPLANATION() {
		return SCHOOL_EXPLANATION;
	}

	public void setSCHOOL_EXPLANATION(String sCHOOL_EXPLANATION) {
		SCHOOL_EXPLANATION = sCHOOL_EXPLANATION;
	}

	
	
}
