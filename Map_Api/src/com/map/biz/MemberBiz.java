package com.map.biz;

import java.util.List;

import com.map.dto.MemberDto;

public interface MemberBiz {

	public List<MemberDto> selectList();
	
	public int insert(MemberDto dto);
	
}
