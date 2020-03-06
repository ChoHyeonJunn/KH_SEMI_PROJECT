package com.devca.model.dto;

import java.util.Date;

public class QNA_COMMENT {

	private int COMMENT_NO;
	private int COMMENT_BOARD_NO;
	private String COMMENT_WRITER;
	private String COMMENT_CONTENT;
	private Date COMMENT_DATE;
	private int COMMENT_GROUP_NO;
	private int COMMENT_GROUP_ORDER;
	private int COMMENT_GROUP_DEPTH;

	public QNA_COMMENT() {
		super();
		// TODO Auto-generated constructor stub
	}

	public QNA_COMMENT(int cOMMENT_NO, int cOMMENT_BOARD_NO, String cOMMENT_WRITER, String cOMMENT_CONTENT,
			Date cOMMENT_DATE, int cOMMENT_GROUP_NO, int cOMMENT_GROUP_ORDER, int cOMMENT_GROUP_DEPTH) {
		super();
		COMMENT_NO = cOMMENT_NO;
		COMMENT_BOARD_NO = cOMMENT_BOARD_NO;
		COMMENT_WRITER = cOMMENT_WRITER;
		COMMENT_CONTENT = cOMMENT_CONTENT;
		COMMENT_DATE = cOMMENT_DATE;
		COMMENT_GROUP_NO = cOMMENT_GROUP_NO;
		COMMENT_GROUP_ORDER = cOMMENT_GROUP_ORDER;
		COMMENT_GROUP_DEPTH = cOMMENT_GROUP_DEPTH;
	}

	public int getCOMMENT_NO() {
		return COMMENT_NO;
	}

	public void setCOMMENT_NO(int cOMMENT_NO) {
		COMMENT_NO = cOMMENT_NO;
	}

	public int getCOMMENT_BOARD_NO() {
		return COMMENT_BOARD_NO;
	}

	public void setCOMMENT_BOARD_NO(int cOMMENT_BOARD_NO) {
		COMMENT_BOARD_NO = cOMMENT_BOARD_NO;
	}

	public String getCOMMENT_WRITER() {
		return COMMENT_WRITER;
	}

	public void setCOMMENT_WRITER(String cOMMENT_WRITER) {
		COMMENT_WRITER = cOMMENT_WRITER;
	}

	public String getCOMMENT_CONTENT() {
		return COMMENT_CONTENT;
	}

	public void setCOMMENT_CONTENT(String cOMMENT_CONTENT) {
		COMMENT_CONTENT = cOMMENT_CONTENT;
	}

	public Date getCOMMENT_DATE() {
		return COMMENT_DATE;
	}

	public void setCOMMENT_DATE(Date cOMMENT_DATE) {
		COMMENT_DATE = cOMMENT_DATE;
	}

	public int getCOMMENT_GROUP_NO() {
		return COMMENT_GROUP_NO;
	}

	public void setCOMMENT_GROUP_NO(int cOMMENT_GROUP_NO) {
		COMMENT_GROUP_NO = cOMMENT_GROUP_NO;
	}

	public int getCOMMENT_GROUP_ORDER() {
		return COMMENT_GROUP_ORDER;
	}

	public void setCOMMENT_GROUP_ORDER(int cOMMENT_GROUP_ORDER) {
		COMMENT_GROUP_ORDER = cOMMENT_GROUP_ORDER;
	}

	public int getCOMMENT_GROUP_DEPTH() {
		return COMMENT_GROUP_DEPTH;
	}

	public void setCOMMENT_GROUP_DEPTH(int cOMMENT_GROUP_DEPTH) {
		COMMENT_GROUP_DEPTH = cOMMENT_GROUP_DEPTH;
	}

	

}
