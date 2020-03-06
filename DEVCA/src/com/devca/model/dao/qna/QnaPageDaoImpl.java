package com.devca.model.dao.qna;

import java.io.IOException;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.devca.model.dto.QNA_BOARD;

public class QnaPageDaoImpl implements QnaPageDao {

	public List<QNA_BOARD> selectList() {

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
		List<QNA_BOARD> list = session.selectList("com.devca.qnaPageMapper.selectList");
		session.close();

		return list;
	}

	public QNA_BOARD selectOne(int QNA_BOARD_NO) {
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

		QNA_BOARD QNA_BOARD = session.selectOne("com.devca.qnaPageMapper.selectOne", QNA_BOARD_NO);
		session.close();

		return QNA_BOARD;
	}

	public int insert(QNA_BOARD QNA_BOARD) {
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

		int res = session.insert("com.devca.qnaPageMapper.insert", QNA_BOARD);

		if (res > 0) {
			session.commit();
		} else {
			session.close();
		}

		return res;

	}

	public int update(QNA_BOARD QNA_BOARD) {
		String resource = "com/devca/mybatis/config.xml";
		InputStream inputStream = null;

		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

		SqlSession session = sqlSessionFactory.openSession(true);// 오토커밋, 디폴트는 false

		int res = session.update("com.devca.qnaPageMapper.update", QNA_BOARD);

		session.close();

		return res;
	}

	public int delete(int QNA_BOARD_NO) {
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

		int res = session.delete("com.devca.qnaPageMapper.delete", QNA_BOARD_NO);

		session.close();

		return res;
	}

	public int answerUpdate(int parentboardno) {
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

		int res = session.update("com.devca.qnaPageMapper.answerUpdate", parentboardno);

		session.close();

		return res;

	}

	public int answerInsert(QNA_BOARD QNA_BOARD) {
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

		int res = session.insert("com.devca.qnaPageMapper.answerInsert", QNA_BOARD);

		if (res > 0) {
			session.commit();
		} else {
			session.close();
		}

		return res;
	}

}
