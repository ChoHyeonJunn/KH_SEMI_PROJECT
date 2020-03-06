package com.devca.model.biz.review;

import java.util.List;

import com.devca.model.dao.review.ReviewDao;
import com.devca.model.dao.review.ReviewDaoImpl;
import com.devca.model.dto.lecture.REVIEW;

public class ReviewBizImpl implements ReviewBiz {

	ReviewDao dao = new ReviewDaoImpl();

	@Override
	public List<REVIEW> selectReviewList(int LECTURE_CODE) {
		return dao.selectReviewList(LECTURE_CODE);
	}

	// 강의 후기 수정
	@Override
	public int insertReview(REVIEW review) {
		return dao.insertReview(review);
	}

	// 강의 후기 수정
	@Override
	public int updateReview(REVIEW newReview) {
		return dao.updateReview(newReview);
	}

	// 강의 후기 삭제
	@Override
	public int deleteReview(int REVIEW_CODE) {
		return dao.deleteReview(REVIEW_CODE);
	}

}
