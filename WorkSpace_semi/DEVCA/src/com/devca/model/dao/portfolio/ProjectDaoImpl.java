package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.PROJECT;
import com.devca.mybatis.SqlMapConfig;

public class ProjectDaoImpl extends SqlMapConfig implements ProjectDao {
	
	final String namespace ="com.devca.projectMapper";
	@Override
	public List<PROJECT> project_select(int profile_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<PROJECT> list = session.selectList(namespace+".project_select",profile_seq);
		session.close();
		return list;
	}
	@Override
	public int project_insert(PROJECT dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace+".project_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
		
	}
	@Override
	public int project_update(PROJECT dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace+".project_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int project_delete(int project_seq, int profile_seq) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("PROJECT_SEQ",project_seq);
		map.put("PROFILE_SEQ", profile_seq);
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace+".project_delete",map);
		if(res > 0) {
			session.commit();
		}
		session.close();
		
		return res;
	}
	@Override
	public int project_insert_new(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".project_insert_new",member_code);
		if(res > 0) {
			session.commit();
		}
		return res;
	}
	@Override
	public int project_count(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.selectOne(namespace+".project_count",member_code);
		return res;
	}

}
