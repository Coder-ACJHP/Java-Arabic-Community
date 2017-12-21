package com.community.web.dao;

import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.Ucomment;

@Repository
public class UcommentDAOImpl implements UcommentDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public Ucomment getUserCommentById(int Id) {
		Ucomment ucomment = null;
		
		try {
			Session currentSession = sessionFactory.getCurrentSession();
			ucomment = currentSession.find(Ucomment.class, Id);
			
		}catch (NoResultException e) {}
		return ucomment;
	}

	@Override
	public Ucomment getUserCommentByOwnerId(int ownerId) {
	Ucomment ucomment = null;
		
		try {
			
			Session currentSession = sessionFactory.getCurrentSession();
			Query<Ucomment> query = currentSession.createQuery("from Ucomment where USERID=:ownerId", Ucomment.class);
			query.setParameter("ownerId", ownerId);
			ucomment = query.getSingleResult();
			
		}catch (NoResultException e) {}
		return ucomment;
	}

	@Override
	public List<Ucomment> getAllCommentsById(int ownerId) {
		List<Ucomment> ucommentsList = null;
		try {
			
			Session currentSession = sessionFactory.getCurrentSession();
			Query<Ucomment> query = currentSession.createQuery("from Ucomment where USERID=:ownerId", Ucomment.class);
			query.setParameter("ownerId", ownerId);
			ucommentsList = query.getResultList();
			
		} catch (NoResultException e) {
			return null;
		}
		return ucommentsList;
	}

	@Override
	public void saveUserComment(Ucomment ucomment) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(ucomment);
	}

	@Override
	public void deleteUserCommentById(int commentId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Ucomment ucomment = currentSession.find(Ucomment.class, commentId);
		currentSession.delete(ucomment);

	}

}
