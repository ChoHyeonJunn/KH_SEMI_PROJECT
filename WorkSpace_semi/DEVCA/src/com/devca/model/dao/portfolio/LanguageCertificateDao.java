package com.devca.model.dao.portfolio;

import java.util.List;

import com.devca.model.dto.LANGUAGE_CERTIFICATE;

public interface LanguageCertificateDao {
	
	public List<LANGUAGE_CERTIFICATE> language_certificate_select(int language_seq);
	
	public LANGUAGE_CERTIFICATE	language_certificate_select_seq(int language_seq);
	
	public int language_certificate_insert(LANGUAGE_CERTIFICATE dto);
	
	public int language_certificate_update(LANGUAGE_CERTIFICATE dto);
	
	public int language_certificate_delete(int language_seq, int member_code);
	
}
