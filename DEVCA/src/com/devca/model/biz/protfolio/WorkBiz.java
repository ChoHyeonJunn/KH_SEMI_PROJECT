package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dto.profile.WORK;

public interface WorkBiz {
	
	public List<WORK> work_select(int profile_seq);
	
	public WORK work_select_seq(int member_code);
	
	public int work_insert(WORK dto);
	
	public int work_update(WORK dto);
	
	public int work_delete_one(int work_seq, int profile_seq);
	
	public int work_delete(int member_code);
	
	public int work_count(int member_code);
	
	public int work_insert_new(int member_code);
}
