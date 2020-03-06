package com.devca.model.biz.qna;

import java.util.List;

import com.devca.model.dao.qna.QnaPageDaoImpl;
import com.devca.model.dto.qna.QNA_BOARD;

public class QnaPageBizImpl {

	private QnaPageDaoImpl dao = new QnaPageDaoImpl();

	public List<QNA_BOARD> selectList() {
		return dao.selectList();
	}

	public QNA_BOARD selectOne(int QNA_BOARD_NO) {

		return dao.selectOne(QNA_BOARD_NO);
	}

	public int insert(QNA_BOARD QNA_BOARD) {
		return dao.insert(QNA_BOARD);
	}

	public int update(QNA_BOARD QNA_BOARD) {
		return dao.update(QNA_BOARD);
	}

	public int delete(int QNA_BOARD_NO) {
		return dao.delete(QNA_BOARD_NO);
	}

	public int answerProc(QNA_BOARD QNA_BOARD) {
		int updateRes = dao.answerUpdate(QNA_BOARD.getQNA_BOARD_NO());
		int insertRes = dao.answerInsert(QNA_BOARD);

		return updateRes + insertRes;
	}
}
