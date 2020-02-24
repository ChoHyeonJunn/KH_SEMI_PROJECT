package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.PROFILE;
import com.devca.mybatis.SqlMapConfig;

public class ProfileDaoImpl extends SqlMapConfig implements ProfileDao {

	final String namespace = "com.devca.profileMapper";
	
	@Override
	public List<PROFILE> profile_select(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<PROFILE> list = session.selectList(namespace + ".profile_select",member_code);
		session.close();
		
		return list;
	}

	@Override
	public PROFILE profile_select_seq(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		PROFILE profile_seq = session.selectOne(namespace+".profile_select_seq",member_code);
		session.close();
		return profile_seq;
	}

	@Override
	public int profile_insert(PROFILE dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".profile_insert",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

	@Override
	public int profile_update(PROFILE dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace+".profile_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

	@Override
	public int profile_delete(int member_code, int profile_seq) {
		Map<String,Integer> map = new HashMap<String, Integer>();
		map.put("member_code", member_code);
		map.put("profile_seq", profile_seq);
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace+".profile_delete",map);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	
}
