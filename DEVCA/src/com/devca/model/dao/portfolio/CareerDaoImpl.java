package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.profile.CAREER;
import com.devca.mybatis.SqlMapConfig;

public class CareerDaoImpl extends SqlMapConfig implements CareerDao {
	
	final String namespace = "com.devca.careerMapper";
	
	@Override
	public List<CAREER> career_select(int profile_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<CAREER> list = session.selectList(namespace+".career_select",profile_seq);
		session.close();
		return list;
	}

	@Override
	public CAREER career_select_seq(int profile_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		CAREER career_seq = session.selectOne(namespace+".career_select_seq",profile_seq);
		session.close();
		return career_seq;
	}

	@Override
	public int career_insert(CAREER dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace +".career_insert",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

	@Override
	public int career_update(CAREER dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace +".career_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

	@Override
	public int career_delete(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace +".career_delete",member_code);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

	@Override
	public int career_count(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int career_count = session.selectOne(namespace +".career_count",member_code);
		session.close();
		return career_count;
	}

	@Override
	public int career_insert_new(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int career_insert_new = session.delete(namespace +".career_insert_new",member_code);
		if(career_insert_new > 0) {
			session.commit();
		}
		
		session.close();
		
		return career_insert_new;
	}

	@Override
	public int career_date(int member_code, int career_seq) {
		Map<String,Integer> map = new HashMap<String, Integer>();
		map.put("CAREER_MEMBER_CODE", member_code);
		map.put("CAREER_SEQ", career_seq);
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int career_date = session.selectOne(namespace +".career_date",map);		
		session.close();
		return career_date;
	}
	

}
