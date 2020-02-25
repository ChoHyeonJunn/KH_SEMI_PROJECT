package com.devca.model.dto.study;

import java.util.Date;

public class STUDY {
	private int STUDY_CODE;
	private int MEMBER_CODE;

	private String STUDY_TITLE;
	private String STUDY_CONTENT;
	private String STUDY_DATE;

	private String STUDY_LOGITUDE;
	private String STUDY_LATITUDE;
	private String STUDY_ADDRESS;

	private int STUDY_READCOUNT;

	public STUDY() {
		super();
		// TODO Auto-generated constructor stub
	}

	public STUDY(int sTUDY_CODE, int mEMBER_CODE, String sTUDY_TITLE, String sTUDY_CONTENT, String sTUDY_DATE,
			String sTUDY_LOGITUDE, String sTUDY_LATITUDE, String sTUDY_ADDRESS, int sTUDY_READCOUNT) {
		super();
		STUDY_CODE = sTUDY_CODE;
		MEMBER_CODE = mEMBER_CODE;
		STUDY_TITLE = sTUDY_TITLE;
		STUDY_CONTENT = sTUDY_CONTENT;
		STUDY_DATE = sTUDY_DATE;
		STUDY_LOGITUDE = sTUDY_LOGITUDE;
		STUDY_LATITUDE = sTUDY_LATITUDE;
		STUDY_ADDRESS = sTUDY_ADDRESS;
		STUDY_READCOUNT = sTUDY_READCOUNT;
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

	public String getSTUDY_TITLE() {
		return STUDY_TITLE;
	}

	public void setSTUDY_TITLE(String sTUDY_TITLE) {
		STUDY_TITLE = sTUDY_TITLE;
	}

	public String getSTUDY_CONTENT() {
		return STUDY_CONTENT;
	}

	public void setSTUDY_CONTENT(String sTUDY_CONTENT) {
		STUDY_CONTENT = sTUDY_CONTENT;
	}

	public String getSTUDY_DATE() {
		return STUDY_DATE;
	}

	public void setSTUDY_DATE(String sTUDY_DATE) {
		STUDY_DATE = sTUDY_DATE;
	}

	public String getSTUDY_LOGITUDE() {
		return STUDY_LOGITUDE;
	}

	public void setSTUDY_LOGITUDE(String sTUDY_LOGITUDE) {
		STUDY_LOGITUDE = sTUDY_LOGITUDE;
	}

	public String getSTUDY_LATITUDE() {
		return STUDY_LATITUDE;
	}

	public void setSTUDY_LATITUDE(String sTUDY_LATITUDE) {
		STUDY_LATITUDE = sTUDY_LATITUDE;
	}

	public String getSTUDY_ADDRESS() {
		return STUDY_ADDRESS;
	}

	public void setSTUDY_ADDRESS(String sTUDY_ADDRESS) {
		STUDY_ADDRESS = sTUDY_ADDRESS;
	}

	public int getSTUDY_READCOUNT() {
		return STUDY_READCOUNT;
	}

	public void setSTUDY_READCOUNT(int sTUDY_READCOUNT) {
		STUDY_READCOUNT = sTUDY_READCOUNT;
	}

	@Override
	public String toString() {
		return "STUDY [STUDY_CODE=" + STUDY_CODE + ", MEMBER_CODE=" + MEMBER_CODE + ", STUDY_TITLE=" + STUDY_TITLE
				+ ", STUDY_CONTENT=" + STUDY_CONTENT + ", STUDY_DATE=" + STUDY_DATE + ", STUDY_LOGITUDE="
				+ STUDY_LOGITUDE + ", STUDY_LATITUDE=" + STUDY_LATITUDE + ", STUDY_ADDRESS=" + STUDY_ADDRESS
				+ ", STUDY_READCOUNT=" + STUDY_READCOUNT + "]";
	}

}
