package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.SurveyDao;
import com.devca.model.dao.portfolio.SurveyDaoImpl;
import com.devca.model.dto.SURVEY;

public class SurveyBizImpl implements SurveyBiz {

	SurveyDao dao = new SurveyDaoImpl();
	@Override
	public List<SURVEY> survey_select(int profile_seq) {
		
		return dao.survey_select(profile_seq);
	}

	@Override
	public int survey_insert(SURVEY dto) {
		return dao.survey_insert(dto);
	}

	@Override
	public int survey_update(SURVEY dto) {
		// TODO Auto-generated method stub
		return dao.survey_update(dto);
	}

	@Override
	public int survey_delete(int survey_seq, int profile_seq) {
		// TODO Auto-generated method stub
		return dao.survey_delete(survey_seq, profile_seq);
	}

}
