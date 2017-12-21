package com.community.web.dao;

import java.util.List;

import com.community.web.entity.Acomment;

public interface AcommentDAO {

	public Acomment getCommentById(int theId);
	
	public List<Acomment> getAllComments();
		
	public void save(Acomment acomment);

	public List<Acomment> getAllCommentsbyId(int answerId);

	public void deleteAcommentByAnswerId(int answerId);
}
