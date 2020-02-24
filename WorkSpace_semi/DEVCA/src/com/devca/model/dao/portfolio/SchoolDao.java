package com.devca.model.dao.portfolio;

import java.util.List;

import com.devca.model.dto.SCHOOL;

public interface SchoolDao {

	public List<SCHOOL> school_select(int profile_seq);
	
	public int school_insert(SCHOOL dto);
	
	public int school_update(SCHOOL dto);
	
	public int school_delete(int school_seq, int profile_seq);
}
