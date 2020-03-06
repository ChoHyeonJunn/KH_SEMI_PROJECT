package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.CareerDao;
import com.devca.model.dao.portfolio.CareerDaoImpl;
import com.devca.model.dto.profile.CAREER;

public class CareerBizImpl implements CareerBiz {
	
	CareerDao dao = new CareerDaoImpl();
	@Override
	public List<CAREER> career_select(int profile_seq) {
		return dao.career_select(profile_seq);
	}

	@Override
	public CAREER career_select_seq(int profile_seq) {
		return dao.career_select_seq(profile_seq);
	}

	@Override
	public int career_insert(CAREER dto) {
		return dao.career_insert(dto);
	}

	@Override
	public int career_update(CAREER dto) {
		return dao.career_update(dto);
	}

	@Override
	public int career_delete(int profile_seq, int career_seq) {
		return dao.career_delete(profile_seq, career_seq);
	}

	@Override
	public int career_count(int member_code) {
		return dao.career_count(member_code);
	}

	@Override
	public int career_insert_new(int member_code) {
		return dao.career_insert_new(member_code);
	}

	@Override
	public int[] career_date(int member_code) {
		int[] date = {0, 0};
		int year = (dao.career_date(member_code)/365);
		int month = (dao.career_date(member_code)-(year*365))/30;
		date[0] = year;
		date[1] = month;
		return date;
	}

}
