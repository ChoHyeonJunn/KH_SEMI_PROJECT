package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dto.profile.SURVEY;

public interface SurveyBiz {

	public List<SURVEY> survey_select(int profile_seq);
	
	public int survey_insert(SURVEY dto);
	
	public int survey_update(SURVEY dto);
	
	public int survey_delete(int survey_seq, int profile_seq);
}
