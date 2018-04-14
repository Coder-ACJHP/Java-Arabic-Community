package com.community.web.dao;

import com.community.web.entity.AnswerVote;

public interface AnswerVoteDao {

	public void addAnswerVote(AnswerVote answerVote);

	int checkTheAnswerVoteIsThere(int userId, int answerId);

	public void updateAnswerVote(int currentUserId, int answerId, int voteVal);

}
