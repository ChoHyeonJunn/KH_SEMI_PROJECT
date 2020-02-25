package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.ProjectDao;
import com.devca.model.dao.portfolio.ProjectDaoImpl;
import com.devca.model.dto.PROJECT;

public class ProjectBizImpl implements ProjectBiz {

	ProjectDao dao = new ProjectDaoImpl();
	@Override
	public List<PROJECT> project_select(int profile_seq) {
		return dao.project_select(profile_seq);
	}

	@Override
	public int project_insert(PROJECT dto) {
		return dao.project_insert(dto);
	}

	@Override
	public int project_update(PROJECT dto) {
		return dao.project_update(dto);
	}

	@Override
	public int project_delete(int project_seq, int profile_seq) {
		return dao.project_delete(project_seq, profile_seq);
	}

	@Override
	public int project_insert_new(int member_code) {
		// TODO Auto-generated method stub
		return dao.project_insert_new(member_code);
	}

	@Override
	public int project_count(int member_code) {
		// TODO Auto-generated method stub
		return dao.project_count(member_code);
	}

}
