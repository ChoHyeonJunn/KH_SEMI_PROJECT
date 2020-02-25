package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dto.ACTION_DTO;

public interface ActionBiz {

	public List<ACTION_DTO> action_select(int member_code);
	
	public ACTION_DTO action_select_seq(int member_code);
	
	public int action_insert(ACTION_DTO dto);
	
	public int action_update(ACTION_DTO dto);
	
	public int action_delete_one(int member_code, int action_seq);
	
	public int action_delete(int member_code);
}
