package com.map.dao;

import java.util.List;

import com.map.dto.MemberDto;

public interface MemberDao {

	public List<MemberDto> selectList();
	
	public int insert(MemberDto dto);
}
