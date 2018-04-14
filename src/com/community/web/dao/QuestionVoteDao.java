package com.community.web.dao;

import com.community.web.entity.QuestionVote;

public interface QuestionVoteDao {

	public void addQuestionVote(QuestionVote questionVote);

	int checkTheQuestionVoteIsThere(int userId, int questionId);

	public void updateQuestionVote(int currentUserId, int questionId, int voteVal);
}