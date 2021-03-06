package com.devca.model.dto.member;

import java.util.Date;

public class SURVEY {
	private int SURVEY_SEQ;
	private int MEMBER_CODE;
	private String SURVEY_LANGUAGE; // 1 비개발자 2,3,4개발자
	private String SURVEY_POSITION; // 프론트->프론트 기본 셋, 백엔드->백엔드 기본 셋, 풀스택->풀스택 기본 셋(전공)
	private String SURVEY_BASIC; // 체크 -> 커리어맵에 표현(전공)
	private String SURVEY_SERVER; // 체크 -> 리어맵에 표현(전공)
	private String SURVEY_DATABASE; // 체크 -> 커리어맵에 표현(전공)
	private String SURVEY_FRAMEWORK; // 체크 -> 커리어맵에 표현(전공)

	private String SURVEY_CHECK_NON_MAJOR; // 체크 -> 1~5프론트,6~7백엔드(비전공)
	private String SURVEY_BASIC_NON_MAJOR; // 체크 -> 커리어맵에 표현(비전공)
	private String SURVEY_SERVER_NON_MAJOR; // 체크 -> 커리어맵에 표현(비전공)
	private String SURVEY_DATABASE_NON_MAJOR; // 체크 -> 커리어맵에 표현(비전공)
	private String SURVEY_FRAMEWORK_NON_MAJOR; // 체크 -> 커리어맵에 표현(비전공)
	public Date SURVEY_SYSDATE;

	public SURVEY(int sURVEY_SEQ, int mEMBER_CODE, String sURVEY_LANGUAGE, String sURVEY_POSITION, String sURVEY_BASIC,
			String sURVEY_SERVER, String sURVEY_DATABASE, String sURVEY_FRAMEWORK, String sURVEY_CHECK_NON_MAJOR,
			String sURVEY_BASIC_NON_MAJOR, String sURVEY_SERVER_NON_MAJOR, String sURVEY_DATABASE_NON_MAJOR,
			String sURVEY_FRAMEWORK_NON_MAJOR, Date sURVEY_SYSDATE) {
		super();
		SURVEY_SEQ = sURVEY_SEQ;
		MEMBER_CODE = mEMBER_CODE;
		SURVEY_LANGUAGE = sURVEY_LANGUAGE;
		SURVEY_POSITION = sURVEY_POSITION;
		SURVEY_BASIC = sURVEY_BASIC;
		SURVEY_SERVER = sURVEY_SERVER;
		SURVEY_DATABASE = sURVEY_DATABASE;
		SURVEY_FRAMEWORK = sURVEY_FRAMEWORK;
		SURVEY_CHECK_NON_MAJOR = sURVEY_CHECK_NON_MAJOR;
		SURVEY_BASIC_NON_MAJOR = sURVEY_BASIC_NON_MAJOR;
		SURVEY_SERVER_NON_MAJOR = sURVEY_SERVER_NON_MAJOR;
		SURVEY_DATABASE_NON_MAJOR = sURVEY_DATABASE_NON_MAJOR;
		SURVEY_FRAMEWORK_NON_MAJOR = sURVEY_FRAMEWORK_NON_MAJOR;
		SURVEY_SYSDATE = sURVEY_SYSDATE;
	}

	public SURVEY() {
		super();
	}

	public int getSURVEY_SEQ() {
		return SURVEY_SEQ;
	}

