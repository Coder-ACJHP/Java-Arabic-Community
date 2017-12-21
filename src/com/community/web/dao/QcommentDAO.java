package com.community.web.dao;

import java.util.List;

import com.community.web.entity.Qcomment;

public interface QcommentDAO {

	public Qcomment getCommentById(int theId);
	
	public List<Qcomment> getAllComments();

	public List<Qcomment> getAllCommentsById(int questionsId);

	public void save(Qcomment qcomment);

	public void deleteQcommentByQuestionId(int questionId);  
	
	
}
