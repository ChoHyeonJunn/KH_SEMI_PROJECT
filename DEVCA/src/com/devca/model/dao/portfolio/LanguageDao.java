package com.devca.model.dao.portfolio;

import java.util.List;

import com.devca.model.dto.profile.LANGUAGE;

public interface LanguageDao {
	
	public List<LANGUAGE> language_select(int profile_seq);
	
	public int language_insert(LANGUAGE dto);
	
	public int language_update(LANGUAGE dto);
	
	public int language_delete(int member_code);
	
	public LANGUAGE language_select_seq(int member_code);
	
	public int language_insert_new(int member_code);
	
	public int language_count(int member_code);
	
}
