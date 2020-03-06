package com.devca.model.dto.lecture;

import java.text.SimpleDateFormat;
import java.util.Date;

public class REVIEW {
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	private int REVIEW_CODE;
	private int MEMBER_CODE;
	private int LECTURE_CODE;

	private String REVIEW_WRITER;
	private String REVIEW_TITLE;
	private String REVIEW_CONTENT;
	private Date REVIEW_REGDATE;
	private String REVIEW_RATE;

	private String MEMBER_PROFILE_IMAGE_S_NAME;

	public REVIEW() {
		super();
		// TODO Auto-generated constructor stub
	}

	public REVIEW(int rEVIEW_CODE, int mEMBER_CODE, int lECTURE_CODE, String rEVIEW_WRITER, String rEVIEW_TITLE,
			String rEVIEW_CONTENT, Date rEVIEW_REGDATE, String rEVIEW_RATE, String mEMBER_PROFILE_IMAGE_S_NAME) {
		super();
		REVIEW_CODE = rEVIEW_CODE;
		MEMBER_CODE = mEMBER_CODE;
		LECTURE_CODE = lECTURE_CODE;
		REVIEW_WRITER = rEVIEW_WRITER;
		REVIEW_TITLE = rEVIEW_TITLE;
		REVIEW_CONTENT = rEVIEW_CONTENT;
		REVIEW_REGDATE = rEVIEW_REGDATE;
		REVIEW_RATE = rEVIEW_RATE;
		MEMBER_PROFILE_IMAGE_S_NAME = mEMBER_PROFILE_IMAGE_S_NAME;
	}

	public int getREVIEW_CODE() {
		return REVIEW_CODE;
	}

	public void setREVIEW_CODE(int rEVIEW_CODE) {
		REVIEW_CODE = rEVIEW_CODE;
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

	public String getREVIEW_WRITER() {
		return REVIEW_WRITER;
	}

	public void setREVIEW_WRITER(String rEVIEW_WRITER) {
		REVIEW_WRITER = rEVIEW_WRITER;
	}

	public String getREVIEW_TITLE() {
		return REVIEW_TITLE;
	}

	public void setREVIEW_TITLE(String rEVIEW_TITLE) {
		REVIEW_TITLE = rEVIEW_TITLE;
	}

	public String getREVIEW_CONTENT() {
		return REVIEW_CONTENT;
	}

	public void setREVIEW_CONTENT(String rEVIEW_CONTENT) {
		REVIEW_CONTENT = rEVIEW_CONTENT;
	}

	public String getREVIEW_REGDATE() {
		return df.format(REVIEW_REGDATE);
	}

	public void setREVIEW_REGDATE(Date rEVIEW_REGDATE) {
		REVIEW_REGDATE = rEVIEW_REGDATE;
	}

	public String getREVIEW_RATE() {
		return REVIEW_RATE;
	}

	public void setREVIEW_RATE(String rEVIEW_RATE) {
		REVIEW_RATE = rEVIEW_RATE;
	}

	public String getMEMBER_PROFILE_IMAGE_S_NAME() {
		return MEMBER_PROFILE_IMAGE_S_NAME;
	}

	public void setMEMBER_PROFILE_IMAGE_S_NAME(String mEMBER_PROFILE_IMAGE_S_NAME) {
		MEMBER_PROFILE_IMAGE_S_NAME = mEMBER_PROFILE_IMAGE_S_NAME;
	}

	@Override
	public String toString() {
		return "REVIEW [REVIEW_CODE=" + REVIEW_CODE + ", MEMBER_CODE=" + MEMBER_CODE + ", LECTURE_CODE=" + LECTURE_CODE
				+ ", REVIEW_WRITER=" + REVIEW_WRITER + ", REVIEW_TITLE=" + REVIEW_TITLE + ", REVIEW_CONTENT="
				+ REVIEW_CONTENT + ", REVIEW_REGDATE=" + REVIEW_REGDATE + ", REVIEW_RATE=" + REVIEW_RATE
				+ ", MEMBER_PROFILE_IMAGE_S_NAME=" + MEMBER_PROFILE_IMAGE_S_NAME + "]";
	}

}
