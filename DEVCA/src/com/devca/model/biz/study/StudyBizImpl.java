package com.devca.model.biz.study;

import java.util.List;

import com.devca.model.dao.study.StudyDao;
import com.devca.model.dao.study.StudyDaoImpl;
import com.devca.model.dto.study.APPLY_STUDY;
import com.devca.model.dto.study.STUDY;

public class StudyBizImpl implements StudyBiz {

	StudyDao dao = new StudyDaoImpl();

	/*
	 * 스터디 글 관련
	 */
	// 스터디 리스트 가져오기
	@Override
	public List<STUDY> selectStudyList() {
		return dao.selectStudyList();
	}

	// 스터디 디테일 가져오기
	@Override
	public STUDY selectStudyDetail(int STUDY_CODE) {
		return dao.selectStudyDetail(STUDY_CODE);
	}

	// 스터디 글쓰기
	@Override
	public int studyWrite(STUDY study) {
		return dao.studyWrite(study);
	}

	// STUDY 글 업데이트
	@Override
	public int studyUpdate(STUDY study) {
		return dao.studyUpdate(study);
	}

	// STUDY 글 삭제
	@Override
	public int studyDelete(int STUDY_CODE) {
		return dao.studyDelete(STUDY_CODE);
	}

	/*
	 * 스터디 신청 관련
	 */
	// 스터디 신청하기
	@Override
	public int applyStudy(APPLY_STUDY apply_study) {
		return dao.applyStudy(apply_study);
	}

	// 스터디 신청 리스트 불러오기
	@Override
	public List<APPLY_STUDY> applyStudyList(int STUDY_CODE) {
		return dao.applyStudyList(STUDY_CODE);
	}

	// 스터디 신청 승인
	@Override
	public int approveApplyStudy(APPLY_STUDY apply_study) {
		STUDY study = dao.selectStudyDetail(apply_study.getSTUDY_CODE());
		study.setSTUDY_PARTICIPANTS(study.getSTUDY_PARTICIPANTS() + 1);
		int cres = dao.changeStudyParticipants(study);
		int ares = dao.approveApplyStudy(apply_study);

		return (ares > 0 && cres > 0) ? 1 : 0;
	}

	// 스터디 강퇴
	@Override
	public int excludeApplyStudy(APPLY_STUDY apply_study) {
		STUDY study = dao.selectStudyDetail(apply_study.getSTUDY_CODE());
		study.setSTUDY_PARTICIPANTS(study.getSTUDY_PARTICIPANTS() - 1);
		int cres = dao.changeStudyParticipants(study);
		int eres = dao.excludeApplyStudy(apply_study);

		return (eres > 0 && cres > 0) ? 1 : 0;
	}

	// 스터디 신청 취소
	@Override
	public int cancelApplyStudy(APPLY_STUDY apply_study) {
		return dao.excludeApplyStudy(apply_study);
	}

}
