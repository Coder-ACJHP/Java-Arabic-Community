package com.community.web.dao;

import java.util.List;

import com.community.web.entity.QuestionComment;

public interface QuestionCommentDao {

	public QuestionComment getCommentById(int theId);

	public List<QuestionComment> getAllComments();

	public List<QuestionComment> getAllCommentsById(int questionsId);

	public void save(QuestionComment questionComment);

	public void deleteQcommentByQuestionId(int questionId);

}