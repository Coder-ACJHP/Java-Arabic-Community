package com.community.web.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.community.web.dao.AcommentDAO;
import com.community.web.dao.AnswerDAO;
import com.community.web.dao.QcommentDAO;
import com.community.web.dao.QuestionDAO;
import com.community.web.dao.UcommentDAO;
import com.community.web.dao.UserDAO;
import com.community.web.entity.Acomment;
import com.community.web.entity.Answer;
import com.community.web.entity.Qcomment;
import com.community.web.entity.Question;
import com.community.web.entity.Ucomment;
import com.community.web.entity.Users;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private QuestionDAO questionDAO;
	
	@Autowired
	private AnswerDAO answerDAO;
	
	@Autowired 
	private QcommentDAO qcommentDAO;
	
	@Autowired
	private AcommentDAO acommentDAO;
	
	@Autowired
	private UcommentDAO ucommentDAO;
	
	@Override
	@Transactional
	public Users getUserById(int theId) {
		Users users = userDAO.getUser(theId);
		return users;
	}

	@Override
	@Transactional
	public List<Users> getUserList() {
		List<Users> userList = userDAO.getUserList();
		return userList;
	}

	@Override
	@Transactional
	public List<Users> searchUser(String searchName) {
		List<Users> foundUserList = userDAO.searchUser(searchName);
		return foundUserList;
	}
	
	@Override
	@Transactional
	public Question getQuestionById(int theId) {
		Question question = questionDAO.getQuestion(theId);
		return question;
	}

	@Override
	@Transactional
	public List<Question> getQuestionsList() {
		List<Question> questionsList = questionDAO.getAllQuestions();
		return questionsList;
	}

	@Override
	@Transactional
	public List<Question> getQuestionsListByLimit(Integer pageId, Integer mAXIMUMPAGES) {
		List<Question> limitedQuestionList = questionDAO.getAllQuestionsByLimit(pageId, mAXIMUMPAGES);
		return limitedQuestionList;
	}
	
	@Override
	@Transactional
	public Answer getAnswerById(int theId) {
		Answer answer = answerDAO.getAnswersById(theId);
		return answer;
	}

	@Override
	@Transactional
	public List<Answer> getAnswersList(int questionsId) {
		List<Answer> answersList = answerDAO.getAllAnswers(questionsId);
		return answersList;
	}

	@Override
	@Transactional
	public Users getUserByEmail(String email) {
		Users users = userDAO.getUserByEmail(email);
		return users;
	}

	@Override
	@Transactional
	public List<Question> searchQuestion(String searchName) {
		
		return questionDAO.searchQuestions(searchName);
	}

	@Override
	@Transactional
	public Qcomment getCommentById(int theId) {
		Qcomment Qcomment = qcommentDAO.getCommentById(theId);
		return Qcomment;
	}

	@Override
	@Transactional
	public List<Qcomment> getCommentList(int questionsId) {
		List<Qcomment> commentsList = qcommentDAO.getAllCommentsById(questionsId);
		return commentsList;
	}

	@Override
	@Transactional
	public Acomment getAcommentbyId(int theId) {
		Acomment acomment = acommentDAO.getCommentById(theId);
		return acomment;
	}

	@Override
	@Transactional
	public List<Acomment> getCommentList() {
		List<Acomment> answerCommentList = acommentDAO.getAllComments();
		return answerCommentList;
	}

	@Override
	@Transactional
	public List<Acomment> getAcommentList(int answerId) {
		List<Acomment> anAcomments = acommentDAO.getAllCommentsbyId(answerId);
		return anAcomments;
	}

	@Override
	@Transactional
	public void saveAcomment(Acomment acomment) {
		acommentDAO.save(acomment);
		
	}

	@Override
	@Transactional
	public void saveQcomment(Qcomment qcomment) {
		qcommentDAO.save(qcomment);
		
	}
	
	@Override
	@Transactional
	public void saveAnswer(Answer answer) {
		answerDAO.saveAnswer(answer);
		
	}

	@Override
	@Transactional
	public void saveUser(Users users) {
		userDAO.save(users);
		
	}
	
	@Override
	@Transactional
	public void saveQuestion(Question question) {
		questionDAO.save(question);
		
	}

	@Override
	@Transactional
	public void setQuestionIsAnswered(int id) {
		questionDAO.setQuestionIsAnswered(id);
		
	}

	@Override
	@Transactional
	public List<Answer> getAnswersList() {
		List<Answer> answerList = answerDAO.getAllAnswers();
		return answerList;
	}

	@Override
	@Transactional
	public void upVoteQuestion(int theId, int value) {
		questionDAO.upVoteQuestion(theId, value);
		
	}

	@Override
	@Transactional
	public void downVoteQuestion(int theId, int value) {
		questionDAO.downVoteQuestion(theId, value);
		
	}

	@Override
	@Transactional
	public void upVoteAnswer(int id, int value) {
		answerDAO.upVoteAnswer(id, value);
		
	}

	@Override
	@Transactional
	public void downVoteAnswer(int id, int value) {
		answerDAO.downVoteAnswer(id, value);
		
	}

	@Override
	@Transactional
	public void acceptAnswer(int id) {
		answerDAO.acceptAnswer(id);
		
	}

	@Override
	@Transactional
	public void updateUserPassword(int theId, String newPsw) {
		userDAO.updateUserPassword(theId, newPsw);
		
	}

	@Override
	@Transactional
	public void deleteUser(int id) {
		userDAO.deleteUser(id);
		
	}

	@Override
	@Transactional
	public void changeUserAsGuest(int theId) throws IOException {
		userDAO.changeUserAsGuest(theId);
		
	}

	@Override
	@Transactional
	public List<Question> getQuestionListByUserId(int theId) {
		List<Question> questionList = questionDAO.getAllQuestionsByUserId(theId);
		return questionList;
	}

	@Override
	@Transactional
	public List<Question> getTopQuestions() {
		List<Question> topQuestionslist = questionDAO.getTopQuestions();
		return topQuestionslist;
	}
	
	@Override
	@Transactional
	public void upVoteUser(int qUserId, int value) {
		userDAO.upVoteUser(qUserId, value);
		
	}

	@Override
	@Transactional
	public void downVoteUser(int qUserId, int value) {
		userDAO.downVoteUser(qUserId, value);
		
	}

	@Override
	@Transactional
	public void updateUserAnswerCount(int responderId) {
		userDAO.updateUserAnswerCount(responderId);
		
	}

	@Override
	@Transactional
	public void updateUserQuestionCount(int userid) {
		userDAO.updateUserQuestionCount(userid);
		
	}

	@Override
	@Transactional
	public void deleteQuestion(int theId) {
		questionDAO.deleteQuestion(theId);
		
	}

	@Override
	@Transactional
	public void deleteAnswerByQuestionId(int questionId) {
		answerDAO.deleteAnswerByQuestionId(questionId);
		
	}

	@Override
	@Transactional
	public void deleteQcommentByQuestionId(int questionId) {
		qcommentDAO.deleteQcommentByQuestionId(questionId);
		
	}

	@Override
	@Transactional
	public void deleteAcommentByAnswerId(int answerId) {
		acommentDAO.deleteAcommentByAnswerId(answerId);
		
	}

	@Override
	@Transactional
	public void deleteAnswerById(int answerId) {
		answerDAO.deleteAnswerById(answerId);
		
	}

	@Override
	@Transactional
	public void changeQuestionAsGuess(int id) {
		questionDAO.changeQuestionAsGuess(id);
		
	}

	@Override
	@Transactional
	public void changeAnswerAsGuess(int id) {
		answerDAO.changeAnswerAsGuess(id);
		
	}

	@Override
	@Transactional
	public void setUUIDofUser(int Id, String uuid) {
		userDAO.setUUIDofUser(Id, uuid);
		
	}

	@Override
	@Transactional
	public Ucomment getUserCommentById(int Id) {
		return ucommentDAO.getUserCommentById(Id);
	}

	@Override
	@Transactional
	public Ucomment getUserCommentByOwnerId(int ownerId) {
		return ucommentDAO.getUserCommentByOwnerId(ownerId);
	}

	@Override
	@Transactional
	public List<Ucomment> getAllCommentsById(int ownerId) {
		return ucommentDAO.getAllCommentsById(ownerId);
	}

	@Override
	@Transactional
	public void saveUserComment(Ucomment ucomment) {
		ucommentDAO.saveUserComment(ucomment);
	}

	@Override
	@Transactional
	public void deleteUserCommentById(int commentId) {
		ucommentDAO.deleteUserCommentById(commentId);
	}
	
}
