package com.community.web.dao;

import java.util.List;

import com.community.web.entity.Favorities;

public interface FavoritiesDao {

	public void deleteFavorite(int userId, int questionId);

	public void saveFavorite(Favorities favorities);

	public List<Favorities> getFavoriteList(int userId);

	public void deleteFavoriteByQuestionId(int theId);

}