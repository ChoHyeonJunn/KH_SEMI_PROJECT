package com.devca.model.dao.lecture;

import java.util.ArrayList;
import java.util.List;

import com.devca.model.dto.lecture.LECTURE;

public class LectureDaoImpl implements LectureDao {

	/*
	 * lecture 관련 요청
	 */
	// 강의 리스트 선택
	@Override
	public List<LECTURE> selectLectureList(int no) {

		List<LECTURE> lectureList = new ArrayList<LECTURE>();
		for (int i = 0; i < 105; i++) {
			LECTURE lecture = new LECTURE();
			lecture.setLECTURE_CODE(i);
			lecture.setLECTURE_TITLE("PYCON KOREA 2014");
			lecture.setLECTURE_IMG("https://olc.kr/resource/files/lec/201409/1332.jpg");
			lecture.setLECTURE_LINK("https://olc.kr/course/course_online_view.jsp?id=439&page=7");
			lecture.setLECTURE_PAYFLAG("무료");
			lecture.setLECTURE_RATE("4.5");
			lecture.setLECTURE_DESCRIPTION("[파이썬코리아] Module Test");

			lectureList.add(lecture);
		}

		List<LECTURE> lectureResList = new ArrayList<LECTURE>();
		for (int i = no; i < no + 20; i++) {
			if (lectureList.size() == i) {
				break;
			} else {
				lectureResList.add(lectureList.get(i));
			}
		}

		return lectureResList;
	}

}
