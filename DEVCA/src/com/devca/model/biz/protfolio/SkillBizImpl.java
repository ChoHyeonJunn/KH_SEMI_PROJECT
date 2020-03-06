package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.SkillDao;
import com.devca.model.dao.portfolio.SkillDaoImpl;
import com.devca.model.dto.profile.SKILL;

public class SkillBizImpl implements SkillBiz {

	SkillDao dao = new SkillDaoImpl();
	
	@Override
	public List<SKILL> skill_select(int profile_seq) {
		
		return dao.skill_select(profile_seq);
	}

	@Override
	public int skill_insert(SKILL dto) {
		// TODO Auto-generated method stub
		return dao.skill_insert(dto);
	}

	@Override
	public int skill_update(SKILL dto) {
		// TODO Auto-generated method stub
		return dao.skill_update(dto);
	}

	@Override
	public int skill_delete_one(int skill_seq, int profile_seq) {
		// TODO Auto-generated method stub
		return dao.skill_delete_one(skill_seq, profile_seq);
	}

	@Override
	public SKILL skill_select_one(int member_code) {
		return dao.skill_select_one(member_code);
	}

	@Override
	public int skill_count(int member_code) {
		return dao.skill_count(member_code);
	}

	@Override
	public List<SKILL> skill_select_seq(int member_code) {
		return dao.skill_select_seq(member_code);
	}

	@Override
	public int skill_delete(int member_code) {
		return dao.skill_delete(member_code);
	}

	@Override
	public int skill_insert_new(int member_code) {
		return dao.skill_insert_new(member_code);
	}
	
	

}
