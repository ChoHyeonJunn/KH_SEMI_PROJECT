package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dto.CAREER;

public interface CareerBiz {
	public List<CAREER> career_select(int profile_seq);
	
	public CAREER career_select_seq(int profile_seq);
	
	public int career_insert(CAREER dto);
	
	public int career_update(CAREER dto);
	
	public int career_delete(int profile_seq, int career_seq);
	
	public int career_count(int member_code);
	
	public int career_insert_new(int member_code);
	
}

