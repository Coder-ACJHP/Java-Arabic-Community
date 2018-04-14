package com.community.web.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.QuestionComment;

@Repository
public class QuestionCommentDaoImpl implements QuestionCommentDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public QuestionComment getCommentById(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		QuestionComment QuestionComment = currentSession.get(QuestionComment.class, theId);
		return QuestionComment;
	}

	@Override
	public List<QuestionComment> getAllComments() {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<QuestionComment> query = currentSession.createQuery("from QuestionComment", QuestionComment.class);
		List<QuestionComment> commentList = query.getResultList();
		return commentList;
	}

	@Override
	public List<QuestionComment> getAllCommentsById(int questionsId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<QuestionComment> query = currentSession.createQuery("from QuestionComment where QUESTIONID=:questionsId",
				QuestionComment.class);
		query.setParameter("questionsId", questionsId);
		List<QuestionComment> commentsList = query.getResultList();
		return commentsList;
	}

	@Override
	public void save(QuestionComment questionComment) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(questionComment);

	}

	@SuppressWarnings("rawtypes")
	@Override
	public void deleteQcommentByQuestionId(int questionId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("delete QuestionComment where QUESTIONID = :ID");
		query.setParameter("ID", questionId);
		query.executeUpdate();

	}

}