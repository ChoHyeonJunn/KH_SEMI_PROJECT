package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.profile.ACTION_DTO;
import com.devca.mybatis.SqlMapConfig;

public class ActiondaoImpl extends SqlMapConfig implements Actiondao {
	
	final String namespace ="com.devca.actionMapper";
	
	@Override
	public List<ACTION_DTO> action_select(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<ACTION_DTO> Action_list = session.selectList(namespace+".action_select",member_code);
		session.close();
		return Action_list;
	}

	@Override
	public ACTION_DTO action_select_seq(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		ACTION_DTO Action_seq = session.selectOne(namespace+".action_select_seq",member_code);
		session.close();
		return Action_seq;
	}

	@Override
	public int action_insert(ACTION_DTO dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int Action_res = session.insert(namespace+".action_insert",dto);
		if(Action_res > 0) {
			session.commit();
		}
		session.close();
		return Action_res;
	}

	@Override
	public int action_update(ACTION_DTO dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int Action_res = session.update(namespace+".action_update",dto);
		if(Action_res > 0) {
			session.commit();
		}
		session.close();
		return Action_res;
	}

	@Override
	public int action_delete_one(int member_code, int action_seq) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("member_code", member_code);
		map.put("action_seq", action_seq);
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int Action_res = session.delete(namespace+".action_delete_one",map);
		if(Action_res > 0) {
			session.commit();
		}
		session.close();
		return Action_res;
	}
	
	public int action_delete(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int Action_res = session.delete(namespace+".action_delete",member_code);
		if(Action_res > 0) {
			session.commit();
		}
		session.close();
		return Action_res;
	}

	@Override
	public int action_count(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int Action_res = session.selectOne(namespace+".action_count",member_code);
		session.close();
		return Action_res;
	}

	@Override
	public int action_insert_new(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int Action_res = session.insert(namespace+".action_insert_new",member_code);
		if(Action_res > 0) {
			session.commit();
		}
		session.close();
		return Action_res;
	}

}
