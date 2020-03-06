package com.devca.model.dao.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.member.SURVEY;
import com.devca.mybatis.SqlMapConfig;

public class SurveyDaoImpl extends SqlMapConfig implements SurveyDao {

	final String namespace = "com.devca.surveyMapper";

	// 설문조사 목록
	@Override
	public List<SURVEY> selectMySurvey(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<SURVEY> list = session.selectList(namespace + ".selectMySurvey", member_code);
		session.close();
		return list;
	}

	// 설문조사 등록
	@Override
	public int insertMySurvey(SURVEY Servey) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace + ".insertMySurvey", Servey);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

	// 설문조사 삭제
	@Override
	public int deleteMySurvey(int MEMBER_CODE, int SURVEY_SEQ) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("MEMBER_CODE", MEMBER_CODE);
		map.put("SURVEY_SEQ", SURVEY_SEQ);

		int res = session.insert(namespace + ".deleteMySurvey", map);
		if (res > 0)
			session.commit();
		session.close();
		return res;
	}

}