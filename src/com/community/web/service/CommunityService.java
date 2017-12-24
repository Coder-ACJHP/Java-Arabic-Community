package com.community.web.service;

import java.io.IOException;
import java.util.List;

import com.community.web.entity.Acomment;
import com.community.web.entity.Answer;
import com.community.web.entity.Qcomment;
import com.community.web.entity.Question;
import com.community.web.entity.Ucomment;
import com.community.web.entity.Users;

public interface CommunityService {

	public Users getUserById(int theId);

	public Users getUserByEmail(String email);

	public Qcomment getCommentById(int theId);

	public Question getQuestionById(int theId);

	public Answer getAnswerById(int theId);

	public Acomment getAcommentbyId(int theId);

	public List<Users> getUserList();

	public List<Acomment> getCommentList();

	public List<Question> getQuestionsList();

	public List<Answer> getAnswersList(int questionsId);

	public List<Qcomment> getCommentList(int questionsId);

	public List<Acomment> getAcommentList(int answerId);

	public List<Question> searchQuestion(String searchName);

	public List<Question> getQuestionsListByLimit(Integer pageId, Integer mAXIMUMPAGES);

	public void saveUser(Users users);

	public void saveAnswer(Answer answer);

	public void saveQuestion(Question question);

	public void saveQcomment(Qcomment qcomment);

	public void saveAcomment(Acomment acomment);

	public void setQuestionIsAnswered(int id);

	public List<Answer> getAnswersList();

	public List<Users> searchUser(String searchName);

	public void upVoteQuestion(int theId, int value);

	public void downVoteQuestion(int theId, int value);

	public void upVoteAnswer(int id, int value);

	public void downVoteAnswer(int id, int value);

	public void acceptAnswer(int id);

	public void updateUserPassword(int theId, String newPsw);

	public void deleteUser(int id);

	public void changeUserAsGuest(int theId) throws IOException;

	public List<Question> getQuestionListByUserId(int theId);

	public void upVoteUser(int qUserId, int value);

	public void downVoteUser(int qUserId, int value);

	public void updateUserAnswerCount(int responderId);

	public void updateUserQuestionCount(int userid);

	public void deleteQuestion(int theId);

	public void deleteAnswerByQuestionId(int questionId);

	public void deleteQcommentByQuestionId(int questionId);

	public void deleteAcommentByAnswerId(int answerId);

	public void deleteAnswerById(int id);

	public void changeQuestionAsGuess(int id);

	public void changeAnswerAsGuess(int id);

	public List<Question> getTopQuestions();

	public void setUUIDofUser(int Id, String string);
	
	public Ucomment getUserCommentById(int Id);
	
	public Ucomment getUserCommentByOwnerId(int ownerId);
	
	public List<Ucomment> getAllCommentsById(int ownerId);
	
	public void saveUserComment(Ucomment ucomment);
	
	public void deleteUserCommentById(int commentId);

}
