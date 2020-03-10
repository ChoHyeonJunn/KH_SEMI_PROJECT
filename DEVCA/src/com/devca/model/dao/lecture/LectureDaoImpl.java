package com.devca.model.dao.lecture;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.lecture.JOBD_KEYWORD;
import com.devca.model.dto.lecture.JOB_RANK;
import com.devca.model.dto.lecture.LECTURE;
import com.devca.mybatis.SqlMapConfig;

public class LectureDaoImpl extends SqlMapConfig implements LectureDao {

	final String namespace = "com.devca.lectureMapper";

	/*
	 * crawling 관련
	 */
	// jobd_keywords select
	@Override
	public List<JOBD_KEYWORD> selectJobKeywordList() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<JOBD_KEYWORD> jobd_keywords = session.selectList(namespace + ".selectJobKeywordList");

		session.close();

		return jobd_keywords;
	}

	// jobd_keywords multiInsert
	@Override
	public int multiInsertJobdKeyword(ArrayList<JOBD_KEYWORD> jobd_keywords) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		Map<String, List<JOBD_KEYWORD>> map = new HashMap<String, List<JOBD_KEYWORD>>();
		map.put("jobd_keywords", jobd_keywords);

		int res = session.insert(namespace + ".multiInsertJobdKeyword", map);
		if (res == jobd_keywords.size()) {
			session.commit();
		}

		session.close();

		return res;
	}

	// job_rank DB select
	@Override
	public List<JOB_RANK> selectJobRankList() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<JOB_RANK> jobRankList = session.selectList(namespace + ".selectJobRankList");
		session.close();

		return jobRankList;
	}

	// job_rank DB multiInsert
	@Override
	public int multiInsertJobRankList(List<JOB_RANK> addJobRankList) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		Map<String, List<JOB_RANK>> map = new HashMap<String, List<JOB_RANK>>();
		map.put("addJobRankList", addJobRankList);

		int res = session.insert(namespace + ".multiInsertJobRankList", map);
		if (res == addJobRankList.size()) {
			session.commit();
		}

		session.close();

		return res;
	}

	// job_rank_Frequency 비우기
	@Override
	public int deleteJobRankFrequencyList() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.delete(namespace + ".deleteJobRankFrequencyList");
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	// job_rank DB multiInsert
	@Override
	public int multiInsertJobRankFrequencyList(List<JOB_RANK> JobRankFrequencyList) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		Map<String, List<JOB_RANK>> map = new HashMap<String, List<JOB_RANK>>();
		map.put("JobRankFrequencyList", JobRankFrequencyList);

		int res = session.insert(namespace + ".multiInsertJobRankFrequencyList", map);
		if (res == JobRankFrequencyList.size()) {
			session.commit();
		}

		session.close();

		return res;
	}
	
	// insert : crawling 한 강의 리스트를 db에 insert
	@Override
	public int multiInsertLecture(List<LECTURE> lectureList) {
		int res = 0;

		SqlSession session = getSqlSessionFactory().openSession(false);

		Map<String, List<LECTURE>> map = new HashMap<String, List<LECTURE>>();
		map.put("lectureList", lectureList);

		res = session.insert(namespace + ".multiInsertLecture", map);
		if (res == lectureList.size()) {
			session.commit();
		}

		session.close();

		return res;
	}

	/*
	 * lecture 관련 요청
	 */
	// 강의 리스트 선택
	@Override
	public List<LECTURE> selectLectureList(int no) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<LECTURE> lectureList = session.selectList(namespace + ".selectLectureList", no);
		session.close();

		return lectureList;
	}

	// 강의검색 자동완성
	@Override
	public List<LECTURE> selectLectureAutoCompleteList(String search) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<LECTURE> lectureList = session.selectList(namespace + ".selectLectureAutoCompleteList", search);
		session.close();

		return lectureList;
	}

	// 강의 검색 리스트 선택
	@Override
	public List<LECTURE> selectLectureList(int no, String search) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		Map<String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("search", search);

		List<LECTURE> lectureList = session.selectList(namespace + ".selectLectureSearchList", map);
		session.close();

		return lectureList;
	}

	// 내 강의 리스트 선택
	@Override
	public List<LECTURE> selectMyLectureList(int MEMBER_CODE, int no) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		Map<String, Integer> map = new HashMap<>();
		map.put("MEMBER_CODE", MEMBER_CODE);
		map.put("no", no);

		List<LECTURE> lectureList = session.selectList(namespace + ".selectMyLectureList", map);

//		if (lectureList.size() == 0) {
//			lectureList = session.selectList(namespace + ".selectMyGarbageLecture", map);
//		}
		session.close();

		return lectureList;
	}

	// 내 강의에 추가하기
	@Override
	public int addMyLecture(int MEMBER_CODE, int LECTURE_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		Map<String, Integer> map = new HashMap<>();
		map.put("MEMBER_CODE", MEMBER_CODE);
		map.put("LECTURE_CODE", LECTURE_CODE);

		int res = session.insert(namespace + ".addMyLecture", map);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	// 강의 디테일 선택
	@Override
	public LECTURE selectLectureDetail(int LECTURE_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		LECTURE lecture = session.selectOne(namespace + ".selectLectureDetail", LECTURE_CODE);
		session.close();

		return lecture;
	}

	// 강의 별점 부여
	@Override
	public int updateRate(LECTURE lecture) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace + ".updateRate", lecture);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	// 내 강의 삭제
	@Override
	public int deleteMyGarbageLecture(int LECTURE_CODE, int MEMBER_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		Map<String, Integer> map = new HashMap<>();
		map.put("LECTURE_CODE", LECTURE_CODE);
		map.put("MEMBER_CODE", MEMBER_CODE);
		System.out.println(MEMBER_CODE+" : "+LECTURE_CODE);
		int res = session.delete(namespace + ".deleteMyGarbageLecture", map);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	/*
	 * main 요청
	 */
	// 추천 강의 리스트
	@Override
	public List<LECTURE> selectRecommandList(List<String> keyWordList) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		String recommand = "";
		for (String key : keyWordList) {
			recommand += key + "|";
		}
		recommand = recommand.substring(0, recommand.length() - 1);

		List<LECTURE> lectureList = session.selectList(namespace + ".selectRecommandList", recommand);
		session.close();

		return lectureList;
	}

	// 프론트 추천 강의 리스트
	private final String FrontEnd = "Git|Github|JavaScript|HTML|CSS|React.js|Vue.js|Angular.js|BootStrap|jQuery";

	@Override
	public List<LECTURE> selectFrontEndList() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<LECTURE> lectureList = session.selectList(namespace + ".selectFrontEndList", FrontEnd);
		session.close();

		return lectureList;
	}

	// 백엔드 추천 강의 리스트
	private final String BackEnd = "Git|Github|Maven|Linux|Java|Spring|WAS|DB|Oracle|ORM|Mybatis";

	@Override
	public List<LECTURE> selectBackEndList() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<LECTURE> lectureList = session.selectList(namespace + ".selectBackEndList", BackEnd);
		session.close();

		return lectureList;
	}

	// 풀스택추천 강의 리스트
	private final String FullStack = "Git|Github|Maven|Linux|Java|JavaScript|HTML|CSS|ORM|Mybatis|BootStrap|Spring|WAS|Oracle|MongoDB";

	@Override
	public List<LECTURE> selectFullStackList() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<LECTURE> lectureList = session.selectList(namespace + ".selectFullStackList", FullStack);
		session.close();

		return lectureList;
	}

}
