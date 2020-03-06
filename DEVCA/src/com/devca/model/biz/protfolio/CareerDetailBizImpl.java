package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.CareerDetailDao;
import com.devca.model.dao.portfolio.CareerDetailDaoImpl;
import com.devca.model.dto.profile.CAREER_DETAIL;

public class CareerDetailBizImpl implements CareerDetailBiz {

	CareerDetailDao dao = new CareerDetailDaoImpl();
	@Override
	public List<CAREER_DETAIL> career_detail_select(int career_seq) {
		return dao.career_detail_select(career_seq);
	}

	@Override
	public int career_detail_insert(CAREER_DETAIL dto) {
		return dao.career_detail_insert(dto);
	}

	@Override
	public int career_detail_update(CAREER_DETAIL dto) {
		return dao.career_detail_update(dto);
	}

	@Override
	public int career_detail_delete(int career_detail_seq, int career_seq) {
		return dao.career_detail_delete(career_detail_seq, career_seq);
	}

	@Override
	public CAREER_DETAIL career_detail_select_seq(int career_seq) {
		return dao.career_detail_select_seq(career_seq);
	}

	@Override
	public int career_detail_insert_new(int member_code) {
		return dao.career_detail_insert_new(member_code);
	}

	@Override
	public int career_detail_count(int member_code) {
		return dao.career_detail_count(member_code);
	}

}
