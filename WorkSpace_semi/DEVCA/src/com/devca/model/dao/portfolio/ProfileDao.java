package com.devca.model.dao.portfolio;

import java.util.List;

import com.devca.model.dto.PROFILE;

public interface ProfileDao {
	
	// 프로필 검색 
	public List<PROFILE> profile_select(int member_code);
	
	// 프로필 번호 참조
	public PROFILE profile_select_seq(int member_code);	
	
	// 프로필 생성
	public int profile_insert(PROFILE dto);

	// 프로필 수정
	public int profile_update(PROFILE dto);

	// 프로필 삭제
	public int profile_delete(int member_code, int profile_Seq);
}
