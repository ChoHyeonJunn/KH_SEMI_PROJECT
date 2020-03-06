package com.devca.model.dao.qna;

import java.util.List;

import com.devca.model.dto.qna.QNA_BOARD;


public interface QnaPageDao {

	public List<QNA_BOARD> selectList();

	public QNA_BOARD selectOne(int QNA_BOARD_NO);

	public int insert(QNA_BOARD QNA_BOARD);

	public int update(QNA_BOARD QNA_BOARD);

	public int delete(int QNA_BOARD_NO);

	public int answerUpdate(int parentboardno);

	public int answerInsert(QNA_BOARD QNA_BOARD);

}
