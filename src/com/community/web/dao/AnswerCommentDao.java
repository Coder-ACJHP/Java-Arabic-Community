package com.community.web.dao;

import java.util.List;

import com.community.web.entity.AnswerComment;

public interface AnswerCommentDao {

	public AnswerComment getCommentById(int theId);

	public List<AnswerComment> getAllComments();

	public void save(AnswerComment answerComment);

	public List<AnswerComment> getAllCommentsbyId(int answerId);

	public void deleteAcommentByAnswerId(int answerId);
}
