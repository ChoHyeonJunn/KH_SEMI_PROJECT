package com.map.biz;

import java.util.List;

import com.map.dao.MemberDao;
import com.map.dao.MemberDaoImpl;
import com.map.dto.MemberDto;

public class MemberBizImpl implements MemberBiz {

	MemberDao dao =new MemberDaoImpl();
	
	@Override
	public List<MemberDto> selectList() {
		return dao.selectList();
	}

	@Override
	public int insert(MemberDto dto) {
		return dao.insert(dto);
	}

}
