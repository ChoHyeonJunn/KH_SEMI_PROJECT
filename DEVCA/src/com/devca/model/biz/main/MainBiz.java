package com.devca.model.biz.main;

import java.util.List;

import com.devca.model.dto.lecture.JOB_RANK;
import com.devca.model.dto.member.ROADMAP;

public interface MainBiz {
	// 로드맵 데이터 요청처리
	public ROADMAP getRoadMapData(int MEMBER_CODE);

	// 로드맵 데이터 추가 요청처리
	public int addRoadMapData(int MEMBER_CODE, String item);

	// 로드맵 중분류 추가 요청처리
	int addRoadMapCategory(int MEMBER_CODE, String item);

	// 로드맵 데이터 삭제 요청처리
	public int removeRoadMapData(int mEMBER_CODE, String item);

	// 로드맵 데이터 연결 요청처리
	public int linkRoadMapData(int mEMBER_CODE, String selectedItem, String item);

	// 기술 요구사항 데이터 요청 처리
	public List<JOB_RANK> getBarChartData(String verify);

}
