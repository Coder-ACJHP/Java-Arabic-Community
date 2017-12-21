package com.community.web.dao;

import java.util.List;

import com.community.web.entity.Answer;

public interface AnswerDAO {

	public Answer getAnswersById(int theId);

	public List<Answer> getAllAnswers(int questionsId);

	public void saveAnswer(Answer answer);

	public List<Answer> getAllAnswers();

	public void upVoteAnswer(int id, int value);

	public void downVoteAnswer(int id, int value);

	public void acceptAnswer(int id);

	public void deleteAnswerByQuestionId(int id);

	public void deleteAnswerById(int answerId);

	public void changeAnswerAsGuess(int id);
}
