package com.community.web.dao;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import com.community.web.entity.Users;

public interface UserDao {

	public Users getUser(int theId);

	public List<Users> getUserList();

	public Users getUserByEmail(String email);

	public void save(Users users);

	public List<Users> searchUser(String searchName);

	public void deleteUser(int id);

	public void changeUserAsGuest(int theId) throws IOException;

	public void upVoteUser(int qUserId, int value);

	public void downVoteUser(int qUserId, int value);

	public void updateUserAnswerCount(int responderId);

	public void updateUserQuestionCount(int userid);

	public void setUUIDofUser(int Id, String uuid, String expirationDate);

	public void updateUser(Users users);

	public Optional<Users> findUserByEmailOptional(String theEmail);

}