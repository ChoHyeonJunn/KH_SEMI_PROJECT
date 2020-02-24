package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.Actiondao;
import com.devca.model.dao.portfolio.ActiondaoImpl;
import com.devca.model.dto.ACTION_DTO;

public class ActionBizImpl implements ActionBiz {
	Actiondao dao = new ActiondaoImpl();
	@Override
	public List<ACTION_DTO> action_select(int member_code) {
		return dao.action_select(member_code);
	}

	@Override
	public ACTION_DTO action_select_seq(int member_code) {
		return dao.action_select_seq(member_code);
	}

	@Override
	public int action_insert(ACTION_DTO dto) {
		return dao.action_insert(dto);
	}

	@Override
	public int action_update(ACTION_DTO dto) {
		return dao.action_update(dto);
	}

	@Override
	public int action_delete_one(int member_code, int action_seq) {
		return dao.action_delete_one(member_code,action_seq);
	}
	
	public int action_delete(int member_code) {
		return dao.action_delete(member_code);
	}

}
