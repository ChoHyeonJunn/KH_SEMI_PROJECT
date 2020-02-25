package com.devca.model.dao.main;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.lecture.JOB_RANK;
import com.devca.model.dto.member.ROADMAP;
import com.devca.mybatis.SqlMapConfig;

public class MainDaoImpl extends SqlMapConfig implements MainDao {

	final String namespace = "com.devca.mainMapper";
	
	/*
	 * roadmap 관련
	 */
	// 자신의 로드맵을 select
	@Override
	public ROADMAP getRoadMapData(int MEMBER_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		ROADMAP roadMap = session.selectOne(namespace + ".selectRoadMap", MEMBER_CODE);
		session.close();

		return roadMap;
	}

	/*
	 * job Rank 시각화를 위해 데이터 불러오기
	 */
	// '개발자라면' 기술 요구사항 데이터 요청 처리
	@Override
	public List<JOB_RANK> getDeveloperBarChartData() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<JOB_RANK> job_rankList = session.selectList(namespace + ".getDeveloperBarChartData");
		session.close();

		return job_rankList;
	}

	// '웹 지식' 기술 요구사항 데이터 요청 처리
	@Override
	public List<JOB_RANK> getWebBarChartData() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<JOB_RANK> job_rankList = session.selectList(namespace + ".getWebBarChartData");
		session.close();

		return job_rankList;
	}

	// '서버' 기술 요구사항 데이터 요청 처리
	@Override
	public List<JOB_RANK> getServerBarChartData() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<JOB_RANK> job_rankList = session.selectList(namespace + ".getServerBarChartData");
		session.close();

		return job_rankList;
	}

	// '언어' 기술 요구사항 데이터 요청 처리
	@Override
	public List<JOB_RANK> getLanguageBarChartData() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<JOB_RANK> job_rankList = session.selectList(namespace + ".getLanguageBarChartData");
		session.close();

		return job_rankList;
	}

	// '데이터베이스' 기술 요구사항 데이터 요청 처리
	@Override
	public List<JOB_RANK> getDataBaseBarChartData() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<JOB_RANK> job_rankList = session.selectList(namespace + ".getDataBaseBarChartData");
		session.close();

		return job_rankList;
	}

	// '프레임워크&라이브러리' 기술 요구사항 데이터 요청 처리
	@Override
	public List<JOB_RANK> getframeWorkBarChartData() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<JOB_RANK> job_rankList = session.selectList(namespace + ".getframeWorkBarChartData");
		session.close();

		return job_rankList;
	}

}
