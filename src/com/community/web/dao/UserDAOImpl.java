package com.community.web.dao;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

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
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Autowired
	private ServletContext servletContext;
	
	@Override
	public Users getUser(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Users users = currentSession.get(Users.class, theId);
		return users;
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
		final Authorities authorities = new Authorities(users.getEMAIL(), "ROLE_USER");
		users.setAuthorities(authorities);
		currentSession.saveOrUpdate(users);
	}

	@Override
	public List<Users> searchUser(String searchName) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Users> query = null;
		if (searchName != null && searchName.length() > 0) {
			query = currentSession.createQuery("from Users where lower(nickname) like:theName",Users.class);
			query.setParameter("theName", "%" + searchName.toLowerCase() + "%");
		} else {
			query = currentSession.createQuery("from Users", Users.class);
		}
		
		List<Users> foundUsersList = query.getResultList();
		return foundUsersList;
	}

	@Override
	public void updateUserPassword(int theId, String newPsw) {
		Session currentSession = sessionFactory.getCurrentSession();
		@SuppressWarnings("rawtypes")
		Query query = currentSession.createQuery("update Users set PASSWORD = :newPsw where ID= :theId");
		
		query.setParameter("newPsw", newPsw);
		query.setParameter("theId", theId);
		query.executeUpdate();
		
	}

	@Override
	public void deleteUser(int id) {
		Session currentSession = sessionFactory.getCurrentSession();		
		final Users theUsers = currentSession.get(Users.class, id);
		Query<?> query = currentSession.createQuery("from Authorities where EMAIL= :email");
		query.setParameter("email", theUsers.getEMAIL());
		currentSession.delete(theUsers);
		currentSession.delete(query.getSingleResult());
		
	}

	@Override
	public void changeUserAsGuest(int theId) throws IOException{
		
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

	@SuppressWarnings("rawtypes")
	@Override
	public void upVoteUser(int qUserId, int value) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("update Users set VOTE= VOTE + :value where ID= :qUserId");
		query.setParameter("value", value);
		query.setParameter("qUserId", qUserId);
		query.executeUpdate();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void downVoteUser(int qUserId, int value) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("update Users set VOTE= VOTE - :value where ID= :qUserId");
		query.setParameter("value", value);
		query.setParameter("qUserId", qUserId);
		query.executeUpdate();
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void updateUserAnswerCount(int responderId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("update Users set ANSWERCOUNT= ANSWERCOUNT + 1 where ID= :responderId");
		query.setParameter("responderId", responderId);
		query.executeUpdate();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void updateUserQuestionCount(int userid) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("update Users set QUESTIONCOUNT= QUESTIONCOUNT + 1 where ID= :userid");
		query.setParameter("userid", userid);
		query.executeUpdate();
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void setUUIDofUser(int Id, String uuid) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("update Users set UUID= :uuid where ID= :userid");
		query.setParameter("uuid", uuid);
		query.setParameter("userid", Id);
		query.executeUpdate();
	}

}
