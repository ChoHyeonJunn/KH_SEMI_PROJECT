package com.devca.model.dto;

import java.sql.Date;

public class CALENDER {
	private int CALENDER_SEQ;
	private int CALENDER_MEMBER_SEQ;
	private Date CALENDER_DATE;
	private int CALENDER_SUCCESS;
	public CALENDER() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CALENDER(int cALENDER_SEQ, int cALENDER_MEMBER_SEQ, Date cALENDER_DATE, int cALENDER_SUCCESS) {
		super();
		CALENDER_SEQ = cALENDER_SEQ;
		CALENDER_MEMBER_SEQ = cALENDER_MEMBER_SEQ;
		CALENDER_DATE = cALENDER_DATE;
		CALENDER_SUCCESS = cALENDER_SUCCESS;
	}
	public int getCALENDER_SEQ() {
		return CALENDER_SEQ;
	}
	public void setCALENDER_SEQ(int cALENDER_SEQ) {
		CALENDER_SEQ = cALENDER_SEQ;
	}
	public int getCALENDER_MEMBER_SEQ() {
		return CALENDER_MEMBER_SEQ;
	}
	public void setCALENDER_MEMBER_SEQ(int cALENDER_MEMBER_SEQ) {
		CALENDER_MEMBER_SEQ = cALENDER_MEMBER_SEQ;
	}
	public Date getCALENDER_DATE() {
		return CALENDER_DATE;
	}
	public void setCALENDER_DATE(Date cALENDER_DATE) {
		CALENDER_DATE = cALENDER_DATE;
	}
	public int getCALENDER_SUCCESS() {
		return CALENDER_SUCCESS;
	}
	public void setCALENDER_SUCCESS(int cALENDER_SUCCESS) {
		CALENDER_SUCCESS = cALENDER_SUCCESS;
	}
	
}
