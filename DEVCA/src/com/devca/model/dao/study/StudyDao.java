package com.devca.model.dao.study;

import java.util.List;

import com.devca.model.dto.study.APPLY_STUDY;
import com.devca.model.dto.study.STUDY;

public interface StudyDao {

	/*
	 * 스터디 글 관련
	 */
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

	/*
	 * 스터디 신청 관련
	 */
	// 스터디 신청하기
	int applyStudy(APPLY_STUDY apply_study);

	// 스터디 신청 리스트 불러오기
	List<APPLY_STUDY> applyStudyList(int STUDY_CODE);

	// 스터디 신청 승인
	int approveApplyStudy(APPLY_STUDY apply_study);

	// 스터디 강퇴
	int excludeApplyStudy(APPLY_STUDY apply_study);
	
	// 스터디 참여인원 변경
	int changeStudyParticipants(STUDY study);

}
