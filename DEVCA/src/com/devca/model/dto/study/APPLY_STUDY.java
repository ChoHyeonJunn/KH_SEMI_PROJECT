package com.devca.model.dto.study;

import java.util.Date;

public class APPLY_STUDY {
	private int STUDY_CODE;
	private int MEMBER_CODE;

	private String APPLY_STUDY_VERIFY;
	private Date APPLY_STUDY_DATE;

	// MEMBER 정보 JOIN COLUMN
	private String MEMBER_NAME;
	private String MEMBER_EMAIL;
	private String MEMBER_PROFILE_IMAGE_S_NAME;

	public APPLY_STUDY() {
		super();
		// TODO Auto-generated constructor stub
	}

	public APPLY_STUDY(int sTUDY_CODE, int mEMBER_CODE, String aPPLY_STUDY_VERIFY, Date aPPLY_STUDY_DATE,
			String mEMBER_NAME, String mEMBER_EMAIL, String mEMBER_PROFILE_IMAGE_S_NAME) {
		super();
		STUDY_CODE = sTUDY_CODE;
		MEMBER_CODE = mEMBER_CODE;
		APPLY_STUDY_VERIFY = aPPLY_STUDY_VERIFY;
		APPLY_STUDY_DATE = aPPLY_STUDY_DATE;
		MEMBER_NAME = mEMBER_NAME;
		MEMBER_EMAIL = mEMBER_EMAIL;
		MEMBER_PROFILE_IMAGE_S_NAME = mEMBER_PROFILE_IMAGE_S_NAME;
	}

	public int getSTUDY_CODE() {
		return STUDY_CODE;
	}

	public void setSTUDY_CODE(int sTUDY_CODE) {
		STUDY_CODE = sTUDY_CODE;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public String getAPPLY_STUDY_VERIFY() {
		return APPLY_STUDY_VERIFY;
	}

	public void setAPPLY_STUDY_VERIFY(String aPPLY_STUDY_VERIFY) {
		APPLY_STUDY_VERIFY = aPPLY_STUDY_VERIFY;
	}

	public Date getAPPLY_STUDY_DATE() {
		return APPLY_STUDY_DATE;
	}

	public void setAPPLY_STUDY_DATE(Date aPPLY_STUDY_DATE) {
		APPLY_STUDY_DATE = aPPLY_STUDY_DATE;
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

	public String getMEMBER_PROFILE_IMAGE_S_NAME() {
		return MEMBER_PROFILE_IMAGE_S_NAME;
	}

	public void setMEMBER_PROFILE_IMAGE_S_NAME(String mEMBER_PROFILE_IMAGE_S_NAME) {
		MEMBER_PROFILE_IMAGE_S_NAME = mEMBER_PROFILE_IMAGE_S_NAME;
	}

	@Override
	public String toString() {
		return "APPLY_STUDY [STUDY_CODE=" + STUDY_CODE + ", MEMBER_CODE=" + MEMBER_CODE + ", APPLY_STUDY_VERIFY="
				+ APPLY_STUDY_VERIFY + ", APPLY_STUDY_DATE=" + APPLY_STUDY_DATE + ", MEMBER_NAME=" + MEMBER_NAME
				+ ", MEMBER_EMAIL=" + MEMBER_EMAIL + ", MEMBER_PROFILE_IMAGE_S_NAME=" + MEMBER_PROFILE_IMAGE_S_NAME
				+ "]";
	}

}
