package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.profile.SURVEY;
import com.devca.mybatis.SqlMapConfig;

public class SurveyDaoImpl extends SqlMapConfig implements SurveyDao {
	
	final String namespace ="com.devca.surveyMapper";
	@Override
	public List<SURVEY> survey_select(int profile_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<SURVEY> list = session.selectList(namespace+".survey_select",profile_seq);
		session.close();
		return list;
	}
	@Override
	public int survey_insert(SURVEY dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".survey_insert",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int survey_update(SURVEY dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace+".survey_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int survey_delete(int survey_seq, int profile_seq) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("SURVEY_SEQ",survey_seq);
		map.put("PROFILE_SEQ", profile_seq);
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace+"survey_delete",map);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}

	
}
