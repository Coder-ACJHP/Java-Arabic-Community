package com.community.web.dao;

import com.community.web.entity.Authorities;

public interface AuthoritiesDAO {

	public Authorities getAuthoritiesByEmail(String email);
	
	public void saveAuthority(Authorities authorities);

	public void deleteAuthorityByUserId(int theId);
	
}
