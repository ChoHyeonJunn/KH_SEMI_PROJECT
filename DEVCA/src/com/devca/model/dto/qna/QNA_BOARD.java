package com.devca.model.dto.qna;

import java.util.Date;

public class QNA_BOARD {

	private int QNA_BOARD_NO;
	private int QNA_POST_NO;
	private int QNA_GROUP_NO;
	private int QNA_GROUP_SEQ;
	private int MEMBER_CODE;
	private int QNA_TITLE_TAB;
	private String QNA_TITLE;
	private String QNA_CONTENT;
	private String MEMBER_NAME;
	private String MEMBER_EMAIL;
	private Date QNA_DATE;

	public QNA_BOARD() {
		super();
		// TODO Auto-generated constructor stub
	}

	public QNA_BOARD(int qNA_BOARD_NO, int qNA_POST_NO, int qNA_GROUP_NO, int qNA_GROUP_SEQ, int mEMBER_CODE,
			int qNA_TITLE_TAB, String qNA_TITLE, String qNA_CONTENT, String mEMBER_NAME, String mEMBER_EMAIL,
			Date qNA_DATE) {
		super();
		QNA_BOARD_NO = qNA_BOARD_NO;
		QNA_POST_NO = qNA_POST_NO;
		QNA_GROUP_NO = qNA_GROUP_NO;
		QNA_GROUP_SEQ = qNA_GROUP_SEQ;
		MEMBER_CODE = mEMBER_CODE;
		QNA_TITLE_TAB = qNA_TITLE_TAB;
		QNA_TITLE = qNA_TITLE;
		QNA_CONTENT = qNA_CONTENT;
		MEMBER_NAME = mEMBER_NAME;
		MEMBER_EMAIL = mEMBER_EMAIL;
		QNA_DATE = qNA_DATE;
	}

	public QNA_BOARD(String qNA_TITLE, String qNA_CONTENT, int mEMBER_CODE) {
		// TODO Auto-generated constructor stub
		QNA_TITLE = qNA_TITLE;
		QNA_CONTENT = qNA_CONTENT;
		MEMBER_CODE = mEMBER_CODE;
	}

	public QNA_BOARD(int qNA_BOARD_NO, String qNA_TITLE, String qNA_CONTENT) {
		// TODO Auto-generated constructor stub
		QNA_BOARD_NO = qNA_BOARD_NO;
		QNA_TITLE = qNA_TITLE;
		QNA_CONTENT = qNA_CONTENT;
	}

	public int getQNA_BOARD_NO() {
		return QNA_BOARD_NO;
	}

	public void setQNA_BOARD_NO(int qNA_BOARD_NO) {
		QNA_BOARD_NO = qNA_BOARD_NO;
	}

	public int getQNA_POST_NO() {
		return QNA_POST_NO;
	}

	public void setQNA_POST_NO(int qNA_POST_NO) {
		QNA_POST_NO = qNA_POST_NO;
	}

	public int getQNA_GROUP_NO() {
		return QNA_GROUP_NO;
	}

	public void setQNA_GROUP_NO(int qNA_GROUP_NO) {
		QNA_GROUP_NO = qNA_GROUP_NO;
	}

	public int getQNA_GROUP_SEQ() {
		return QNA_GROUP_SEQ;
	}

	public void setQNA_GROUP_SEQ(int qNA_GROUP_SEQ) {
		QNA_GROUP_SEQ = qNA_GROUP_SEQ;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public int getQNA_TITLE_TAB() {
		return QNA_TITLE_TAB;
	}

	public void setQNA_TITLE_TAB(int qNA_TITLE_TAB) {
		QNA_TITLE_TAB = qNA_TITLE_TAB;
	}

	public String getQNA_TITLE() {
		return QNA_TITLE;
	}

	public void setQNA_TITLE(String qNA_TITLE) {
		QNA_TITLE = qNA_TITLE;
	}

	public String getQNA_CONTENT() {
		return QNA_CONTENT;
	}

	public void setQNA_CONTENT(String qNA_CONTENT) {
		QNA_CONTENT = qNA_CONTENT;
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

	public Date getQNA_DATE() {
		return QNA_DATE;
	}

	public void setQNA_DATE(Date qNA_DATE) {
		QNA_DATE = qNA_DATE;
	}

	@Override
	public String toString() {
		return "QNA_BOARD [QNA_BOARD_NO=" + QNA_BOARD_NO + ", QNA_POST_NO=" + QNA_POST_NO + ", QNA_GROUP_NO="
				+ QNA_GROUP_NO + ", QNA_GROUP_SEQ=" + QNA_GROUP_SEQ + ", MEMBER_CODE=" + MEMBER_CODE
				+ ", QNA_TITLE_TAB=" + QNA_TITLE_TAB + ", QNA_TITLE=" + QNA_TITLE + ", QNA_CONTENT=" + QNA_CONTENT
				+ ", MEMBER_NAME=" + MEMBER_NAME + ", MEMBER_EMAIL=" + MEMBER_EMAIL + ", QNA_DATE=" + QNA_DATE + "]";
	}

}
