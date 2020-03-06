package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dto.profile.SCHOOL;

public interface SchoolBiz {

	public List<SCHOOL> school_select(int profile_seq);
	
	public int school_insert(SCHOOL dto);
	
	public int school_update(SCHOOL dto);
	
	public int school_delete(int school_seq, int profile_seq);

	public int school_count(int member_code);
	
	public int school_insert_new(int member_code);
}
