package com.devca.model.dao.portfolio;

import java.util.List;

import com.devca.model.dto.profile.SURVEY;

public interface SurveyDao {
	
	public List<SURVEY> survey_select(int profile_seq);
	
	public int survey_insert(SURVEY dto);
	
	public int survey_update(SURVEY dto);
	
	public int survey_delete(int survey_seq, int profile_seq);
}