	public void setSURVEY_SEQ(int sURVEY_SEQ) {
		SURVEY_SEQ = sURVEY_SEQ;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public String getSURVEY_LANGUAGE() {
		return SURVEY_LANGUAGE;
	}

	public void setSURVEY_LANGUAGE(String sURVEY_LANGUAGE) {
		SURVEY_LANGUAGE = sURVEY_LANGUAGE;
	}

	public String getSURVEY_POSITION() {
		return SURVEY_POSITION;
	}

	public void setSURVEY_POSITION(String sURVEY_POSITION) {
		SURVEY_POSITION = sURVEY_POSITION;
	}

	public String getSURVEY_BASIC() {
		return SURVEY_BASIC;
	}

	public void setSURVEY_BASIC(String sURVEY_BASIC) {
		SURVEY_BASIC = sURVEY_BASIC;
	}

	public String getSURVEY_SERVER() {
		return SURVEY_SERVER;
	}

	public void setSURVEY_SERVER(String sURVEY_SERVER) {
		SURVEY_SERVER = sURVEY_SERVER;
	}

	public String getSURVEY_DATABASE() {
		return SURVEY_DATABASE;
	}

	public void setSURVEY_DATABASE(String sURVEY_DATABASE) {
		SURVEY_DATABASE = sURVEY_DATABASE;
	}

	public String getSURVEY_FRAMEWORK() {
		return SURVEY_FRAMEWORK;
	}

	public void setSURVEY_FRAMEWORK(String sURVEY_FRAMEWORK) {
		SURVEY_FRAMEWORK = sURVEY_FRAMEWORK;
	}

	public String getSURVEY_CHECK_NON_MAJOR() {
		return SURVEY_CHECK_NON_MAJOR;
	}

	public void setSURVEY_CHECK_NON_MAJOR(String sURVEY_CHECK_NON_MAJOR) {
		SURVEY_CHECK_NON_MAJOR = sURVEY_CHECK_NON_MAJOR;
	}

	public String getSURVEY_BASIC_NON_MAJOR() {
		return SURVEY_BASIC_NON_MAJOR;
	}

	public void setSURVEY_BASIC_NON_MAJOR(String sURVEY_BASIC_NON_MAJOR) {
		SURVEY_BASIC_NON_MAJOR = sURVEY_BASIC_NON_MAJOR;
	}

	public String getSURVEY_SERVER_NON_MAJOR() {
		return SURVEY_SERVER_NON_MAJOR;
	}

	public void setSURVEY_SERVER_NON_MAJOR(String sURVEY_SERVER_NON_MAJOR) {
		SURVEY_SERVER_NON_MAJOR = sURVEY_SERVER_NON_MAJOR;
	}

	public String getSURVEY_DATABASE_NON_MAJOR() {
		return SURVEY_DATABASE_NON_MAJOR;
	}

	public void setSURVEY_DATABASE_NON_MAJOR(String sURVEY_DATABASE_NON_MAJOR) {
		SURVEY_DATABASE_NON_MAJOR = sURVEY_DATABASE_NON_MAJOR;
	}

	public String getSURVEY_FRAMEWORK_NON_MAJOR() {
		return SURVEY_FRAMEWORK_NON_MAJOR;
	}

	public void setSURVEY_FRAMEWORK_NON_MAJOR(String sURVEY_FRAMEWORK_NON_MAJOR) {
		SURVEY_FRAMEWORK_NON_MAJOR = sURVEY_FRAMEWORK_NON_MAJOR;
	}

	public Date getSURVEY_SYSDATE() {
		return SURVEY_SYSDATE;
	}

	public void setSURVEY_SYSDATE(Date sURVEY_SYSDATE) {
		SURVEY_SYSDATE = sURVEY_SYSDATE;
	}

	@Override
	public String toString() {
		return "SURVEY [SURVEY_SEQ=" + SURVEY_SEQ + ", MEMBER_CODE=" + MEMBER_CODE + ", SURVEY_LANGUAGE="
				+ SURVEY_LANGUAGE + ", SURVEY_POSITION=" + SURVEY_POSITION + ", SURVEY_BASIC=" + SURVEY_BASIC
				+ ", SURVEY_SERVER=" + SURVEY_SERVER + ", SURVEY_DATABASE=" + SURVEY_DATABASE + ", SURVEY_FRAMEWORK="
				+ SURVEY_FRAMEWORK + ", SURVEY_CHECK_NON_MAJOR=" + SURVEY_CHECK_NON_MAJOR + ", SURVEY_BASIC_NON_MAJOR="
				+ SURVEY_BASIC_NON_MAJOR + ", SURVEY_SERVER_NON_MAJOR=" + SURVEY_SERVER_NON_MAJOR
				+ ", SURVEY_DATABASE_NON_MAJOR=" + SURVEY_DATABASE_NON_MAJOR + ", SURVEY_FRAMEWORK_NON_MAJOR="
				+ SURVEY_FRAMEWORK_NON_MAJOR + ", SURVEY_SYSDATE=" + SURVEY_SYSDATE + "]";
	}
}