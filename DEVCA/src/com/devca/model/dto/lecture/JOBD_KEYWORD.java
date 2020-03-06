package com.devca.model.dto.lecture;

public class JOBD_KEYWORD {
	private String TECH;
	private String IS_TECH;

	public JOBD_KEYWORD() {
		super();
		// TODO Auto-generated constructor stub
	}

	public JOBD_KEYWORD(String tECH, String iS_TECH) {
		super();
		TECH = tECH;
		IS_TECH = iS_TECH;
	}

	public String getTECH() {
		return TECH;
	}

	public void setTECH(String tECH) {
		TECH = tECH;
	}

	public String getIS_TECH() {
		return IS_TECH;
	}

	public void setIS_TECH(String iS_TECH) {
		IS_TECH = iS_TECH;
	}

	@Override
	public String toString() {
		return "JOBD_KEYWORD [TECH=" + TECH + ", IS_TECH=" + IS_TECH + "]";
	}

}
