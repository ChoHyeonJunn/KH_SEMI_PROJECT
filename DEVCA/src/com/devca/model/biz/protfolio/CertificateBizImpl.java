package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.CertificateDao;
import com.devca.model.dao.portfolio.CertificateDaoImpl;
import com.devca.model.dto.profile.CERTIFICATE;

public class CertificateBizImpl implements CertificateBiz {

	CertificateDao dao = new CertificateDaoImpl();
	@Override
	public List<CERTIFICATE> certificate_select(int profile_seq) {
		return dao.certificate_select(profile_seq);
	}

	@Override
	public int certificate_insert(CERTIFICATE dto) {
		return dao.certificate_insert(dto);
	}

	@Override
	public int certificate_update(CERTIFICATE dto) {
		return dao.certificate_update(dto);
	}

	@Override
	public CERTIFICATE certificate_select_one(int member_code) {
		return dao.certificate_select_one(member_code);
	}

	@Override
	public int certificate_delete_one(int cretificate_seq, int member_code) {
		return dao.certificate_delete_one(cretificate_seq, member_code);
	}

	@Override
	public int certificate_delete(int member_code) {
		return dao.certificate_delete(member_code);
	}

	@Override
	public int certificate_count(int member_code) {
		return dao.certificate_count(member_code);
	}

	@Override
	public int certificate_insert_new(int member_code) {
		return dao.certificate_insert_new(member_code);
	}

}
