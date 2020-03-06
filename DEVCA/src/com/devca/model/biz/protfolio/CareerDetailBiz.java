package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dto.profile.CAREER_DETAIL;

public interface CareerDetailBiz {

	public List<CAREER_DETAIL> career_detail_select(int career_seq);
	
	public CAREER_DETAIL career_detail_select_seq(int career_seq);
	
	public int career_detail_insert(CAREER_DETAIL dto);
	
	public int career_detail_update(CAREER_DETAIL dto);
	
	public int career_detail_delete(int career_detail_seq, int career_seq);
	
	public int career_detail_insert_new(int member_code);
	
	public int career_detail_count(int member_code);
}
