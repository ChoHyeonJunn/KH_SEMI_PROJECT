package com.devca.model.dto.profile;

public class LANGUAGE_CERTIFICATE {
	
	private int LANGUAGE_CERTIFICATE_SEQ;
	private int LANGUAGE_SEQ;
	private String LANGUAGE_CERTIFICATE_NAME;
	private String LANGUAGE_CERTIFICATE_GRADE;
	public LANGUAGE_CERTIFICATE() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LANGUAGE_CERTIFICATE(int lANGUAGE_CERTIFICATE_SEQ, int lANGUAGE_SEQ, String lANGUAGE_CERTIFICATE_NAME,
			String lANGUAGE_CERTIFICATE_GRADE) {
		super();
		LANGUAGE_CERTIFICATE_SEQ = lANGUAGE_CERTIFICATE_SEQ;
		LANGUAGE_SEQ = lANGUAGE_SEQ;
		LANGUAGE_CERTIFICATE_NAME = lANGUAGE_CERTIFICATE_NAME;
		LANGUAGE_CERTIFICATE_GRADE = lANGUAGE_CERTIFICATE_GRADE;
	}
	public int getLANGUAGE_CERTIFICATE_SEQ() {
		return LANGUAGE_CERTIFICATE_SEQ;
	}
	public void setLANGUAGE_CERTIFICATE_SEQ(int lANGUAGE_CERTIFICATE_SEQ) {
		LANGUAGE_CERTIFICATE_SEQ = lANGUAGE_CERTIFICATE_SEQ;
	}
	public int getLANGUAGE_SEQ() {
		return LANGUAGE_SEQ;
	}
	public void setLANGUAGE_SEQ(int lANGUAGE_SEQ) {
		LANGUAGE_SEQ = lANGUAGE_SEQ;
	}
	public String getLANGUAGE_CERTIFICATE_NAME() {
		return LANGUAGE_CERTIFICATE_NAME;
	}
	public void setLANGUAGE_CERTIFICATE_NAME(String lANGUAGE_CERTIFICATE_NAME) {
		LANGUAGE_CERTIFICATE_NAME = lANGUAGE_CERTIFICATE_NAME;
	}
	public String getLANGUAGE_CERTIFICATE_GRADE() {
		return LANGUAGE_CERTIFICATE_GRADE;
	}
	public void setLANGUAGE_CERTIFICATE_GRADE(String lANGUAGE_CERTIFICATE_GRADE) {
		LANGUAGE_CERTIFICATE_GRADE = lANGUAGE_CERTIFICATE_GRADE;
	}
	
	
	
}
