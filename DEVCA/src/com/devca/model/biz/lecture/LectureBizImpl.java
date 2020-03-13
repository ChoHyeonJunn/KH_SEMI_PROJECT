package com.devca.model.biz.lecture;

import java.util.ArrayList;
import java.util.List;

import com.devca.model.dto.lecture.JOBD_KEYWORD;
import com.devca.model.dto.lecture.JOB_RANK;
import com.devca.model.dto.lecture.LECTURE;
import com.devca.utility.crawling.Programmers;
import com.devca.utility.crawling.Saramin;
import com.devca.utility.crawling.lecture.CloudEDU;
import com.devca.utility.crawling.lecture.Inflearn;
import com.devca.utility.crawling.lecture.OLCcenter;

public class LectureBizImpl implements LectureBiz {

//	// jobData 크롤링
//	@Override
//	public void crawlingJobData() {
//		// job_rank 테이블에 새로운 기술명을 포함해 분류, 빈도수를 뽑아내는 것이 목적!!
//
//		List<JOB_RANK> job_rank = dao.selectJobRankList(); // JOB_RANK 에 기재된 기술스택
//
//		// 1. programmers 를 crawling 해 채용 관련 요구 기술 keyword를 습득
//		ArrayList<JOBD_KEYWORD> jobd_keywords = Programmers.getKeywordFromProgrammers();
////		for (JOBD_KEYWORD key : jobd_keywords) {
////			System.out.println(key.getTECH());
////		}
//		int res = dao.multiInsertJobdKeyword(jobd_keywords);
//		System.out.println("\n" + res + "개의 job 키워드 입력!!");
//
//		// 2. 기술 키워드 들을 job_rank 테이블에 셋팅 (빈도수는 0 으로 셋팅)
//		for (int i = 0; i < jobd_keywords.size(); i++) {
//			int verify = 0;
//			// job_rank 테이블에 이미 존재하는 키워드가 있는지 체크
//			for (int j = 0; j < job_rank.size(); j++) {
//				if (job_rank.get(j).getJOB_RANK_STACK().equals(jobd_keywords.get(i).getTECH())) {
//					job_rank.get(j).setJOB_RANK_NUM(job_rank.get(j).getJOB_RANK_NUM() + 1);
//					verify++;
//				}
//			}
//			// ***** 키워드가 job_rank 테이블에 존재하지 않는다면 etc로 입력
//			// (작업을 반복할 시 기존 키워드는 없어지지 않고 새로운 키워드는 추가됨)
//			if (verify == 0) {
//				JOB_RANK job = new JOB_RANK();
//				job.setJOB_RANK_DIVISION("etc");
//				job.setJOB_RANK_STACK(jobd_keywords.get(i).getTECH());
//				job.setJOB_RANK_NUM(0);
//
//				job_rank.add(job);
//			}
//		}
//		
//		// 3. 기술 keyword들을 이용해 사람인(웹 개발자 기준)을 crawling하여 각각 기술명의 빈도수를 측정
//
//		System.out.println("빈도수 측정 시작!!");
//		for (int page = 1; page <= 50; page++) {
//			job_rank = Saramin.saraminCrawling(job_rank, page);
//
//			// 4. 최종적으로 빈도수가 측정된 job_Rank 테이블을 출력해 보고 job_rank_new db에 입력
//			for (JOB_RANK job : job_rank) {
//				System.out.println(
//						job.getJOB_RANK_DIVISION() + " : " + job.getJOB_RANK_STACK() + " : " + job.getJOB_RANK_NUM());
//			}
//			//dao.deleteJobRankList();
//			int result = dao.multiInsertJobRankList(job_rank);
//			System.out.println(result + " 개의 job rank 입력됨!!");
//		}
//		System.out.println("빈도수 측정 끝!!");
//
//	}

	/*
	 * 기업들의 기술 스택 요구사항 추출 과정
	 */
	// 1. 프로그래머스에서 기술 키워드 추출
	@Override
	public void crawlingGetJOBD_KEYWORD() {
		// programmers 를 crawling 해 채용 관련 요구 기술 keyword를 습득
		ArrayList<JOBD_KEYWORD> jobdKeywordList = Programmers.getKeywordFromProgrammers();
		for (JOBD_KEYWORD key : jobdKeywordList) {
			System.out.println(key.getTECH());
		}
		// DB에 입력
		int res = dao.multiInsertJobdKeyword(jobdKeywordList);
		System.out.println("\n" + res + "개의 job 키워드 입력!!");
	}

