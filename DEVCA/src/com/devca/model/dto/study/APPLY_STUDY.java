package com.devca.model.dto.study;

public class APPLY_STUDY {
	private int STUDY_CODE;
	private int MEMBER_CODE;

	private String APPLY_STUDY_VERIFY;

	public APPLY_STUDY() {
		super();
		// TODO Auto-generated constructor stub
	}

	public APPLY_STUDY(int sTUDY_CODE, int mEMBER_CODE, String aPPLY_STUDY_VERIFY) {
		super();
		STUDY_CODE = sTUDY_CODE;
		MEMBER_CODE = mEMBER_CODE;
		APPLY_STUDY_VERIFY = aPPLY_STUDY_VERIFY;
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

	@Override
	public String toString() {
		return "APPLY_STUDY [STUDY_CODE=" + STUDY_CODE + ", MEMBER_CODE=" + MEMBER_CODE + ", APPLY_STUDY_VERIFY="
				+ APPLY_STUDY_VERIFY + "]";
	}

}
