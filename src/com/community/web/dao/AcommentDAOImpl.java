package com.community.web.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.Acomment;

@Repository
public class AcommentDAOImpl implements AcommentDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public Acomment getCommentById(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Acomment acomment = currentSession.get(Acomment.class, theId);
		return acomment;
	}

	@Override
	public List<Acomment> getAllComments() {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Acomment> query = currentSession.createQuery("from Acomment", Acomment.class);
		List<Acomment> commentList = query.getResultList();
		return commentList;
	}


	@Override
	public void save(Acomment acomment) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(acomment);
	}

	@Override
	public List<Acomment> getAllCommentsbyId(int answerId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Acomment> query = currentSession.createQuery("from Acomment where ANSWERID=:answerId",Acomment.class);
		query.setParameter("answerId", answerId);
		List<Acomment> acommnetsList = query.getResultList();
		return acommnetsList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void deleteAcommentByAnswerId(int answerId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("delete Acomment where ANSWERID = :answerId");
		query.setParameter("answerId", answerId);
		query.executeUpdate();
	}

}
