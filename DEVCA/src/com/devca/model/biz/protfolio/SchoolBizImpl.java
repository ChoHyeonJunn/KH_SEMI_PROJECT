package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.SchoolDao;
import com.devca.model.dao.portfolio.SchoolDaoImpl;
import com.devca.model.dto.profile.SCHOOL;

public class SchoolBizImpl implements SchoolBiz {
	
	SchoolDao dao = new SchoolDaoImpl();
	@Override
	public List<SCHOOL> school_select(int profile_seq) {
		return dao.school_select(profile_seq);
	}

	@Override
	public int school_insert(SCHOOL dto) {
		return dao.school_insert(dto);
	}

	@Override
	public int school_update(SCHOOL dto) {
		return dao.school_update(dto);
	}

	@Override
	public int school_delete(int school_seq, int profile_seq) {
		return dao.school_delete(school_seq, profile_seq);
	}

	@Override
	public int school_count(int member_code) {
		return dao.school_count(member_code);
	}

	@Override
	public int school_insert_new(int member_code) {
		return dao.school_insert_new(member_code);
	}

}
