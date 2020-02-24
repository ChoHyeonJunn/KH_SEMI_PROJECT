package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.SKILL;
import com.devca.mybatis.SqlMapConfig;

public class SkillDaoImpl extends SqlMapConfig implements SkillDao {
	
	final String namespace = "com.devca.skillMapper";
	@Override
	public List<SKILL> skill_select(int profile_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<SKILL> list = session.selectList(namespace+".skill_select",profile_seq);
		session.close();
		return list;
	}
	@Override
	
	public int skill_insert(SKILL dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".skill_insert",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int skill_update(SKILL dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);	
		int res = session.update(namespace+".skill_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int skill_delete_one(int skill_seq, int member_code) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("SKILL_SEQ",skill_seq);
		map.put("SKILL_MEMBER_CODE", member_code);
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace+".skill_detete_one",map);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public SKILL skill_select_one(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);	
		SKILL skill_dto = session.selectOne(namespace+".skill_select_one",member_code);
		session.close();
		return skill_dto;
	}
	@Override
	public int skill_count(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);	
		int skill_count = session.selectOne(namespace+".skill_count",member_code);
		
		session.close();
		return skill_count;
	}
	@Override
	public List<SKILL> skill_select_seq(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);	
		List<SKILL> skill_seq = session.selectList(namespace+".skill_select_seq",member_code);
		session.close();
		return skill_seq;
	}
	@Override
	public int skill_delete(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace+".skill_delete",member_code);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int skill_insert_new(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".skill_insert_new",member_code);
		if(res > 0) {
			session.commit();
		}
		return res;
	}

	
}
