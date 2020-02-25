package com.devca.model.biz.lecture;

import java.util.List;

import com.devca.model.dao.lecture.LectureDao;
import com.devca.model.dao.lecture.LectureDaoImpl;
import com.devca.model.dto.lecture.LECTURE;

public interface LectureBiz {
	LectureDao dao = new LectureDaoImpl();

	/*
	 * 크롤링 관련
	 */
	// jobData 크롤링
	public void crawlingJobData();

	// 강의 크롤링 -> db 저장 실행
	public int crawlingLectureList();

	/*
	 * 강의 관련
	 */
	// 강의 리스트 선택
	public List<LECTURE> selectLectureList(int no);

	// 강의 검색 리스트 선택
	public List<LECTURE> selectLectureList(int no, String search);

	// 내강의 리스트 선택
	public List<LECTURE> selectMyLectureList(int mEMBER_CODE, int no);

	// 내 강의에 추가
	public int addMyLecture(int MEMBER_CODE, int LECTURE_CODE);

	// 강의 디테일 선택
	public LECTURE selectLectureDetail(int LECTURE_CODE);

	// 강의 별점 부여
	public int updateRate(LECTURE lecture);

	// 내 강의 삭제
	public int deleteMyGarbageLecture(int lECTURE_CODE);

	/*
	 * main 요청
	 */
	// 추천 강의 리스트
	public List<LECTURE> selectRecommandList(List<String> keyWordList);

	// 프론트 추천 강의 리스트
	public List<LECTURE> selectFrontEndList();

	// 백엔드 추천 강의 리스트
	public List<LECTURE> selectBackEndList();

	// 풀스택추천 강의 리스트
	public List<LECTURE> selectFullStackList();

}
