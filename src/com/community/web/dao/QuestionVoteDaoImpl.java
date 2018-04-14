package com.community.web.dao;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.QuestionVote;

@Repository
public class QuestionVoteDaoImpl implements QuestionVoteDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void addQuestionVote(QuestionVote questionVote) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.save(questionVote);

	}

	@Override
	public int checkTheQuestionVoteIsThere(int userId, int questionId) {
		Session currentSession = sessionFactory.getCurrentSession();
		final String SQL_QUERY = "from QuestionVote where Users_Id=:userId and Question_Id=:questionId";
		final Query<QuestionVote> query = currentSession.createQuery(SQL_QUERY, QuestionVote.class);
		query.setParameter("userId", userId);
		query.setParameter("questionId", questionId);
		try {
			return query.getSingleResult().getVote();
		} catch (NoResultException ex) {
			return 0;
		}

	}

	@Override
	public void updateQuestionVote(int currentUserId, int questionId, int voteVal) {
		Session currentSession = sessionFactory.getCurrentSession();
		final String SQL_QUERY = "from QuestionVote where Users_Id=:userId and Question_Id=:questionId";
		final Query<QuestionVote> query = currentSession.createQuery(SQL_QUERY, QuestionVote.class);
		query.setParameter("userId", currentUserId);
		query.setParameter("questionId", questionId);

		QuestionVote questionVote = query.getSingleResult();
		questionVote.setVote(voteVal);
		currentSession.update(questionVote);
	}
}