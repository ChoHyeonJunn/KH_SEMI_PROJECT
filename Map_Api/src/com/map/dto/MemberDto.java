package com.map.dto;

public class MemberDto {

	private int MEMBER_CODE;
	private String MEMBER_PROFILE_LATITUDE;
	private String MEMBER_PROFILE_LOGITUDE;
	public MemberDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MemberDto(int mEMBER_CODE, String mEMBER_PROFILE_LATITUDE, String mEMBER_PROFILE_LOGITUDE) {
		super();
		MEMBER_CODE = mEMBER_CODE;
		MEMBER_PROFILE_LATITUDE = mEMBER_PROFILE_LATITUDE;
		MEMBER_PROFILE_LOGITUDE = mEMBER_PROFILE_LOGITUDE;
	}
	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}
	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}
	public String getMEMBER_PROFILE_LATITUDE() {
		return MEMBER_PROFILE_LATITUDE;
	}
	public void setMEMBER_PROFILE_LATITUDE(String mEMBER_PROFILE_LATITUDE) {
		MEMBER_PROFILE_LATITUDE = mEMBER_PROFILE_LATITUDE;
	}
	public String getMEMBER_PROFILE_LOGITUDE() {
		return MEMBER_PROFILE_LOGITUDE;
	}
	public void setMEMBER_PROFILE_LOGITUDE(String mEMBER_PROFILE_LOGITUDE) {
		MEMBER_PROFILE_LOGITUDE = mEMBER_PROFILE_LOGITUDE;
	}

	
	
	

	
}
