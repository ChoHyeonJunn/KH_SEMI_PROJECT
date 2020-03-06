package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.profile.SCHOOL;
import com.devca.mybatis.SqlMapConfig;

public class SchoolDaoImpl extends SqlMapConfig implements SchoolDao {
	
	final String namespace ="com.devca.schoolMapper";

	@Override
	public List<SCHOOL> school_select(int profile_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<SCHOOL> list = session.selectList(namespace+".school_select",profile_seq);
		session.close();
		return list;
	}

	@Override
	public int school_insert(SCHOOL dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".school_insert",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

	@Override
	public int school_update(SCHOOL dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace +".school_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

	@Override
	public int school_delete(int school_seq, int profile_seq) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("SCHOOL_SEQ",school_seq);
		map.put("PROFILE_SEQ", profile_seq);
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace+".school_delete",map);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

	@Override
	public int school_count(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.selectOne(namespace+".school_count",member_code);
		session.close();
		return res;
	}

	@Override
	public int school_insert_new(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".school_insert_new",member_code);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

}
