package com.devca.model.dao.member;

import java.util.List;

import com.devca.model.dto.member.SURVEY;

public interface SurveyDao {

   // 설문조사 목록
   public List<SURVEY> selectMySurvey(int member_code);

   // 설문조사 등록
   public int insertMySurvey(SURVEY Servey);

   // 설문조사 삭제
   public int deleteMySurvey(int MEMBER_CODE, int SURVEY_SEQ);
}