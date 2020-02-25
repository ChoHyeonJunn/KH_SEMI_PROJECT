package com.devca.model.dao.study;

import java.util.List;

import com.devca.model.dto.study.STUDY;

public interface StudyDao {

	// 스터디 리스트 가져오기
	List<STUDY> selectStudyList();

	// 스터디 디테일 가져오기
	STUDY selectStudyDetail(int sTUDY_CODE);

	// 스터디 글쓰기
	int studyWrite(STUDY study);

	// STUDY 글 업데이트
	int studyUpdate(STUDY study);

	// STUDY 글 삭제
	int studyDelete(int STUDY_CODE);

}
