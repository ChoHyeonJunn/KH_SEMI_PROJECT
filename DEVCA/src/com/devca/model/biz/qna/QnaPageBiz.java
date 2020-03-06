package com.devca.model.biz.qna;

import java.util.List;
import com.devca.model.dto.QNA_BOARD;

public interface QnaPageBiz {
	public List<QNA_BOARD> selectList();
	public QNA_BOARD selectOne(int QNA_BOARD_NO);
	public int insert(QNA_BOARD QNA_BOARD);
	public int update(QNA_BOARD QNA_BOARD);
	public int delete(int QNA_BOARD_NO);
	public int answerProc(QNA_BOARD QNA_BOARD);
}
