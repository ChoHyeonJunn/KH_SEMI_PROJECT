package com.devca.model.biz.study;

import java.util.List;

import com.devca.model.dao.study.StudyDao;
import com.devca.model.dao.study.StudyDaoImpl;
import com.devca.model.dto.study.STUDY;

public class StudyBizImpl implements StudyBiz {

	StudyDao dao = new StudyDaoImpl();

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

}
