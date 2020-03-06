package com.devca.model.dto.lecture;

public class MYLECTURE {
	private int MEMBER_CODE;
	private int LECTURE_CODE;

	public MYLECTURE() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MYLECTURE(int mEMBER_CODE, int lECTURE_CODE) {
		super();
		MEMBER_CODE = mEMBER_CODE;
		LECTURE_CODE = lECTURE_CODE;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public int getLECTURE_CODE() {
		return LECTURE_CODE;
	}

	public void setLECTURE_CODE(int lECTURE_CODE) {
		LECTURE_CODE = lECTURE_CODE;
	}

	@Override
	public String toString() {
		return "MYLECTURE [MEMBER_CODE=" + MEMBER_CODE + ", LECTURE_CODE=" + LECTURE_CODE + "]";
	}

}
