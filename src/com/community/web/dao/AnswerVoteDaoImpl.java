package com.community.web.dao;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.AnswerVote;

@Repository
public class AnswerVoteDaoImpl implements AnswerVoteDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void addAnswerVote(AnswerVote answerVote) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.save(answerVote);

	}

	@Override
	public int checkTheAnswerVoteIsThere(int userId, int answerId) {
		Session currentSession = sessionFactory.getCurrentSession();
		final String SQL_QUERY = "from AnswerVote where Users_Id=:userId and Answer_Id=:answerId";
		final Query<AnswerVote> query = currentSession.createQuery(SQL_QUERY, AnswerVote.class);
		query.setParameter("userId", userId);
		query.setParameter("answerId", answerId);
		try {
			return query.getSingleResult().getVote();
		} catch (NoResultException ex) {
			return 0;
		}

	}

	@Override
	public void updateAnswerVote(int currentUserId, int answerId, int voteVal) {
		Session currentSession = sessionFactory.getCurrentSession();
		final String SQL_QUERY = "from AnswerVote where Users_Id=:currentUserId and Answer_Id=:answerId";
		final Query<AnswerVote> query = currentSession.createQuery(SQL_QUERY, AnswerVote.class);
		query.setParameter("currentUserId", currentUserId);
		query.setParameter("answerId", answerId);

		AnswerVote answerVote = query.getSingleResult();
		answerVote.setVote(voteVal);
		currentSession.update(answerVote);

	}

}