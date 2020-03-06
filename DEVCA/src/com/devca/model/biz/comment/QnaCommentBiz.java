package com.devca.model.biz.comment;

import java.util.List;

import com.devca.model.dto.qna.QNA_COMMENT;

public interface QnaCommentBiz {
	
	// 게시글 별 댓글 리스트
	public List<QNA_COMMENT> selectCommentList(int COMMENT_BOARD_NO);
	
	// 원 댓글 달기
	public int insertComment(QNA_COMMENT QNA_COMMENT);
	
	// 댓글 수정
	public int updateComment(QNA_COMMENT QNA_COMMENT);

	// 댓글 삭제
	public int deleteComment(int COMMENT_BOARD_NO);
	
	public int subCommentProc(QNA_COMMENT QNA_COMMENT);

}
