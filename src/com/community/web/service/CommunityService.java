package com.community.web.service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

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

public interface CommunityService {

	public Users getUserById(int theId);

	public Users getUserByEmail(String email);

	public QuestionComment getCommentById(int theId);

	public Question getQuestionById(int theId);

	public Answer getAnswerById(int theId);

	public AnswerComment getAcommentbyId(int theId);

	public List<Users> getUserList();

	public List<AnswerComment> getCommentList();

	public List<Question> getQuestionsList();

	public List<Answer> getAnswersList(int questionsId);

	public List<QuestionComment> getCommentList(int questionsId);

	public List<AnswerComment> getAcommentList(int answerId);

	public List<Question> searchQuestion(String searchName);

	public List<Question> getQuestionsListByLimit(Integer pageId, Integer mAXIMUMPAGES);

	public void saveUser(Users users);

	public void saveAnswer(Answer answer);

	public void saveQuestion(Question question);

	public void saveQcomment(QuestionComment questionComment);

	public void saveAcomment(AnswerComment answerComment);

	public void setQuestionIsAnswered(int id);

	public void saveUserComment(UserComment userComment);

	public List<Answer> getAnswersList();

	public List<Users> searchUser(String searchName);

	public void upVoteQuestion(int theId, int value);

	public void downVoteQuestion(int theId, int value);

	public void upVoteAnswer(int id, int value);

	public void downVoteAnswer(int id, int value);

	public void acceptAnswer(int id);

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

	public List<Question> getTopQuestions(Integer offset, Integer maxResults);

	public void setUUIDofUser(int Id, String string, String expirationDate);

	public void setQuestionUnAnswered(int id);

	public void deleteFavorite(int userId, int questionId);

	public void saveFavorite(Favorities favorities);

	public List<Favorities> getFavoriteList(int userId);

	public void updateUser(Users users);

	public Optional<Users> findUserByEmailOptional(String theEmail);

	public void deleteFavoriteByQuestionId(int theId);

	public Long getQuestionCount();

	public void addAnswerVote(AnswerVote answerVote);

	int checkTheAnswerVoteIsThere(int userId, int answerId);

	public void addQuestionVote(QuestionVote questionVote);

	int checkTheQuestionVoteIsThere(int userId, int questionId);

	public void updateQuestionVote(int currentUserId, int questionId, int voteVal);
	
	public void updateAnswerVote(int currentUserId, int answerId, int voteVal);

	public List<UserMessages> fetchUserMessageList(int userId);

	public void sendMessageToUser(UserMessages message);

	public boolean setUserMessageAsReadById(int messageId);

	public UserMessages findUserMessageById(int messageId);


}
