package com.devca.model.biz.study;

import java.util.List;

import com.devca.model.dto.study.APPLY_STUDY;
import com.devca.model.dto.study.STUDY;

public interface StudyBiz {
	/*
	 * 스터디 글 관련
	 */
	// 스터디 리스트 가져오기
	List<STUDY> selectStudyList();

	// 스터디 디테일 가져오기
	STUDY selectStudyDetail(int STUDY_CODE);

	// 스터디 글쓰기
	int studyWrite(STUDY study);

	// STUDY 글 업데이트
	int studyUpdate(STUDY study);

	// STUDY 글 삭제
	int studyDelete(int sTUDY_CODE);

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

	// 스터디 신청 취소
	int cancelApplyStudy(APPLY_STUDY apply_study);

}
