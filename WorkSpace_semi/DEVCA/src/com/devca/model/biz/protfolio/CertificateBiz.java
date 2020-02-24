package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dto.CERTIFICATE;

public interface CertificateBiz {

	public List<CERTIFICATE> certificate_select(int member_code);
	
	public CERTIFICATE certificate_select_one(int member_code);
	
	public int certificate_insert(CERTIFICATE dto);
	
	public int certificate_update(CERTIFICATE dto);
	
	public int certificate_delete_one(int cretificate_seq, int member_code);
	
	public int certificate_delete(int member_code);
}
