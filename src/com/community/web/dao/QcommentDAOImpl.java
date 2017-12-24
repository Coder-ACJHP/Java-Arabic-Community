package com.community.web.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.Qcomment;

@Repository
public class QcommentDAOImpl implements QcommentDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public Qcomment getCommentById(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Qcomment Qcomment = currentSession.get(Qcomment.class, theId);
		return Qcomment;
	}

	@Override
	public List<Qcomment> getAllComments() {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Qcomment> query = currentSession.createQuery("from Qcomment", Qcomment.class);
		List<Qcomment> commentList = query.getResultList();
		return commentList;
	}

	@Override
	public List<Qcomment> getAllCommentsById(int questionsId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Qcomment> query = currentSession.createQuery("from Qcomment where QUESTIONID=:questionsId", Qcomment.class);
		query.setParameter("questionsId", questionsId);
		List<Qcomment> commentsList = query.getResultList();
		return commentsList;
	}

	@Override
	public void save(Qcomment qcomment) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(qcomment);
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void deleteQcommentByQuestionId(int questionId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("delete Qcomment where QUESTIONID = :ID");
		query.setParameter("ID", questionId);
		query.executeUpdate();
		
	}

}
