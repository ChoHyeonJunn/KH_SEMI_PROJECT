package com.devca.model.dao.lecture;

import java.util.List;

import com.devca.model.dto.lecture.LECTURE;

public interface LectureDao {
	// 강의 리스트 선택
	public List<LECTURE> selectLectureList(int no);

}
