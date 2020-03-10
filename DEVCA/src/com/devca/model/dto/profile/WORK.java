package com.devca.model.dto.profile;

public class WORK {
	
	/* 희망 직군 테이블 (테이블이 필요 없을듯 "어떻게 만들지 회의필요")*/
	private int WORK_MEMBER_CODE;
	private int WORK_SEQ;
	private String LINE_OF_WORK;
	private String INCOME;
	
	public WORK() {
		super();
		// TODO Auto-generated constructor stub
	}

	public WORK(int wORK_MEMBER_CODE, int wORK_SEQ, String lINE_OF_WORK, String iNCOME) {
		super();
		WORK_MEMBER_CODE = wORK_MEMBER_CODE;
		WORK_SEQ = wORK_SEQ;
		LINE_OF_WORK = lINE_OF_WORK;
		INCOME = iNCOME;
	}

	public WORK(int wORK_MEMBER_CODE, String lINE_OF_WORK, String iNCOME) {
		WORK_MEMBER_CODE = wORK_MEMBER_CODE;
		LINE_OF_WORK = lINE_OF_WORK;
		INCOME = iNCOME;	
	}

	public int getWORK_MEMBER_CODE() {
		return WORK_MEMBER_CODE;
	}

	public void setWORK_MEMBER_CODE(int wORK_MEMBER_CODE) {
		WORK_MEMBER_CODE = wORK_MEMBER_CODE;
	}

	public int getWORK_SEQ() {
		return WORK_SEQ;
	}

	public void setWORK_SEQ(int wORK_SEQ) {
		WORK_SEQ = wORK_SEQ;
	}

	public String getLINE_OF_WORK() {
		return LINE_OF_WORK;
	}

	public void setLINE_OF_WORK(String lINE_OF_WORK) {
		LINE_OF_WORK = lINE_OF_WORK;
	}

	public String getINCOME() {
		return INCOME;
	}

	public void setINCOME(String iNCOME) {
		INCOME = iNCOME;
	}

	

		
}
