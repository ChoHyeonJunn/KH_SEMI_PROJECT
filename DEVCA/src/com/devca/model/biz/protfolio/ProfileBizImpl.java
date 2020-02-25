package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.ProfileDao;
import com.devca.model.dao.portfolio.ProfileDaoImpl;
import com.devca.model.dto.PROFILE;

public class ProfileBizImpl implements ProfileBiz {

	ProfileDao dao = new ProfileDaoImpl();
	@Override
	public List<PROFILE> profile_select(int member_code) {
		return dao.profile_select(member_code);
	}
	@Override
	public PROFILE profile_select_seq(int member_code) {
		
		return dao.profile_select_seq(member_code);
	}
	@Override
	public int profile_insert(PROFILE dto) {
		return dao.profile_insert(dto);
	}
	@Override
	public int profile_update(PROFILE dto) {
		return dao.profile_update(dto);
	}
	@Override
	public int profile_delete(int member_code, int profile_Seq) {
		return dao.profile_delete(member_code, profile_Seq);
	}

}
