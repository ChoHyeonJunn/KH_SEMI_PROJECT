package com.devca.model.biz.lecture;

import java.util.List;

import com.devca.model.dto.lecture.LECTURE;

public class LectureBizImpl implements LectureBiz {

	// 강의 리스트 선택
	@Override
	public List<LECTURE> selectLectureList(int no) {
		return dao.selectLectureList(no);
	}

}
