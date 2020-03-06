package com.devca.model.biz.protfolio;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.devca.model.dao.portfolio.LanguageCertificateDao;
import com.devca.model.dao.portfolio.LanguageCertificateDaoImpl;
import com.devca.model.dto.profile.LANGUAGE_CERTIFICATE;

public class LanguageCertificateBizImpl implements LanguageCertificateBiz {

	LanguageCertificateDao langcertdao = new LanguageCertificateDaoImpl();

	@Override
	public List<LANGUAGE_CERTIFICATE> language_certificate_select(int language_seq) {
		return langcertdao.language_certificate_select(language_seq);
	}

	@Override
	public LANGUAGE_CERTIFICATE language_certificate_select_seq(int language_seq) {
		return langcertdao.language_certificate_select_seq(language_seq);
	}

	@Override
	public int language_certificate_insert(LANGUAGE_CERTIFICATE dto) {
		return langcertdao.language_certificate_insert(dto);
	}

	@Override
	public int language_certificate_update(LANGUAGE_CERTIFICATE dto) {
		return langcertdao.language_certificate_update(dto);
	}

	@Override
	public int language_certificate_delete(int language_seq, int member_code) {
		return langcertdao.language_certificate_delete(language_seq, member_code);
	}

	@Override
	public int language_certificate_insert_new(int language_seq) {
		return langcertdao.language_certificate_insert_new(language_seq);
	}

	@Override
	public int language_certificate_count(int language_seq) {
		return langcertdao.language_certificate_count(language_seq);
	}
	

}
