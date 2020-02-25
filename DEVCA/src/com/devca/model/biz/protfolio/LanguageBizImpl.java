package com.devca.model.biz.protfolio;

import java.util.List;

import com.devca.model.dao.portfolio.LanguageDao;
import com.devca.model.dao.portfolio.LanguageDaoImpl;
import com.devca.model.dto.LANGUAGE;

public class LanguageBizImpl implements LanguageBiz {
	
	LanguageDao dao = new LanguageDaoImpl();
	@Override
	public List<LANGUAGE> language_select(int profile_seq) {
		return dao.language_select(profile_seq);
	}

	@Override
	public int language_insert(LANGUAGE dto) {
		return dao.language_insert(dto);
	}

	@Override
	public int language_update(LANGUAGE dto) {
		return dao.language_update(dto);
	}

	@Override
	public int language_delete(int language_seq, int profile_seq) {
		return dao.language_delete(language_seq, profile_seq);
	}

	@Override
	public LANGUAGE language_select_seq(int member_code) {
		return dao.language_select_seq(member_code);
	}

	@Override
	public int language_insert_new(int member_code) {
		// TODO Auto-generated method stub
		return dao.language_insert_new(member_code);
	}

	@Override
	public int language_count(int member_code) {
		// TODO Auto-generated method stub
		return dao.language_count(member_code);
	}

}
