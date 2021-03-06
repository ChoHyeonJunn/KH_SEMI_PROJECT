package com.devca.model.dto.member;

import java.sql.Date;

public class KAKAO_MEMBER {

	private int MEMBER_CODE;
	private String MEMBER_NAME;
	private String MEMBER_EMAIL;
	private String MEMBER_PW;
	private String MEMBER_PHONE;

	private String MEMBER_ENABLED;
	private String MEMBER_ROLE;

	private Date MEMBER_LOGOUT_DATE;
	private Date MEMBER_CREATE_DATE;

	private String KAKAO_ID;
	private String KAKAO_NICKNAME;

	public KAKAO_MEMBER() {
		super();
		// TODO Auto-generated constructor stub
	}

	public KAKAO_MEMBER(int mEMBER_CODE, String mEMBER_NAME, String mEMBER_EMAIL, String mEMBER_PW, String mEMBER_PHONE,
			String mEMBER_ENABLED, String mEMBER_ROLE, Date mEMBER_LOGOUT_DATE, Date mEMBER_CREATE_DATE,
			String kAKAO_ID, String kAKAO_NICKNAME) {
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
		KAKAO_ID = kAKAO_ID;
		KAKAO_NICKNAME = kAKAO_NICKNAME;
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

	public String getKAKAO_ID() {
		return KAKAO_ID;
	}

	public void setKAKAO_ID(String kAKAO_ID) {
		KAKAO_ID = kAKAO_ID;
	}

	public String getKAKAO_NICKNAME() {
		return KAKAO_NICKNAME;
	}

	public void setKAKAO_NICKNAME(String kAKAO_NICKNAME) {
		KAKAO_NICKNAME = kAKAO_NICKNAME;
	}

	@Override
	public String toString() {
		return "MEMBER [MEMBER_CODE=" + MEMBER_CODE + ", MEMBER_NAME=" + MEMBER_NAME + ", MEMBER_EMAIL=" + MEMBER_EMAIL
				+ ", MEMBER_PW=" + MEMBER_PW + ", MEMBER_PHONE=" + MEMBER_PHONE + ", MEMBER_ENABLED=" + MEMBER_ENABLED
				+ ", MEMBER_ROLE=" + MEMBER_ROLE + ", MEMBER_LOGOUT_DATE=" + MEMBER_LOGOUT_DATE
				+ ", MEMBER_CREATE_DATE=" + MEMBER_CREATE_DATE + ", KAKAO_ID=" + KAKAO_ID + ", KAKAO_NICKNAME="
				+ KAKAO_NICKNAME + "]";
	}

}
