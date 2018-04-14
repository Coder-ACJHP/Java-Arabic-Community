package com.community.web.util;

public class AccountConfirmationMessage {

	public String getMessageBody(int userId, String token) {

		String message = "<div align=\"center\"><h1>Welcome to Java Arabic Community!</h1>"
				+ "<p>To activate your account, you must click on the following button.</p>" + "<div><!--[if mso]>"
				+ "  <v:roundrect xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"urn:schemas-microsoft-com:office:word\" href=\"https://java-arabic-community.herokuapp.com/RegistrationConfirm?UserId=\"+userId+\"&Token=\"+token+\"\" style=\"height:40px;v-text-anchor:middle;width:200px;\" arcsize=\"10%\" strokecolor=\"#1e3650\" fillcolor=\"#556270\">"
				+ "    <w:anchorlock/>"
				+ "    <center style=\"color:#ffffff;font-family:sans-serif;font-size:13px;font-weight:bold;\">Active my account</center>"
				+ "  </v:roundrect>"
				+ "<![endif]--><a href=\"https://java-arabic-community.herokuapp.com/RegistrationConfirm?UserId="
				+ userId + "&Token=" + token + "\""
				+ "style=\"background-color:#556270;border:1px solid #1e3650;border-radius:4px;color:#ffffff;display:inline-block;font-family:sans-serif;font-size:13px;font-weight:bold;line-height:40px;text-align:center;text-decoration:none;width:200px;-webkit-text-size-adjust:none;mso-hide:all;\">Active my account</a></div><br><br>Written by <a href='mailto:onur.isik@codeforiraq.org'>"
				+ "  J.A.C team</a><br>Best regards. </div>";

		return message;
	}

}
