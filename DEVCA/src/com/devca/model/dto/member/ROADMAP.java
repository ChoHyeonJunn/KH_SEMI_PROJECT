package com.devca.model.dto.member;

public class ROADMAP {
	private int ROADMAP_CODE;
	private int MEMBER_CODE;
	private String ROADMAP_FIELD;
	private String ROADMAP_TECH;

	public ROADMAP() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ROADMAP(int rOADMAP_CODE, int mEMBER_CODE, String rOADMAP_FIELD, String rOADMAP_TECH) {
		super();
		ROADMAP_CODE = rOADMAP_CODE;
		MEMBER_CODE = mEMBER_CODE;
		ROADMAP_FIELD = rOADMAP_FIELD;
		ROADMAP_TECH = rOADMAP_TECH;
	}

	public int getROADMAP_CODE() {
		return ROADMAP_CODE;
	}

	public void setROADMAP_CODE(int rOADMAP_CODE) {
		ROADMAP_CODE = rOADMAP_CODE;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public String getROADMAP_FIELD() {
		return ROADMAP_FIELD;
	}

	public void setROADMAP_FIELD(String rOADMAP_FIELD) {
		ROADMAP_FIELD = rOADMAP_FIELD;
	}

	public String getROADMAP_TECH() {
		return ROADMAP_TECH;
	}

	public void setROADMAP_TECH(String rOADMAP_TECH) {
		ROADMAP_TECH = rOADMAP_TECH;
	}

	@Override
	public String toString() {
		return "ROADMAP [ROADMAP_CODE=" + ROADMAP_CODE + ", MEMBER_CODE=" + MEMBER_CODE + ", ROADMAP_FIELD="
				+ ROADMAP_FIELD + ", ROADMAP_TECH=" + ROADMAP_TECH + "]";
	}

}
