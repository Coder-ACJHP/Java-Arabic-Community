package com.community.web.dao;

import java.util.List;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.Question;

@Repository
public class QuestionDAOImpl implements QuestionDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public Question getQuestion(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Question theQuestions = currentSession.get(Question.class, theId);
		return theQuestions;
	}

	@Override
	public List<Question> getAllQuestions() {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Question> query = currentSession.createQuery("from Question", Question.class);
		List<Question> questionsList = query.getResultList();
		return questionsList;
	}
	
	@Override
	public List<Question> getAllQuestionsByLimit(Integer offset, Integer maxresults) {
		int pageNumber = offset;
		int pageSize = maxresults;
		
		Session currentSession = sessionFactory.getCurrentSession();
		CriteriaBuilder criteriaBuilder = currentSession.getCriteriaBuilder();
		 
		CriteriaQuery<Long> countQuery = criteriaBuilder
		  .createQuery(Long.class);
		countQuery.select(criteriaBuilder
		  .count(countQuery.from(Question.class)));
		Long count = currentSession.createQuery(countQuery)
		  .getSingleResult();
		 
		CriteriaQuery<Question> criteriaQuery = criteriaBuilder
		  .createQuery(Question.class);
		Root<Question> from = criteriaQuery.from(Question.class);
		CriteriaQuery<Question> select = criteriaQuery.select(from);
		 
		TypedQuery<Question> typedQuery = currentSession.createQuery(select);
		while (pageNumber < count.intValue()) {
		    typedQuery.setFirstResult(pageNumber - 1);
		    typedQuery.setMaxResults(pageSize);
		    pageNumber += pageSize;
		}
		return typedQuery.getResultList();
	}
	
	@Override
	public List<Question> searchQuestions(String searchName) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Question> query = null;
		if (searchName != null && searchName.length() > 0) {
			query = currentSession.createQuery("from Question where lower(questions) like:theName",Question.class);
			query.setParameter("theName", "%" + searchName.toLowerCase() + "%");

		} else {
			query = currentSession.createQuery("from Question", Question.class);
		}

		List<Question> questions = query.getResultList();
		return questions;
	}

	@Override
	public void save(Question question) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(question);
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void setQuestionIsAnswered(int Id) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("update Question set ISANSWERED= 1 where ID= :Id");
		query.setParameter("Id", Id);
		query.executeUpdate();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void upVoteQuestion(int theId, int value) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("update Question set VOTE= VOTE + :value where ID= :theId");
		query.setParameter("value", value);
		query.setParameter("theId", theId);
		query.executeUpdate();
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void downVoteQuestion(int theId, int value) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("update Question set VOTE= VOTE - :value where ID= :theId");
		query.setParameter("value", value);
		query.setParameter("theId", theId);
		query.executeUpdate();
		
	}

	@Override
	public List<Question> getAllQuestionsByUserId(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Question> query = currentSession.createQuery("from Question where USERID = :theId", Question.class);
		query.setParameter("theId", theId);
		List<Question> questionList = query.getResultList();
		return questionList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void deleteQuestion(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("delete Question where id = :ID");
		query.setParameter("ID", theId);
		query.executeUpdate();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void changeQuestionAsGuess(int id) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query query = currentSession.createQuery("update Question set USERID=6 where ID= :theId");
		query.setParameter("theId", id);
		query.executeUpdate();
	}

	@SuppressWarnings({ "deprecation", "unchecked" })
	@Override
	public List<Question> getTopQuestions() {
		Session currentSession = sessionFactory.getCurrentSession();
		Criteria criteria = currentSession.createCriteria(Question.class);
		criteria.addOrder(Order.desc("CREATIONDATE"));
		List<Question> topQuestionsList = criteria.list();
		return topQuestionsList;
	}

}
