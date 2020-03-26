package com.devca.model.biz.lecture;

import java.util.List;

import com.devca.model.dao.lecture.LectureDao;
import com.devca.model.dao.lecture.LectureDaoImpl;
import com.devca.model.dto.lecture.LECTURE;

public interface LectureBiz {
	LectureDao dao = new LectureDaoImpl();

	// 강의 리스트 선택
	public List<LECTURE> selectLectureList(int no);

}
