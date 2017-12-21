package com.community.web.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MysqlTableRelationship {

	private static final String user = "onur";
	private static final String pwd = "onurdb958";
	private static final String host = "jdbc:mysql://localhost/java_arabic_community";
	private static final String driver = "com.mysql.jdbc.Driver";

	public static void main(String[] args) {

		try {
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(host,user,pwd); 
			if(conn != null)
				System.out.println("Connected successfully..");
			
			String SQL = "SELECT * FROM `Users` INNER JOIN Questions ON Users.ID = Questions.USERID "
					+ "INNER JOIN Answers ON Questions.ID = Answers.QUESTIONSID";
//			
//			String SQL1 = "SELECT `NICKNAME`, `EMAIL`, Authorities.AUTHORITIES FROM `Users` INNER JOIN "
//					+ "Authorities ON Users.ID = Authorities.USERID";
			
			PreparedStatement ps = conn.prepareStatement(SQL);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				System.out.println(rs.getInt("ID"));
				System.out.println(rs.getString("FIRSTNAME"));
				System.out.println(rs.getString("LASTNAME"));
				System.out.println(rs.getString("QUESTIONS"));
				System.out.println(rs.getString("Q_EXPLAIN"));
				System.out.println(rs.getString("ANSWER"));

			}
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} 
	}

}
