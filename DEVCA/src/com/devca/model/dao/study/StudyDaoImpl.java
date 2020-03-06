package com.devca.model.dao.study;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.study.APPLY_STUDY;
import com.devca.model.dto.study.STUDY;
import com.devca.mybatis.SqlMapConfig;

public class StudyDaoImpl extends SqlMapConfig implements StudyDao {

	final String namespace = "com.devca.studyMapper";

	/*
	 * 스터디 글 관련
	 */
	// 스터디 리스트 가져오기
	@Override
	public List<STUDY> selectStudyList() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<STUDY> studyList = session.selectList(namespace + ".selectStudyList");
		session.close();

		return studyList;
	}

	// 스터디 디테일 가져오기
	@Override
	public STUDY selectStudyDetail(int STUDY_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		STUDY study = session.selectOne(namespace + ".selectStudyDetail", STUDY_CODE);
		session.close();

		return study;
	}

	// 스터디 글쓰기
	@Override
	public int studyWrite(STUDY study) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".studyWrite", study);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	// STUDY 글 업데이트
	@Override
	public int studyUpdate(STUDY study) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".studyUpdate", study);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	// STUDY 글 삭제
	@Override
	public int studyDelete(int STUDY_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.delete(namespace + ".studyDelete", STUDY_CODE);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	/*
	 * 스터디 신청 관련
	 */
	@Override
	public int applyStudy(APPLY_STUDY apply_study) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".applyStudy", apply_study);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	// 스터디 신청 리스트 불러오기
	@Override
	public List<APPLY_STUDY> applyStudyList(int STUDY_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<APPLY_STUDY> applyStudyList = session.selectList(namespace + ".applyStudyList", STUDY_CODE);
		session.close();

		return applyStudyList;
	}

	// 스터디 신청 승인
	@Override
	public int approveApplyStudy(APPLY_STUDY apply_study) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".approveApplyStudy", apply_study);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	// 스터디 강퇴
	@Override
	public int excludeApplyStudy(APPLY_STUDY apply_study) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".excludeApplyStudy", apply_study);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	// 스터디 참여인원 변경
	@Override
	public int changeStudyParticipants(STUDY study) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.delete(namespace + ".changeStudyParticipants", study);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

}
