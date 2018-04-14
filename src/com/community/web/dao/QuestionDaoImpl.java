package com.community.web.dao;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.community.web.entity.Question;

@Repository
public class QuestionDaoImpl implements QuestionDao {

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
	public List<Question> getAllQuestionsByLimit(Integer offset, Integer maxResults) {

		Session currentSession = sessionFactory.getCurrentSession();
		CriteriaQuery<Question> query = currentSession.getCriteriaBuilder().createQuery(Question.class);
		Root<Question> root = query.from(Question.class);
		query.select(root);
		return currentSession.createQuery(query).setFirstResult(offset != null ? offset : 0)
				.setMaxResults(maxResults != null ? maxResults : 10).getResultList();
	}

	@Override
	public List<Question> searchQuestions(String searchName) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Question> query = null;
		if (searchName.trim().length() > 0) {
			query = currentSession.createQuery("from Question where lower(questions) like:theName", Question.class);
			query.setParameter("theName", "%" + searchName.toLowerCase() + "%");

		}

		return query.getResultList();
	}

	@Override
	public void save(Question question) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(question);

	}

	@Override
	public void setQuestionIsAnswered(int Id) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<?> query = currentSession.createQuery("update Question set ISANSWERED= 1 where ID= :Id");
		query.setParameter("Id", Id);
		query.executeUpdate();
	}

	@Override
	public void upVoteQuestion(int theId, int value) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<?> query = currentSession.createQuery("update Question set VOTE= VOTE + :value where ID= :theId");
		query.setParameter("value", value);
		query.setParameter("theId", theId);
		query.executeUpdate();

	}

	@Override
	public void downVoteQuestion(int theId, int value) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<?> query = currentSession.createQuery("update Question set VOTE= VOTE - :value where ID= :theId");
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

	@Override
	public void deleteQuestion(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Question question = currentSession.find(Question.class, theId);
		currentSession.delete(question);
	}

	@Override
	public void changeQuestionAsGuess(int id) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<?> query = currentSession.createQuery("update Question set USERID=6 where ID= :theId");
		query.setParameter("theId", id);
		query.executeUpdate();
	}

	@Override
	public List<Question> getTopQuestions(Integer offset, Integer maxResults) {
		Session currentSession = sessionFactory.getCurrentSession();
		CriteriaBuilder criteriaBuilder = currentSession.getCriteriaBuilder();
		CriteriaQuery<Question> criteriaQuery = criteriaBuilder.createQuery(Question.class);

		final Root<Question> root = criteriaQuery.from(Question.class);
		criteriaQuery.orderBy(criteriaBuilder.desc(root.get("CREATIONDATE")));
		return currentSession.createQuery(criteriaQuery).setFirstResult(offset != null ? offset : 0)
				.setMaxResults(maxResults != null ? maxResults : 10).getResultList();
	}

	@Override
	public void setQuestionUnAnswered(int id) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<?> query = currentSession.createQuery("update Question set ISANSWERED=0 where ID= :theId");
		query.setParameter("theId", id);
		query.executeUpdate();

	}

	@Override
	public Long getQuestionsCount() {
		Session currentSession = sessionFactory.getCurrentSession();
		CriteriaBuilder criteriaBuilder = currentSession.getCriteriaBuilder();
		CriteriaQuery<Long> criteriaQuery = criteriaBuilder.createQuery(Long.class);
		criteriaQuery.select(criteriaBuilder.count(criteriaQuery.from(Question.class)));
		return currentSession.createQuery(criteriaQuery).getSingleResult();
	}

}