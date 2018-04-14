package com.community.web.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.UserComment;

@Repository
public class UserCommentDaoImpl implements UserCommentDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void saveUserComment(UserComment userComment) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.save(userComment);
	}

}