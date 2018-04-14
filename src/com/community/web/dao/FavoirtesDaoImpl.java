package com.community.web.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.Favorities;
import com.community.web.entity.Users;

@Repository
public class FavoirtesDaoImpl implements FavoritiesDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void saveFavorite(Favorities favorities) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.save(favorities);

	}

	@Override
	public List<Favorities> getFavoriteList(int userId) {

		Session currentSession = sessionFactory.getCurrentSession();
		Query<Favorities> query = currentSession.createQuery("from Favorities where Users_Id=:userId",
				Favorities.class);
		query.setParameter("userId", userId);

		return query.getResultList();

	}

	@Override
	public void deleteFavorite(int userId, int questionId) {

		Session currentSession = sessionFactory.getCurrentSession();
		Users favUser = currentSession.find(Users.class, userId);
		Query<?> query = currentSession
				.createQuery("delete from Favorities where Users_Id=:userId and FavQuestionId=:questionId");
		query.setParameter("userId", favUser.getID());
		query.setParameter("questionId", questionId);
		query.executeUpdate();
	}

	@Override
	public void deleteFavoriteByQuestionId(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Favorities> query = currentSession.createQuery("from Favorities where FavQuestionId=:Id",
				Favorities.class);
		query.setParameter("Id", theId);
		List<Favorities> favList = query.getResultList();

		for (Favorities favorities : favList) {
			currentSession.delete(favorities);
		}

	}

}