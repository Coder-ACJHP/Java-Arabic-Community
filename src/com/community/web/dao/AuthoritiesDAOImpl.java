package com.community.web.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.Authorities;
import com.community.web.entity.Users;

@Repository
public class AuthoritiesDAOImpl implements AuthoritiesDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public Authorities getAuthoritiesByEmail(String email) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Authorities> query = currentSession.createQuery("from Authorities where EMAIL=:email", Authorities.class);
		query.setParameter("email", email);
		
		return query.getSingleResult();
	}

	@Override
	public void saveAuthority(Authorities authorities) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(authorities);
	}

	@Override
	public void deleteAuthorityByUserId(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Users user = currentSession.find(Users.class, theId); 
		currentSession.delete(getAuthoritiesByEmail(user.getEMAIL()));
		
	}

}
