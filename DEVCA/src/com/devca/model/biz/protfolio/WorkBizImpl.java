package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.WorkDao;
import com.devca.model.dao.portfolio.WorkDaoImpl;
import com.devca.model.dto.profile.WORK;

public class WorkBizImpl implements WorkBiz {

	WorkDao dao = new WorkDaoImpl();
	@Override
	public List<WORK> work_select(int profile_seq) {
		return dao.work_select(profile_seq);
	}

	@Override
	public int work_insert(WORK dto) {
		return dao.work_insert(dto);
	}

	@Override
	public int work_update(WORK dto) {
		return dao.work_update(dto);
	}

	@Override
	public int work_delete_one(int work_seq, int profile_seq) {
		return dao.work_delete_one(work_seq, profile_seq);
	}

	@Override
	public WORK work_select_seq(int member_code) {
		return dao.work_select_seq(member_code);
	}

	@Override
	public int work_delete(int member_code) {
		return dao.work_delete(member_code);
	}

	@Override
	public int work_count(int member_code) {
		return dao.work_count(member_code);
	}

	@Override
	public int work_insert_new(int member_code) {
		return dao.work_insert_new(member_code);
	}

}
