package com.community.web.dao;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.Optional;

import javax.persistence.NoResultException;
import javax.servlet.ServletContext;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.Authorities;
import com.community.web.entity.Users;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Autowired
	private ServletContext servletContext;

	@Override
	public Users getUser(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		try {
			return currentSession.get(Users.class, theId);
		} catch (NoResultException ex) {
			return null;
		}
	}

	@Override
	public Users getUserByEmail(String email) {
		Users theusers = null;
		try {
			Session currentSession = sessionFactory.getCurrentSession();
			Query<Users> query = currentSession.createQuery("from Users where EMAIL=:theEmail", Users.class);
			query.setParameter("theEmail", email);
			theusers = query.getSingleResult();

		} catch (NoResultException ex) {
			return null;
		}
		return theusers;
	}

	@Override
	public List<Users> getUserList() {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Users> query = currentSession.createQuery("from Users", Users.class);
		List<Users> userList = query.getResultList();
		return userList;
	}

	@Override
	public void save(Users users) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.save(users);

	}

	@Override
	public List<Users> searchUser(String searchName) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Users> query = null;
		if (searchName != null && searchName.length() > 0) {
			query = currentSession.createQuery("from Users where lower(nickname) like:theName", Users.class);
			query.setParameter("theName", "%" + searchName.toLowerCase() + "%");
		} else {
			query = currentSession.createQuery("from Users", Users.class);
		}

		List<Users> foundUsersList = query.getResultList();
		return foundUsersList;
	}

	@Override
	public void deleteUser(int id) {
		Session currentSession = sessionFactory.getCurrentSession();
		final Users theUsers = currentSession.get(Users.class, id);
		final Authorities authorities = currentSession.get(Authorities.class, id);
		currentSession.delete(theUsers);
		currentSession.delete(authorities);

	}

	@Override
	public void changeUserAsGuest(int theId) throws IOException {

		Session currentSession = sessionFactory.getCurrentSession();
		File theFile = new File(servletContext.getRealPath("/resources/images/nouser.jpg"));
		byte[] array = Files.readAllBytes(theFile.toPath());
		Query<?> query = currentSession.createQuery("update Users set FIRSTNAME =:firstname, LASTNAME =:lastname,"
				+ " EMAIL =:email, COUNTRY =:country, NICKNAME =:nickname, PASSWORD =:password,"
				+ " FAV_PROG_LANG =:favLangs, ABOUT =:about, PICTURE = :theArray, VOTE =:vote where ID= :theId");
		if (array != null && array.length > 0) {
			query.setParameter("theArray", array);
		}
		query.setParameter("firstname", "GUEST");
		query.setParameter("lastname", "GUEST");
		query.setParameter("email", "guest@jac.com");
		query.setParameter("country", "EVERYWHERE");
		query.setParameter("nickname", "GUEST");
		query.setParameter("password", "GUESTXX958");
		query.setParameter("favLangs", "Java");
		query.setParameter("about", "I m a guest no need to explanation");
		query.setParameter("vote", 100);
		query.setParameter("theId", theId);
		query.executeUpdate();

	}

	@Override
	public void upVoteUser(int qUserId, int value) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<?> query = currentSession.createQuery("update Users set VOTE= VOTE + :value where ID= :qUserId");
		query.setParameter("value", value);
		query.setParameter("qUserId", qUserId);
		query.executeUpdate();
	}

	@Override
	public void downVoteUser(int qUserId, int value) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<?> query = currentSession.createQuery("update Users set VOTE= VOTE - :value where ID= :qUserId");
		query.setParameter("value", value);
		query.setParameter("qUserId", qUserId);
		query.executeUpdate();

	}

	@Override
	public void updateUserAnswerCount(int responderId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<?> query = currentSession
				.createQuery("update Users set ANSWERCOUNT= ANSWERCOUNT + 1 where ID= :responderId");
		query.setParameter("responderId", responderId);
		query.executeUpdate();
	}

	@Override
	public void updateUserQuestionCount(int userid) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<?> query = currentSession
				.createQuery("update Users set QUESTIONCOUNT= QUESTIONCOUNT + 1 where ID= :userid");
		query.setParameter("userid", userid);
		query.executeUpdate();

	}

	@Override
	public void setUUIDofUser(int Id, String uuid, String expirationDate) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<?> query = currentSession
				.createQuery("update Users set UUID= :uuid, UUIDEXPDATE= :expDate where ID= :userid");
		query.setParameter("uuid", uuid);
		query.setParameter("expDate", expirationDate);
		query.setParameter("userid", Id);
		query.executeUpdate();
	}

	@Override
	public void updateUser(Users users) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.update(users);

	}

	@Override
	public Optional<Users> findUserByEmailOptional(String theEmail) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Users> query = currentSession.createQuery("from Users where EMAIL=:theEmail", Users.class);
		query.setParameter("theEmail", theEmail);
		Optional<Users> loginUser = query.uniqueResultOptional();
		return loginUser;
	}

}