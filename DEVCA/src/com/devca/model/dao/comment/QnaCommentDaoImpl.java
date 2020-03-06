package com.devca.model.dao.comment;

import java.io.IOException;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.devca.model.dto.qna.QNA_COMMENT;

public class QnaCommentDaoImpl implements QnaCommentDao {

	@Override
	public List<QNA_COMMENT> selectCommentList(int COMMENT_BOARD_NO) {
		// TODO Auto-generated method stub
		String resource = "com/devca/mybatis/config.xml";
		InputStream inputStream = null;
		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

		SqlSession session = sqlSessionFactory.openSession();
		List<QNA_COMMENT> comlist = session.selectList("com.devca.qnaCommentMapper.selectCommentList", COMMENT_BOARD_NO);
		session.close();

		return comlist;
	}

	@Override
	public int insertComment(QNA_COMMENT QNA_COMMENT) {
		// TODO Auto-generated method stub
		String resource = "com/devca/mybatis/config.xml";
		InputStream inputStream = null;

		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

		SqlSession session = sqlSessionFactory.openSession(true);

		int res = session.insert("com.devca.qnaCommentMapper.insertComment", QNA_COMMENT);

		session.close();

		return res;
	}

	@Override
	public int updateComment(QNA_COMMENT QNA_COMMENT) {
		// TODO Auto-generated method stub
		String resource = "com/devca/mybatis/config.xml";
		InputStream inputStream = null;

		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

		SqlSession session = sqlSessionFactory.openSession(true);

		int res = session.update("com.devca.qnaCommentMapper.updateComment", QNA_COMMENT);

		session.close();

		return res;

	}

	@Override
	public int deleteComment(int COMMENT_BOARD_NO) {
		// TODO Auto-generated method stub
		String resource = "com/devca/mybatis/config.xml";
		InputStream inputStream = null;

		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

		SqlSession session = sqlSessionFactory.openSession(true);

		int res = session.delete("com.devca.qnaCommentMapper.deleteComment", COMMENT_BOARD_NO);

		session.close();

		return res;
	}

	@Override
	public int updateSubComment(int parentcommentno) {
		// TODO Auto-generated method stub
		String resource = "com/devca/mybatis/config.xml";
		InputStream inputStream = null;

		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

		SqlSession session = sqlSessionFactory.openSession(true);

		int res = session.update("com.devca.qnaCommentMapper.updateSubComment", parentcommentno);

		session.close();

		return res;
	}

	@Override
	public int insertSubComment(QNA_COMMENT QNA_COMMENT) {
		// TODO Auto-generated method stub
		String resource = "com/devca/mybatis/config.xml";
		InputStream inputStream = null;

		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

		SqlSession session = sqlSessionFactory.openSession(true);

		int res = session.insert("com.devca.qnaCommentMapper.insertSubComment", QNA_COMMENT);

		session.close();
		
		return res;

	}

}
