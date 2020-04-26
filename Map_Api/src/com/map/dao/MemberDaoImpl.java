package com.map.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.map.dto.MemberDto;
import com.map.mybatis.SqlMapConfig;

public class MemberDaoImpl extends SqlMapConfig implements MemberDao{

	private String namespace = "map."; 
	
	@Override
	public List<MemberDto> selectList() {
		
		List<MemberDto> list = new ArrayList<MemberDto>();
		
		SqlSession session = getSqlSessionFactory().openSession(false);

		list = session.selectList(namespace + "selectList");

		return list;
	}

	@Override
	public int insert(MemberDto dto) {
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = 0;
		res = session.insert(namespace+"insert",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		
		return res;
	}

}
