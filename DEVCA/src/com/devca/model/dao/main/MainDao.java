package com.devca.model.dao.main;

import java.util.List;

import com.devca.model.dto.lecture.JOB_RANK;
import com.devca.model.dto.member.ROADMAP;

public interface MainDao {
	/*
	 * roadmap 관련
	 */
	// 자신의 로드맵을 select
	public ROADMAP getRoadMapData(int MEMBER_CODE);

	/*
	 * job Rank 시각화를 위해 데이터 불러오기
	 */
	// '개발자라면' 기술 요구사항 데이터 요청 처리
	public List<JOB_RANK> getDeveloperBarChartData();

	// '웹 지식' 기술 요구사항 데이터 요청 처리
	public List<JOB_RANK> getWebBarChartData();

	// '서버' 기술 요구사항 데이터 요청 처리
	public List<JOB_RANK> getServerBarChartData();

	// '언어' 기술 요구사항 데이터 요청 처리
	public List<JOB_RANK> getLanguageBarChartData();

	// '데이터베이스' 기술 요구사항 데이터 요청 처리
	public List<JOB_RANK> getDataBaseBarChartData();

	// '프레임워크&라이브러리' 기술 요구사항 데이터 요청 처리
	public List<JOB_RANK> getframeWorkBarChartData();
}
