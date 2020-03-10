package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.profile.WORK;
import com.devca.mybatis.SqlMapConfig;

public class WorkDaoImpl extends SqlMapConfig implements WorkDao {
	
	final String namespace = "com.devca.workMapper";
	@Override
	public List<WORK> work_select(int profile_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<WORK> list = session.selectList(namespace+".work_select",profile_seq);
		session.close();
		return list;
	}
	@Override
	public int work_insert(WORK dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".work_insert",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int work_update(WORK dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace+".work_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int work_delete_one(int work_seq, int profile_seq) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("WORK_SEQ",work_seq);
		map.put("PROFILE_SEQ", profile_seq);
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace+".work_delete_one",map);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public WORK work_select_seq(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		WORK work_seq = session.selectOne(namespace+".work_select_seq",member_code);
		session.close();
		return work_seq;
	}
	@Override
	public int work_delete(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int work_res = session.delete(namespace+".work_delete",member_code);
		if(work_res > 0) {
			session.commit();
		}
		session.close();
		return work_res;
	}
	@Override
	public int work_count(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int work_seq = session.selectOne(namespace+".work_count",member_code);
		session.close();
		return work_seq;
	}
	@Override
	public int work_insert_new(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".work_insert_new",member_code);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

}
