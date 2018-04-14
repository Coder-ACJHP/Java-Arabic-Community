package com.community.web.service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.community.web.dao.AnswerCommentDao;
import com.community.web.dao.AnswerDao;
import com.community.web.dao.AnswerVoteDao;
import com.community.web.dao.FavoritiesDao;
import com.community.web.dao.QuestionCommentDao;
import com.community.web.dao.QuestionDao;
import com.community.web.dao.QuestionVoteDao;
import com.community.web.dao.UserCommentDao;
import com.community.web.dao.UserDao;
import com.community.web.dao.UserMessagesDao;
import com.community.web.entity.Answer;
import com.community.web.entity.AnswerComment;
import com.community.web.entity.AnswerVote;
import com.community.web.entity.Favorities;
import com.community.web.entity.Question;
import com.community.web.entity.QuestionComment;
import com.community.web.entity.QuestionVote;
import com.community.web.entity.UserComment;
import com.community.web.entity.UserMessages;
import com.community.web.entity.Users;

@Service
@Transactional
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private QuestionDao questionDao;

	@Autowired
	private AnswerDao answerDao;

	@Autowired
	private QuestionCommentDao questionCommentDao;

	@Autowired
	private AnswerCommentDao answerCommentDao;

	@Autowired
	private UserCommentDao commentDAO;

	@Autowired
	private FavoritiesDao favoritiesDao;

	@Autowired
	private AnswerVoteDao answerVoteDao;

	@Autowired
	private QuestionVoteDao questionVoteDao;
	
	@Autowired
	private UserMessagesDao userMessagesDao;

	@Override
	@Cacheable(value = "users", cacheManager = "cacheManager")
	public Users getUserById(int theId) {
		return userDao.getUser(theId);
	}

	@Override
	@Cacheable(value = "users", cacheManager = "cacheManager")
	public List<Users> getUserList() {
		return userDao.getUserList();
	}

	@Override
	public List<Users> searchUser(String searchName) {
		return userDao.searchUser(searchName);
	}

	@Override
	public Question getQuestionById(int theId) {
		return questionDao.getQuestion(theId);
	}

	@Override
	public List<Question> getQuestionsList() {
		return questionDao.getAllQuestions();
	}

	@Override
	@Cacheable(value = "questions", cacheManager="cacheManager")
	public List<Question> getQuestionsListByLimit(Integer pageId, Integer maximumPages) {
		return questionDao.getAllQuestionsByLimit(pageId, maximumPages);
	}

	@Override
	public Answer getAnswerById(int theId) {
		return answerDao.getAnswersById(theId);
	}

	@Override
	@Cacheable(value = "answers", cacheManager = "cacheManager")
	public List<Answer> getAnswersList(int questionsId) {
		return answerDao.getAllAnswers(questionsId);
	}

	@Override
	public Users getUserByEmail(String email) {
		return userDao.getUserByEmail(email);
	}

	@Override
	public List<Question> searchQuestion(String searchName) {
		return questionDao.searchQuestions(searchName);
	}

	@Override
	public QuestionComment getCommentById(int theId) {
		return questionCommentDao.getCommentById(theId);
	}

	@Override
	public List<QuestionComment> getCommentList(int questionsId) {
		return questionCommentDao.getAllCommentsById(questionsId);
	}

	@Override
	public AnswerComment getAcommentbyId(int theId) {
		return answerCommentDao.getCommentById(theId);
	}

	@Override
	public List<AnswerComment> getCommentList() {
		return answerCommentDao.getAllComments();
	}

	@Override
	public List<AnswerComment> getAcommentList(int answerId) {
		return answerCommentDao.getAllCommentsbyId(answerId);
	}

	@Override
	public void saveAcomment(AnswerComment answerComment) {
		answerCommentDao.save(answerComment);

	}

	@Override
	public void saveQcomment(QuestionComment questionComment) {
		questionCommentDao.save(questionComment);

	}

	@Override
	@CachePut(value = "answers", cacheManager = "cacheManager")
	public void saveAnswer(Answer answer) {
		answerDao.saveAnswer(answer);

	}

	@Override
	@CachePut(value = "users", cacheManager = "cacheManager")
	public void saveUser(Users users) {
		userDao.save(users);

	}

	@Override
	@CachePut(value = "questions", cacheManager = "cacheManager")
	public void saveQuestion(Question question) {
		questionDao.save(question);

	}

	@Override
	public void setQuestionIsAnswered(int id) {
		questionDao.setQuestionIsAnswered(id);

	}

	@Override
	@Cacheable(value = "answers", cacheManager = "cacheManager")
	public List<Answer> getAnswersList() {
		return answerDao.getAllAnswers();
	}

	@Override
	@CachePut(value = "questions", cacheManager = "cacheManager")
	public void upVoteQuestion(int theId, int value) {
		questionDao.upVoteQuestion(theId, value);

	}

	@Override
	@CachePut(value = "questions", cacheManager = "cacheManager")
	public void downVoteQuestion(int theId, int value) {
		questionDao.downVoteQuestion(theId, value);

	}

	@Override
	@CachePut(value = "answers", cacheManager = "cacheManager")
	public void upVoteAnswer(int id, int value) {
		answerDao.upVoteAnswer(id, value);

	}

	@Override
	@CachePut(value = "answers", cacheManager = "cacheManager")
	public void downVoteAnswer(int id, int value) {
		answerDao.downVoteAnswer(id, value);

	}

	@Override
	@CachePut(value = "answers", cacheManager = "cacheManager")
	public void acceptAnswer(int id) {
		answerDao.acceptAnswer(id);

	}

	@Override
	@CacheEvict(value = "users", cacheManager = "cacheManager")
	public void deleteUser(int id) {
		userDao.deleteUser(id);

	}

	@Override
	public void changeUserAsGuest(int theId) throws IOException {
		userDao.changeUserAsGuest(theId);

	}

	@Override
	public List<Question> getQuestionListByUserId(int theId) {
		return questionDao.getAllQuestionsByUserId(theId);
	}

	@Override
	@Cacheable(value = "questions", cacheManager = "cacheManager")
	public List<Question> getTopQuestions(Integer offset, Integer maxResults) {
		return questionDao.getTopQuestions(offset, maxResults);
	}

	@Override
	public void upVoteUser(int qUserId, int value) {
		userDao.upVoteUser(qUserId, value);

	}

	@Override
	public void downVoteUser(int qUserId, int value) {
		userDao.downVoteUser(qUserId, value);

	}

	@Override
	public void updateUserAnswerCount(int responderId) {
		userDao.updateUserAnswerCount(responderId);

	}

	@Override
	public void updateUserQuestionCount(int userid) {
		userDao.updateUserQuestionCount(userid);

	}

	@Override
	@CacheEvict(value = "questions", cacheManager = "cacheManager")
	public void deleteQuestion(int theId) {
		questionDao.deleteQuestion(theId);
	}

	@Override
	@CacheEvict(value = "answers", cacheManager = "cacheManager")
	public void deleteAnswerByQuestionId(int questionId) {
		answerDao.deleteAnswerByQuestionId(questionId);

	}

	@Override
	public void deleteQcommentByQuestionId(int questionId) {
		questionCommentDao.deleteQcommentByQuestionId(questionId);

	}

	@Override
	public void deleteAcommentByAnswerId(int answerId) {
		answerCommentDao.deleteAcommentByAnswerId(answerId);

	}

	@Override
	@CacheEvict(value = "answers", cacheManager = "cacheManager")
	public void deleteAnswerById(int answerId) {
		answerDao.deleteAnswerById(answerId);

	}

	@Override
	public void changeQuestionAsGuess(int id) {
		questionDao.changeQuestionAsGuess(id);

	}

	@Override
	public void changeAnswerAsGuess(int id) {
		answerDao.changeAnswerAsGuess(id);

	}

	@Override
	public void setUUIDofUser(int Id, String uuid, String expirationDate) {
		userDao.setUUIDofUser(Id, uuid, expirationDate);

	}

	@Override
	public void setQuestionUnAnswered(int id) {
		questionDao.setQuestionUnAnswered(id);

	}

	@Override
	@CacheEvict(value = "favorities", cacheManager = "cacheManager")
	public void deleteFavorite(int userId, int questionId) {
		favoritiesDao.deleteFavorite(userId, questionId);

	}

	@Override
	@CachePut(value = "favorities", cacheManager = "cacheManager")
	public void saveFavorite(Favorities favorities) {
		favoritiesDao.saveFavorite(favorities);

	}

	@Override
	@Cacheable(value = "favorities", cacheManager = "cacheManager")
	public List<Favorities> getFavoriteList(int userId) {
		return favoritiesDao.getFavoriteList(userId);
	}

	@Override
	@CachePut(value = "users", cacheManager = "cacheManager")
	public void updateUser(Users users) {
		userDao.updateUser(users);

	}

	@Override
	public Optional<Users> findUserByEmailOptional(String theEmail) {
		return userDao.findUserByEmailOptional(theEmail);
	}

	@Override
	@CacheEvict(value = "favorities", cacheManager = "cacheManager")
	public void deleteFavoriteByQuestionId(int theId) {
		favoritiesDao.deleteFavoriteByQuestionId(theId);

	}

	@Override
	public void saveUserComment(UserComment userComment) {
		commentDAO.saveUserComment(userComment);

	}

	@Override
	public Long getQuestionCount() {
		return questionDao.getQuestionsCount();
	}

	@Override
	public void addAnswerVote(AnswerVote answerVote) {
		answerVoteDao.addAnswerVote(answerVote);

	}

	@Override
	public int checkTheAnswerVoteIsThere(int userId, int answerId) {
		return answerVoteDao.checkTheAnswerVoteIsThere(userId, answerId);
	}

	@Override
	public void addQuestionVote(QuestionVote questionVote) {
		questionVoteDao.addQuestionVote(questionVote);

	}

	@Override
	public int checkTheQuestionVoteIsThere(int userId, int questionId) {
		return questionVoteDao.checkTheQuestionVoteIsThere(userId, questionId);
	}

	@Override
	@CachePut(value = "questions", cacheManager = "cacheManager")
	public void updateQuestionVote(int currentUserId, int questionId, int voteVal) {
		questionVoteDao.updateQuestionVote(currentUserId, questionId, voteVal);

	}

	@Override
	@CachePut(value = "answers", cacheManager = "cacheManager")
	public void updateAnswerVote(int currentUserId, int answerId, int voteVal) {
		answerVoteDao.updateAnswerVote(currentUserId, answerId, voteVal);

	}

	@Override
	@Cacheable(value="usersMessages", cacheManager="cacheManager")
	public List<UserMessages> fetchUserMessageList(int userId) {
		return userMessagesDao.fetchUserMessageList(userId);
	}

	@Override
	@CachePut(value="usersMessages", cacheManager="cacheManager")
	public void sendMessageToUser(UserMessages message) {
		userMessagesDao.sendMessageToUser(message);
	}

	@Override
	@CachePut(value="usersMessages", cacheManager="cacheManager")
	public boolean setUserMessageAsReadById(int messageId) {
		return userMessagesDao.setMessageAsReadById(messageId);
	}

	@Override
	public UserMessages findUserMessageById(int messageId) {
		return userMessagesDao.findUserMessageById(messageId);
	}

}
