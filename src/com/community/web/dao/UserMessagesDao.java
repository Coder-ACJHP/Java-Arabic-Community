
package com.community.web.dao;

import java.util.List;

import com.community.web.entity.UserMessages;

public interface UserMessagesDao {

	public List<UserMessages> fetchUserMessageList(int userId);

	public void sendMessageToUser(UserMessages message);

	public boolean setMessageAsReadById(int messageId);

	public UserMessages findUserMessageById(int messageId);
}