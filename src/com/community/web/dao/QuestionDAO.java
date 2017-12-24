package com.community.web.dao;

import java.util.List;

import com.community.web.entity.Question;

public interface QuestionDAO {

	public Question getQuestion(int theId);
	
	public List<Question> getAllQuestions();

	public List<Question> searchQuestions(String searchName);

	public void save(Question question);

	public List<Question> getAllQuestionsByLimit(Integer pageId, Integer mAXIMUMPAGES);

	public void setQuestionIsAnswered(int Id);

	public void upVoteQuestion(int theId, int value);

	public void downVoteQuestion(int theId, int value);

	public List<Question> getAllQuestionsByUserId(int theId);

	public void deleteQuestion(int theId);

	public void changeQuestionAsGuess(int id);

	public List<Question> getTopQuestions();

	public void setQuestionUnAnswered(int id);
}
