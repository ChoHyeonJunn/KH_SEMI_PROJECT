package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.CERTIFICATE;
import com.devca.mybatis.SqlMapConfig;

public class CertificateDaoImpl extends SqlMapConfig implements CertificateDao {

	final String namespace = "com.devca.certificateMapper";
	@Override
	public List<CERTIFICATE> certificate_select(int profile_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<CERTIFICATE> list = session.selectList(namespace+".certificate_select",profile_seq);
		session.close();
		return list;
	}
	@Override
	public int certificate_insert(CERTIFICATE dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".certificate_insert",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int certificate_update(CERTIFICATE dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace+".certificate_update",dto);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public int certificate_delete_one(int certificate_seq, int member_code) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("certificate",certificate_seq);
		map.put("member_code", member_code);
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace+".certificate_delete_one",map);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	@Override
	public CERTIFICATE certificate_select_one(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		CERTIFICATE certificate_seq = session.selectOne(namespace+".certificate_select_one",member_code);
		session.close();
		return certificate_seq;
	}
	@Override
	public int certificate_delete(int member_code) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int certificate_res = session.delete(namespace+".certificate_delete",member_code);
		session.close();
		return certificate_res;
	}

}