	// 2. 기술 키워드가 분류되어 있는 JOB_RANK 테이블에 (새로운 키워드가 있다면) 기술 키워드를 셋팅
	@Override
	public void crawlingSetJOB_RANK() {
		List<JOBD_KEYWORD> jobdKeywordList = dao.selectJobKeywordList(); // 기술 키워드 리스트
		List<JOB_RANK> jobRankList = dao.selectJobRankList(); // JOB_RANK 에 기재된 기술스택
		List<JOB_RANK> addJobRankList = new ArrayList<>(); // JOB_RANK 에 새로 기재할 기술스택

		// 기술 키워드 들을 jobRankList에 셋팅 (빈도수는 0 으로 셋팅)
		for (int i = 0; i < jobdKeywordList.size(); i++) {
			int verify = 0;
			// job_rank 테이블에 이미 존재하는 키워드가 있는지 체크
			for (int j = 0; j < jobRankList.size(); j++) {
				if (jobRankList.get(j).getJOB_RANK_STACK().equals(jobdKeywordList.get(i).getTECH())) {
					verify++;
				}
			}
			// 키워드가 job_rank 테이블에 존재하지 않는다면 etc로 입력 (기존 키워드는 없어지지 않고 새로운 키워드는 추가됨)
			if (verify == 0) {
				JOB_RANK job = new JOB_RANK();
				job.setJOB_RANK_DIVISION("etc");
				job.setJOB_RANK_STACK(jobdKeywordList.get(i).getTECH());
				job.setJOB_RANK_NUM(0);

				addJobRankList.add(job);
			}
		}
		// DB에 입력
		System.out.println(addJobRankList.size() + " 개의 새로운 job keyword 발견!!");
		if (addJobRankList.size() > 0) {
			int result = dao.multiInsertJobRankList(addJobRankList);
			System.out.println(result + " 개의 새로운 job rank 입력됨!!");
		}
	}

	// 3. JOB_RANK 에 분류되어있는 키워드들의 빈도수를 측정 (사람인)
	@Override
	public void crawlingSetJOB_RANK_FREQUENCY() {
		List<JOB_RANK> jobRankList = dao.selectJobRankList(); // JOB_RANK 에 기재된 기술스택

		System.out.println("빈도수 측정 시작!!");
		List<JOB_RANK> JobRankFrequencyList = Saramin.saraminCrawling2(jobRankList);

		// 4. 최종적으로 빈도수가 측정된 job_Rank 테이블을 출력해 보고 job_rank_new db에 입력
		for (JOB_RANK job : JobRankFrequencyList) {
			System.out.println(
					job.getJOB_RANK_DIVISION() + " : " + job.getJOB_RANK_STACK() + " : " + job.getJOB_RANK_NUM());
		}
		dao.deleteJobRankFrequencyList();
		int result = dao.multiInsertJobRankFrequencyList(JobRankFrequencyList);
		System.out.println(result + " 개의 job rank 입력됨!!");

	}

	// 강의 리스트 crawling
	@Override
	public int crawlingLectureList() {
		int res = 0;
		res += Inflearn.inflearnCrawlingWithoutSearching();
		res += CloudEDU.cloudEDUCrawlingWithoutSearching();
		res += OLCcenter.OLCcenterCrawlingWithoutSearching();
		return res;
	}

	// 강의 리스트 선택
	@Override
	public List<LECTURE> selectLectureList(int no) {
		return dao.selectLectureList(no);
	}

	// 강의검색 자동완성
	@Override
	public List<LECTURE> selectLectureAutoCompleteList(String search) {
		return dao.selectLectureAutoCompleteList(search);
	}

	// 강의 검색 리스트 선택
	@Override
	public List<LECTURE> selectLectureList(int no, String search) {
		return dao.selectLectureList(no, search);
	}

	// 내강의 리스트 선택
	@Override
	public List<LECTURE> selectMyLectureList(int MEMBER_CODE, int no) {
		return dao.selectMyLectureList(MEMBER_CODE, no);
	}

	// 내 강의에 추가
	@Override
	public int addMyLecture(int MEMBER_CODE, int LECTURE_CODE) {
		return dao.addMyLecture(MEMBER_CODE, LECTURE_CODE);
	}

	// 강의 디테일 선택
	@Override
	public LECTURE selectLectureDetail(int LECTURE_CODE) {
		return dao.selectLectureDetail(LECTURE_CODE);
	}

	// 강의 별점 부여
	@Override
	public int updateRate(LECTURE lecture) {
		return dao.updateRate(lecture);
	}

	// 내 강의 삭제
	@Override
	public int deleteMyGarbageLecture(int LECTURE_CODE, int MEMBER_CODE) {
		return dao.deleteMyGarbageLecture(LECTURE_CODE, MEMBER_CODE);
	}

	/*
	 * main 요청
	 */
	// 추천 강의 리스트
	@Override
	public List<LECTURE> selectRecommandList(List<String> keyWordList) {
		return dao.selectRecommandList(keyWordList);
	}

	// 프론트 추천 강의 리스트
	@Override
	public List<LECTURE> selectFrontEndList() {
		return dao.selectFrontEndList();
	}

	// 백엔드 추천 강의 리스트
	@Override
	public List<LECTURE> selectBackEndList() {
		return dao.selectBackEndList();
	}

	// 풀스택추천 강의 리스트
	@Override
	public List<LECTURE> selectFullStackList() {
		return dao.selectFullStackList();
	}

}
