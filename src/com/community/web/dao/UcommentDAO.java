package com.community.web.dao;

import java.util.List;

import com.community.web.entity.Ucomment;

public interface UcommentDAO {

	public Ucomment getUserCommentById(int Id);
	
	public Ucomment getUserCommentByOwnerId(int ownerId);
	
	public List<Ucomment> getAllCommentsById(int ownerId);
	
	public void saveUserComment(Ucomment ucomment);
	
	public void deleteUserCommentById(int commentId);
}
