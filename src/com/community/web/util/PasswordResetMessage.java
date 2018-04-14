package com.community.web.util;

public class PasswordResetMessage {

	public String getMessageBody(String nickname, String UUID, int ID) {
	
		return "<h4>Hi "+ nickname +"</h4><p>It seems like you lost your"
				+ " password, please copy the following private unique key "
				+ "and go to following link to renew your password. <label "
				+ "style='color:red;'>Remember this key will expire in 6 "
				+ "hour.</label></p><br>Your key is : <code title='Copy Me!'>" 
				+ UUID + "</code><br><a href='https://java-arabic-community.herokuapp.com/Resetpassword?userId="
				+ ID + "'>Reset password link</a><h4>Best regards<br>Java Arabic Community Team</h4>";
	}
}
