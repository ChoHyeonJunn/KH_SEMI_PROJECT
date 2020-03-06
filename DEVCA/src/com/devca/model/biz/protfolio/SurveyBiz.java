package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dto.member.SURVEY;

public interface SurveyBiz {

   public List<SURVEY> selectMySurvey(int profile_seq);

   public int insertMySurvey(SURVEY dto);

   public int deleteMySurvey(int survey_seq, int profile_seq);
}