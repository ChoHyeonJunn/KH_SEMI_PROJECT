package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dto.profile.SKILL;

public interface SkillBiz {

	public List<SKILL> skill_select(int profile_seq);
	
	public int skill_insert(SKILL dto);
	
	public int skill_update(SKILL dto);
	
	public int skill_delete_one(int skill_seq, int profile_seq);
	
	public SKILL skill_select_one(int member_code);
	
	public int skill_count(int member_code);
	
	public List<SKILL> skill_select_seq(int member_code);
	
	public int skill_delete(int member_code);
	
	public int skill_insert_new(int member_code);

}
