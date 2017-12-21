package com.community.web.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.Answer;

@Repository
public class AnswerDAOImpl implements AnswerDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public Answer getAnswersById(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Answer theAnswers = currentSession.get(Answer.class, theId);
		return theAnswers;
	}

	@Override
	public List<Answer> getAllAnswers(int questionsId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Answer> query = currentSession.createQuery("from Answer where QUESTIONSID=:questionsId", Answer.class);
		query.setParameter("questionsId", questionsId);
		List<Answer> answersList = query.getResultList();
		return answersList;
	}

	@Override
	public void saveAnswer(Answer answer) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(answer);
	}

	@Override
	public List<Answer> getAllAnswers() {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Answer> query = currentSession.createQuery("from Answer", Answer.class);
		List<Answer> answerList = query.getResultList();
		return answerList;
	}

	@Override
	public void upVoteAnswer(int id, int value) {
		Session currentSession = sessionFactory.getCurrentSession();
		@SuppressWarnings("rawtypes")
		Query query = currentSession.createQuery("update Answer set VOTE= VOTE + :value where ID= :theId");
		query.setParameter("value", value);
		query.setParameter("theId", id);
		query.executeUpdate();
		
	}

	@Override
	public void downVoteAnswer(int id, int value) {
		Session currentSession = sessionFactory.getCurrentSession();
		@SuppressWarnings("rawtypes")
		Query query = currentSession.createQuery("update Answer set VOTE= VOTE - :value where ID= :theId");
		query.setParameter("value", value);
		query.setParameter("theId", id);
		query.executeUpdate();
		
	}

	@Override
	public void acceptAnswer(int id) {
		Session currentSession = sessionFactory.getCurrentSession();
		@SuppressWarnings("rawtypes")
		Query query = currentSession.createQuery("update Answer set ISACCEPTED= 1 where ID= :theId");
		query.setParameter("theId", id);
		query.executeUpdate();
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void deleteAnswerByQuestionId(int id) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("delete Answer where QUESTIONSID = :ID");
		query.setParameter("ID", id);
		query.executeUpdate();
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void deleteAnswerById(int answerId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("delete Answer where ID = :answerId");
		query.setParameter("answerId", answerId);
		query.executeUpdate();
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void changeAnswerAsGuess(int id) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("update Answer set USERID=6 where ID= :theId");
		query.setParameter("theId", id);
		query.executeUpdate();
	}

}
