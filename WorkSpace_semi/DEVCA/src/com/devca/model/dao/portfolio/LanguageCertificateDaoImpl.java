package com.devca.model.dao.portfolio;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dto.LANGUAGE_CERTIFICATE;
import com.devca.mybatis.SqlMapConfig;

public class LanguageCertificateDaoImpl extends SqlMapConfig implements LanguageCertificateDao {

	final String namespace ="com.devca.languagecertificateMapper";	
	
	@Override
	public List<LANGUAGE_CERTIFICATE> language_certificate_select(int language_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		List<LANGUAGE_CERTIFICATE> langcertList = session.selectList(namespace+".language_certificate_select",language_seq);
		session.close();
		return langcertList;
	}

	@Override
	public LANGUAGE_CERTIFICATE language_certificate_select_seq(int language_seq) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		LANGUAGE_CERTIFICATE langcert_seq = session.selectOne(namespace+".language_certificate_select_seq",language_seq);
		session.close();
		return langcert_seq;
	}

	@Override
	public int language_certificate_insert(LANGUAGE_CERTIFICATE dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int langcert_res = session.insert(namespace+".language_certificate_insert",dto);
		session.close();
		return langcert_res;
	}

	@Override
	public int language_certificate_update(LANGUAGE_CERTIFICATE dto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int langcert_res = session.update(namespace+".language_certificate_update",dto);
		session.close();
		return langcert_res;
	}

	@Override
	public int language_certificate_delete(int language_seq, int member_code) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("language_seq", language_seq);
		map.put("member_code", member_code);
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		int langcert_res = session.delete(namespace+".language_certificate_update",map);
		session.close();
		return langcert_res;
	}

}
