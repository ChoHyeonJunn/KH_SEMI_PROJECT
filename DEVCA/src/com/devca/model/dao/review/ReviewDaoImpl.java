package com.devca.model.dao.review;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.lecture.REVIEW;
import com.devca.mybatis.SqlMapConfig;

public class ReviewDaoImpl extends SqlMapConfig implements ReviewDao {

	final String namespace = "com.devca.reviewMapper";

	// 해당 강의의 후기 리스트 select
	@Override
	public List<REVIEW> selectReviewList(int LECTURE_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<REVIEW> reviewList = session.selectList(namespace + ".selectReviewList", LECTURE_CODE);
		session.close();

		return reviewList;
	}

	// 강의 후기 입력
	@Override
	public int insertReview(REVIEW review) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".insertReview", review);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	// 강의 후기 수정
	@Override
	public int updateReview(REVIEW newReview) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateReview", newReview);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	// 강의 후기 삭제
	@Override
	public int deleteReview(int REVIEW_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.delete(namespace + ".deleteReview", REVIEW_CODE);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

}
