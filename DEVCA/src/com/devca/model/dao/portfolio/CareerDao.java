package com.devca.model.dao.portfolio;

import java.util.List;

import com.devca.model.dto.profile.CAREER;

public interface CareerDao {
	//커리어 조회
	public List<CAREER> career_select(int profile_seq);
	
	//커리어 번호 참조 = 상세내역 조회용
	public CAREER career_select_seq(int profile_seq);
	
	public int career_insert(CAREER dto);
	
	public int career_update(CAREER dto);
	
	public int career_delete(int profile_seq, int career_seq);
	
	public int career_count(int member_code);
	
	public int career_insert_new(int member_code);
	
	public int career_date(int member_code);
	
}
