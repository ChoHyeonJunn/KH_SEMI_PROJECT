package com.devca.model.dao.lecture;

import java.util.ArrayList;
import java.util.List;

import com.devca.model.dto.lecture.JOBD_KEYWORD;
import com.devca.model.dto.lecture.JOB_RANK;
import com.devca.model.dto.lecture.LECTURE;

public interface LectureDao {

	/*
	 * crawling 관련
	 */
	// jobd_keywords multiInsert
	public int multiInsertJobdKeyword(ArrayList<JOBD_KEYWORD> jobd_keywords);

	// job_rank_new 비우기
	public int deleteJobRankList();

	// job_rank_new DB multiInsert
	public int multiInsertJobRankList(List<JOB_RANK> job_rank);

	// job_rank DB select
	public List<JOB_RANK> selectJobRankList();

	/*
	 * lecture 관련 요청
	 */
	// insert : crawling 한 강의 리스트를 db에 insert
	public int multiInsertLecture(List<LECTURE> lectureList);

	// 강의 리스트 선택
	public List<LECTURE> selectLectureList(int no);

	// 강의 검색 리스트 선택
	public List<LECTURE> selectLectureList(int no, String search);

	// 내강의 리스트 선택
	public List<LECTURE> selectMyLectureList(int MEMBER_CODE, int no);

	// 내강의 리스트 선택
	public int addMyLecture(int MEMBER_CODE, int LECTURE_CODE);

	// 강의 디테일 선택
	public LECTURE selectLectureDetail(int LECTURE_CODE);

	// 강의 별점 부여
	public int updateRate(LECTURE lecture);

	// 내 강의 삭제
	public int deleteMyGarbageLecture(int LECTURE_CODE);

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
