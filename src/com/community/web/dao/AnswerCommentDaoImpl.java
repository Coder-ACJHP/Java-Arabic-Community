package com.community.web.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.AnswerComment;

@Repository
public class AnswerCommentDaoImpl implements AnswerCommentDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public AnswerComment getCommentById(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		AnswerComment answerComment = currentSession.get(AnswerComment.class, theId);
		return answerComment;
	}

	@Override
	public List<AnswerComment> getAllComments() {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<AnswerComment> query = currentSession.createQuery("from AnswerComment", AnswerComment.class);
		List<AnswerComment> commentList = query.getResultList();
		return commentList;
	}


	@Override
	public void save(AnswerComment answerComment) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(answerComment);
	}

	@Override
	public List<AnswerComment> getAllCommentsbyId(int answerId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<AnswerComment> query = currentSession.createQuery("from AnswerComment where ANSWERID=:answerId",
				AnswerComment.class);
		query.setParameter("answerId", answerId);
		List<AnswerComment> acommnetsList = query.getResultList();
		return acommnetsList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void deleteAcommentByAnswerId(int answerId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("delete AnswerComment where ANSWERID = :answerId");
		query.setParameter("answerId", answerId);
		query.executeUpdate();
	}

}
