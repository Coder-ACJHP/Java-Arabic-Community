package com.community.web.util;

public class PasswordResetMessage {

	public String getMessageBody(String nickname, String UUID, int ID) {
	
		return "<h4>Hi "+ nickname+"</h4><br><p>It seems like you lost your password, please "
			    + "copy the private unique key : " +UUID+
				"<br>and go to following link to renew your password <a title='Copy me!' "
				+ "href='https://java-arabic-community.herokuapp.com/Resetpassword?userId="+ID+"'>"
						+ " from here</a></p><br><br><h4>Best "
				+ "regards<br>Java Arabic Community Team</h4>";
	}
}
