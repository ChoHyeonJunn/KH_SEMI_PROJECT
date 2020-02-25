package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.CAREER_DETAIL;
import com.devca.mybatis.SqlMapConfig;

public class CareerDetailDaoImpl extends SqlMapConfig implements CareerDetailDao {
	

	final String namespace = "com.devca.career_detailMapper";
	@Override
	public List<CAREER_DETAIL> career_detail_select(int career_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<CAREER_DETAIL> list = session.selectList(namespace +".career_detail_select",career_seq);
		session.close();
		return list;
	}
	@Override
	public int career_detail_insert(CAREER_DETAIL dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace +".career_detail_insert",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int career_detail_update(CAREER_DETAIL dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace +".career_detail_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int career_detail_delete(int career_detail_seq, int career_seq) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("career_detail_seq",career_detail_seq);
		map.put("career_seq", career_seq);

		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace +".career_detail_delete",map);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public CAREER_DETAIL career_detail_select_seq(int career_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		CAREER_DETAIL career_detail_seq = session.selectOne(namespace+".career_detail_select_seq",career_seq);
		session.close();
		return career_detail_seq;
	}
	@Override
	public int career_detail_insert_new(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int career_detail_res = session.insert(namespace+".career_detail_insert_new",member_code);
		if(career_detail_res > 0) {
			session.commit();
		}
		session.close();
		return career_detail_res;
	}
	@Override
	public int career_detail_count(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int career_detail_count = session.selectOne(namespace+".career_detail_count",member_code);
		session.close();
		return career_detail_count;
	}

}
