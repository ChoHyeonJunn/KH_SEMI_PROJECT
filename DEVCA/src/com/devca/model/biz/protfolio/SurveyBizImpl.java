package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.member.SurveyDao;
import com.devca.model.dao.member.SurveyDaoImpl;
import com.devca.model.dto.member.SURVEY;

public class SurveyBizImpl implements SurveyBiz {

   SurveyDao dao = new SurveyDaoImpl();

   // 설문조사 목록
   @Override
   public List<SURVEY> selectMySurvey(int profile_seq) {

      return dao.selectMySurvey(profile_seq);
   }

   // 설문조사 등록
   @Override
   public int insertMySurvey(SURVEY dto) {
      return dao.insertMySurvey(dto);
   }

   // 설문조사 삭제
   @Override
   public int deleteMySurvey(int survey_seq, int profile_seq) {
      return dao.deleteMySurvey(survey_seq, profile_seq);
   }

}