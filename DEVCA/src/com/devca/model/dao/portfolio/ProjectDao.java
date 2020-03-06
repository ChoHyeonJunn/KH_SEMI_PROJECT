package com.devca.model.dao.portfolio;

import java.util.List;

import com.devca.model.dto.profile.PROJECT;

public interface ProjectDao {
	
	public List<PROJECT> project_select(int profile_seq);
	
	public int project_insert(PROJECT dto);
	
	public int project_update(PROJECT dto);
	
	public int project_delete(int project_seq, int profile_seq);
	
	public int project_insert_new(int member_code);
	
	public int project_count(int member_code);
}
