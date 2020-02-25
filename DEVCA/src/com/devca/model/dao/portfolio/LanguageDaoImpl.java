package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.LANGUAGE;
import com.devca.mybatis.SqlMapConfig;

public class LanguageDaoImpl extends SqlMapConfig implements LanguageDao {

	final String namespace ="com.devca.languageMapper";
	@Override
	public List<LANGUAGE> language_select(int profile_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<LANGUAGE> list = session.selectList(namespace+".language_select",profile_seq);
		session.close();
		return list;
	}
	@Override
	public int language_insert(LANGUAGE dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".language_insert",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int language_update(LANGUAGE dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace+".language_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int language_delete(int language_seq, int profile_seq) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("LANGUAGE_SEQ",language_seq);
		map.put("PROFILE_SEQ", profile_seq);
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace+".language_delete",map);
		if(res > 0) {
			session.commit();
		}
		session.close();
		
		return res;
	}
	@Override
	public LANGUAGE language_select_seq(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		LANGUAGE language_seq = session.selectOne(namespace+".language_select_seq",member_code);
		session.close();
		return language_seq;
	}
	@Override
	public int language_insert_new(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int language_res = session.insert(namespace+".language_insert_new",member_code);
		if(language_res > 0) {
			session.commit();
		}
		session.close();
		return language_res;
	}
	@Override
	public int language_count(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int language_res = session.selectOne(namespace+".language_count",member_code);
		session.close();
		return language_res;
	}

}
