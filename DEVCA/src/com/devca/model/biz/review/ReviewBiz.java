package com.devca.model.biz.review;

import java.util.List;

import com.devca.model.dto.lecture.REVIEW;

public interface ReviewBiz {

	// 해당 강의의 후기 리스트 select
	public List<REVIEW> selectReviewList(int LECTURE_CODE);

	// 강의 후기 입력
	public int insertReview(REVIEW review);

	// 강의 후기 수정
	public int updateReview(REVIEW newReview);

	// 강의 후기 삭제
	public int deleteReview(int REVIEW_CODE);

}
