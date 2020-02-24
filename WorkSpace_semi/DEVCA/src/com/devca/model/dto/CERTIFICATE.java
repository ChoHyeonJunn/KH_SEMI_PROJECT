package com.devca.model.dto;

import java.sql.Date;

public class CERTIFICATE {
	
	/* 자격증(CERTIFICATE) 테이블 */
	private int CERTIFICATE_MEMBER_CODE;
	private int CERTIFICATE_SEQ;
	private String CERTIFICATE_NAME;
	private Date CERTIFICATE_DATE;
	private String CERTIFICATE_LINK;
	private String CERTIFICATE_EX_TEXT;
	
	public CERTIFICATE() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CERTIFICATE(int cERTIFICATE_MEMBER_CODE, int cERTIFICATE_SEQ, String cERTIFICATE_NAME, Date cERTIFICATE_DATE,
			String cERTIFICATE_LINK, String cERTIFICATE_EX_TEXT) {
		super();
		CERTIFICATE_MEMBER_CODE = cERTIFICATE_MEMBER_CODE;
		CERTIFICATE_SEQ = cERTIFICATE_SEQ;
		CERTIFICATE_NAME = cERTIFICATE_NAME;
		CERTIFICATE_DATE = cERTIFICATE_DATE;
		CERTIFICATE_LINK = cERTIFICATE_LINK;
		CERTIFICATE_EX_TEXT = cERTIFICATE_EX_TEXT;
	}

	public int getCERTIFICATE_MEMBER_CODE() {
		return CERTIFICATE_MEMBER_CODE;
	}

	public void setCERTIFICATE_MEMBER_CODE(int cERTIFICATE_MEMBER_CODE) {
		CERTIFICATE_MEMBER_CODE = cERTIFICATE_MEMBER_CODE;
	}

	public int getCERTIFICATE_SEQ() {
		return CERTIFICATE_SEQ;
	}

	public void setCERTIFICATE_SEQ(int cERTIFICATE_SEQ) {
		CERTIFICATE_SEQ = cERTIFICATE_SEQ;
	}

	public String getCERTIFICATE_NAME() {
		return CERTIFICATE_NAME;
	}

	public void setCERTIFICATE_NAME(String cERTIFICATE_NAME) {
		CERTIFICATE_NAME = cERTIFICATE_NAME;
	}

	public Date getCERTIFICATE_DATE() {
		return CERTIFICATE_DATE;
	}

	public void setCERTIFICATE_DATE(Date cERTIFICATE_DATE) {
		CERTIFICATE_DATE = cERTIFICATE_DATE;
	}

	public String getCERTIFICATE_LINK() {
		return CERTIFICATE_LINK;
	}

	public void setCERTIFICATE_LINK(String cERTIFICATE_LINK) {
		CERTIFICATE_LINK = cERTIFICATE_LINK;
	}

	public String getCERTIFICATE_EX_TEXT() {
		return CERTIFICATE_EX_TEXT;
	}

	public void setCERTIFICATE_EX_TEXT(String cERTIFICATE_EX_TEXT) {
		CERTIFICATE_EX_TEXT = cERTIFICATE_EX_TEXT;
	}

	
	
}
