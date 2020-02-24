package com.devca.model.dto;

import java.sql.Date;

public class NAVER_MEMBER {

	private int MEMBER_CODE;
	private String MEMBER_NAME;
	private String MEMBER_EMAIL;
	private String MEMBER_PW;
	private String MEMBER_PHONE;

	private String MEMBER_ENABLED;
	private String MEMBER_ROLE;

	private Date MEMBER_LOGOUT_DATE;
	private Date MEMBER_CREATE_DATE;

	private String NAVER_ID;
	private String NAVER_NICKNAME;

	public NAVER_MEMBER() {
		super();
		// TODO Auto-generated constructor stub
	}

	public NAVER_MEMBER(int mEMBER_CODE, String mEMBER_NAME, String mEMBER_EMAIL, String mEMBER_PW, String mEMBER_PHONE,
			String mEMBER_ENABLED, String mEMBER_ROLE, Date mEMBER_LOGOUT_DATE, Date mEMBER_CREATE_DATE,
			String nAVER_ID, String nAVER_NICKNAME) {
		super();
		MEMBER_CODE = mEMBER_CODE;
		MEMBER_NAME = mEMBER_NAME;
		MEMBER_EMAIL = mEMBER_EMAIL;
		MEMBER_PW = mEMBER_PW;
		MEMBER_PHONE = mEMBER_PHONE;
		MEMBER_ENABLED = mEMBER_ENABLED;
		MEMBER_ROLE = mEMBER_ROLE;
		MEMBER_LOGOUT_DATE = mEMBER_LOGOUT_DATE;
		MEMBER_CREATE_DATE = mEMBER_CREATE_DATE;
		NAVER_ID = nAVER_ID;
		NAVER_NICKNAME = nAVER_NICKNAME;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public String getMEMBER_NAME() {
		return MEMBER_NAME;
	}

	public void setMEMBER_NAME(String mEMBER_NAME) {
		MEMBER_NAME = mEMBER_NAME;
	}

	public String getMEMBER_EMAIL() {
		return MEMBER_EMAIL;
	}

	public void setMEMBER_EMAIL(String mEMBER_EMAIL) {
		MEMBER_EMAIL = mEMBER_EMAIL;
	}

	public String getMEMBER_PW() {
		return MEMBER_PW;
	}

	public void setMEMBER_PW(String mEMBER_PW) {
		MEMBER_PW = mEMBER_PW;
	}

	public String getMEMBER_PHONE() {
		return MEMBER_PHONE;
	}

	public void setMEMBER_PHONE(String mEMBER_PHONE) {
		MEMBER_PHONE = mEMBER_PHONE;
	}

	public String getMEMBER_ENABLED() {
		return MEMBER_ENABLED;
	}

	public void setMEMBER_ENABLED(String mEMBER_ENABLED) {
		MEMBER_ENABLED = mEMBER_ENABLED;
	}

	public String getMEMBER_ROLE() {
		return MEMBER_ROLE;
	}

	public void setMEMBER_ROLE(String mEMBER_ROLE) {
		MEMBER_ROLE = mEMBER_ROLE;
	}

	public Date getMEMBER_LOGOUT_DATE() {
		return MEMBER_LOGOUT_DATE;
	}

	public void setMEMBER_LOGOUT_DATE(Date mEMBER_LOGOUT_DATE) {
		MEMBER_LOGOUT_DATE = mEMBER_LOGOUT_DATE;
	}

	public Date getMEMBER_CREATE_DATE() {
		return MEMBER_CREATE_DATE;
	}

	public void setMEMBER_CREATE_DATE(Date mEMBER_CREATE_DATE) {
		MEMBER_CREATE_DATE = mEMBER_CREATE_DATE;
	}

	public String getNAVER_ID() {
		return NAVER_ID;
	}

	public void setNAVER_ID(String nAVER_ID) {
		NAVER_ID = nAVER_ID;
	}

	public String getNAVER_NICKNAME() {
		return NAVER_NICKNAME;
	}

	public void setNAVER_NICKNAME(String nAVER_NICKNAME) {
		NAVER_NICKNAME = nAVER_NICKNAME;
	}

	@Override
	public String toString() {
		return "NAVER_MEMBER [MEMBER_CODE=" + MEMBER_CODE + ", MEMBER_NAME=" + MEMBER_NAME + ", MEMBER_EMAIL="
				+ MEMBER_EMAIL + ", MEMBER_PW=" + MEMBER_PW + ", MEMBER_PHONE=" + MEMBER_PHONE + ", MEMBER_ENABLED="
				+ MEMBER_ENABLED + ", MEMBER_ROLE=" + MEMBER_ROLE + ", MEMBER_LOGOUT_DATE=" + MEMBER_LOGOUT_DATE
				+ ", MEMBER_CREATE_DATE=" + MEMBER_CREATE_DATE + ", NAVER_ID=" + NAVER_ID + ", NAVER_NICKNAME="
				+ NAVER_NICKNAME + "]";
	}

}
