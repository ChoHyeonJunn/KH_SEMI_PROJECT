package com.devca.model.dto.lecture;

public class LECTURE {
	private int LECTURE_CODE;
	private String LECTURE_TITLE;
	private String LECTURE_IMG;
	private String LECTURE_LINK;


	private String LECTURE_PAYFLAG;

	private String LECTURE_ADDRESS;
	private String LECTURE_LATITUDE;
	private String LECTURE_LOGITUDE;

	private String LECTURE_RATE;
	private int LECTURE_READCOUNT;
	
	private String LECTURE_DESCRIPTION;
	private String LECTURE_CONTENT;
	
	public LECTURE() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LECTURE(int lECTURE_CODE, String lECTURE_TITLE, String lECTURE_IMG, String lECTURE_LINK,
			String lECTURE_DESCRIPTION, String lECTURE_CONTENT, String lECTURE_PAYFLAG, String lECTURE_ADDRESS,
			String lECTURE_LATITUDE, String lECTURE_LOGITUDE, String lECTURE_RATE, int lECTURE_READCOUNT) {
		super();
		LECTURE_CODE = lECTURE_CODE;
		LECTURE_TITLE = lECTURE_TITLE;
		LECTURE_IMG = lECTURE_IMG;
		LECTURE_LINK = lECTURE_LINK;
		LECTURE_DESCRIPTION = lECTURE_DESCRIPTION;
		LECTURE_CONTENT = lECTURE_CONTENT;
		LECTURE_PAYFLAG = lECTURE_PAYFLAG;
		LECTURE_ADDRESS = lECTURE_ADDRESS;
		LECTURE_LATITUDE = lECTURE_LATITUDE;
		LECTURE_LOGITUDE = lECTURE_LOGITUDE;
		LECTURE_RATE = lECTURE_RATE;
		LECTURE_READCOUNT = lECTURE_READCOUNT;
	}

	public int getLECTURE_CODE() {
		return LECTURE_CODE;
	}

	public void setLECTURE_CODE(int lECTURE_CODE) {
		LECTURE_CODE = lECTURE_CODE;
	}

	public String getLECTURE_TITLE() {
		return LECTURE_TITLE;
	}

	public void setLECTURE_TITLE(String lECTURE_TITLE) {
		LECTURE_TITLE = lECTURE_TITLE;
	}

	public String getLECTURE_IMG() {
		return LECTURE_IMG;
	}

	public void setLECTURE_IMG(String lECTURE_IMG) {
		LECTURE_IMG = lECTURE_IMG;
	}

	public String getLECTURE_LINK() {
		return LECTURE_LINK;
	}

	public void setLECTURE_LINK(String lECTURE_LINK) {
		LECTURE_LINK = lECTURE_LINK;
	}

	public String getLECTURE_DESCRIPTION() {
		return LECTURE_DESCRIPTION;
	}

	public void setLECTURE_DESCRIPTION(String lECTURE_DESCRIPTION) {
		LECTURE_DESCRIPTION = lECTURE_DESCRIPTION;
	}

	public String getLECTURE_CONTENT() {
		return LECTURE_CONTENT;
	}

	public void setLECTURE_CONTENT(String lECTURE_CONTENT) {
		LECTURE_CONTENT = lECTURE_CONTENT;
	}

	public String getLECTURE_PAYFLAG() {
		return LECTURE_PAYFLAG;
	}

	public void setLECTURE_PAYFLAG(String lECTURE_PAYFLAG) {
		LECTURE_PAYFLAG = lECTURE_PAYFLAG;
	}

	public String getLECTURE_ADDRESS() {
		return LECTURE_ADDRESS;
	}

	public void setLECTURE_ADDRESS(String lECTURE_ADDRESS) {
		LECTURE_ADDRESS = lECTURE_ADDRESS;
	}

	public String getLECTURE_LATITUDE() {
		return LECTURE_LATITUDE;
	}

	public void setLECTURE_LATITUDE(String lECTURE_LATITUDE) {
		LECTURE_LATITUDE = lECTURE_LATITUDE;
	}

	public String getLECTURE_LOGITUDE() {
		return LECTURE_LOGITUDE;
	}

	public void setLECTURE_LOGITUDE(String lECTURE_LOGITUDE) {
		LECTURE_LOGITUDE = lECTURE_LOGITUDE;
	}

	public String getLECTURE_RATE() {
		return LECTURE_RATE;
	}

	public void setLECTURE_RATE(String lECTURE_RATE) {
		LECTURE_RATE = lECTURE_RATE;
	}

	public int getLECTURE_READCOUNT() {
		return LECTURE_READCOUNT;
	}

	public void setLECTURE_READCOUNT(int lECTURE_READCOUNT) {
		LECTURE_READCOUNT = lECTURE_READCOUNT;
	}

	@Override
	public String toString() {
		return "LECTURE [LECTURE_CODE=" + LECTURE_CODE + ", LECTURE_TITLE=" + LECTURE_TITLE + ", LECTURE_IMG="
				+ LECTURE_IMG + ", LECTURE_LINK=" + LECTURE_LINK + ", LECTURE_DESCRIPTION=" + LECTURE_DESCRIPTION
				+ ", LECTURE_CONTENT=" + LECTURE_CONTENT + ", LECTURE_PAYFLAG=" + LECTURE_PAYFLAG + ", LECTURE_ADDRESS="
				+ LECTURE_ADDRESS + ", LECTURE_LATITUDE=" + LECTURE_LATITUDE + ", LECTURE_LOGITUDE=" + LECTURE_LOGITUDE
				+ ", LECTURE_RATE=" + LECTURE_RATE + ", LECTURE_READCOUNT=" + LECTURE_READCOUNT + "]";
	}

}
