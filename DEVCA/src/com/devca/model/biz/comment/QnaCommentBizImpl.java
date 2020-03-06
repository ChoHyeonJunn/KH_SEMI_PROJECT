package com.devca.model.biz.comment;

import java.util.List;

import com.devca.model.dao.comment.QnaCommentDaoImpl;
import com.devca.model.dto.qna.QNA_COMMENT;

public class QnaCommentBizImpl implements QnaCommentBiz {
	
	private QnaCommentDaoImpl dao = new QnaCommentDaoImpl();

	@Override
	public List<QNA_COMMENT> selectCommentList(int COMMENT_BOARD_NO) {
		// TODO Auto-generated method stub
		return dao.selectCommentList(COMMENT_BOARD_NO);
	}

	@Override
	public int insertComment(QNA_COMMENT QNA_COMMENT) {
		// TODO Auto-generated method stub
		return dao.insertComment(QNA_COMMENT);
	}

	@Override
	public int updateComment(QNA_COMMENT QNA_COMMENT) {
		// TODO Auto-generated method stub
		return dao.updateComment(QNA_COMMENT);
	}

	@Override
	public int deleteComment(int COMMENT_BOARD_NO) {
		// TODO Auto-generated method stub
		return dao.deleteComment(COMMENT_BOARD_NO);
	}

	@Override
	public int subCommentProc(QNA_COMMENT QNA_COMMENT) {
		// TODO Auto-generated method stub
		int updateSubCom = dao.updateSubComment(QNA_COMMENT.getCOMMENT_NO());
		int insertSubCom = dao.insertSubComment(QNA_COMMENT);

		return updateSubCom + insertSubCom;
	}



	

}
