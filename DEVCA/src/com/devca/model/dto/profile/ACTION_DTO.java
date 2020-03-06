package com.devca.model.dto.profile;

import java.sql.Date;

public class ACTION_DTO {
	
	private int ACTION_SEQ;
	private int ACTION_MEMBER_CODE;
	private String ACTION_NAME;
	private String ACTION_START_DATE;
	private String ACTION_END_DATE;
	private String ACTION_LINK;
	private String ACTION_EX_TEXT;
	public ACTION_DTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ACTION_DTO(int aCTION_SEQ, int aCTION_MEMBER_CODE, String aCTION_NAME, String aCTION_START_DATE,
			String aCTION_END_DATE, String aCTION_LINK, String aCTION_EX_TEXT) {
		super();
		ACTION_SEQ = aCTION_SEQ;
		ACTION_MEMBER_CODE = aCTION_MEMBER_CODE;
		ACTION_NAME = aCTION_NAME;
		ACTION_START_DATE = aCTION_START_DATE;
		ACTION_END_DATE = aCTION_END_DATE;
		ACTION_LINK = aCTION_LINK;
		ACTION_EX_TEXT = aCTION_EX_TEXT;
	}
	public int getACTION_SEQ() {
		return ACTION_SEQ;
	}
	public void setACTION_SEQ(int aCTION_SEQ) {
		ACTION_SEQ = aCTION_SEQ;
	}
	public int getACTION_MEMBER_CODE() {
		return ACTION_MEMBER_CODE;
	}
	public void setACTION_MEMBER_CODE(int aCTION_MEMBER_CODE) {
		ACTION_MEMBER_CODE = aCTION_MEMBER_CODE;
	}
	public String getACTION_NAME() {
		return ACTION_NAME;
	}
	public void setACTION_NAME(String aCTION_NAME) {
		ACTION_NAME = aCTION_NAME;
	}
	public String getACTION_START_DATE() {
		return ACTION_START_DATE;
	}
	public void setACTION_START_DATE(String aCTION_START_DATE) {
		ACTION_START_DATE = aCTION_START_DATE;
	}
	public String getACTION_END_DATE() {
		return ACTION_END_DATE;
	}
	public void setACTION_END_DATE(String aCTION_END_DATE) {
		ACTION_END_DATE = aCTION_END_DATE;
	}
	public String getACTION_LINK() {
		return ACTION_LINK;
	}
	public void setACTION_LINK(String aCTION_LINK) {
		ACTION_LINK = aCTION_LINK;
	}
	public String getACTION_EX_TEXT() {
		return ACTION_EX_TEXT;
	}
	public void setACTION_EX_TEXT(String aCTION_EX_TEXT) {
		ACTION_EX_TEXT = aCTION_EX_TEXT;
	}
	
	
}
