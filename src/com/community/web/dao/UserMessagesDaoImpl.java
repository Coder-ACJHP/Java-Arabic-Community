package com.community.web.dao;

import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.UserMessages;

@Repository
public class UserMessagesDaoImpl implements UserMessagesDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<UserMessages> fetchUserMessageList(int userId) {
		Session currentSession = sessionFactory.getCurrentSession();
		final Query<UserMessages> query = currentSession.createQuery("from UserMessages where userId=:theId",
				UserMessages.class);
		query.setParameter("theId", userId);
		return query.getResultList();
	}

	@Override
	public void sendMessageToUser(UserMessages message) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.save(message);

	}

	@Override
	public boolean setMessageAsReadById(int messageId) {
		Session currentSession = sessionFactory.getCurrentSession();
		try {
			final UserMessages message = currentSession.get(UserMessages.class, messageId);
			message.setIsRead(true);
			currentSession.update(message);
			return true;
		} catch (NoResultException ex) {
			return false;
		}
	}

	@Override
	public UserMessages findUserMessageById(int messageId) {
		Session currentSession = sessionFactory.getCurrentSession();
		return currentSession.get(UserMessages.class, messageId);
	}

}
