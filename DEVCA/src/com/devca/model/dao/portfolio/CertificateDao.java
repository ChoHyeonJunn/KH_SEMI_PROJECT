package com.devca.model.dao.portfolio;

import java.util.List;

import com.devca.model.dto.profile.CERTIFICATE;

public interface CertificateDao {

	public List<CERTIFICATE> certificate_select(int member_code);
	
	public CERTIFICATE certificate_select_one(int member_code);
	
	public int certificate_insert(CERTIFICATE dto);
	
	public int certificate_update(CERTIFICATE dto);
	
	public int certificate_delete_one(int certificate_seq, int member_code);
	
	public int certificate_delete(int member_code);
	
	public int certificate_count(int member_code);
	
	public int certificate_insert_new(int member_code);

}
