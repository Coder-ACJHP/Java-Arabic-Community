package com.community.web.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class ConnectionTestInServlet
 */
@WebServlet("/ConnectionTestInServlet")
public class ConnectionTestInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String user = "jciespjmxweisx";
	private static final String pwd = "c2c53a3502eb945d2513aac2bf2264a65875978ad22b158c72e729cf042c7f48";
	private static final String driver = "org.postgresql.Driver";
	private static final String host = "jdbc:postgre://ec2-54-235-153-124.compute-1.amazonaws.com:5432/d1mg6th1cb69la";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ConnectionTestInServlet() {
		super();

		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter printWriter = response.getWriter();
		
		try {

			Class.forName(driver);
			Connection connection = DriverManager.getConnection(host, user, pwd);

			if (connection != null) {
				System.out.println("Connected successfully well done.");
				File file = new File("/Users/MacbookPro/Pictures/GoogleImg.jpg");
				FileInputStream fileInputStream = new FileInputStream(file);
				String SQL = "UPDATE `Users` SET `PICTURE`=? WHERE ID=?";
				PreparedStatement preparedStatement = connection.prepareStatement(SQL);
				preparedStatement.setBinaryStream(1, fileInputStream, file.length());
				preparedStatement.setInt(2, 2);
				preparedStatement.executeUpdate();
				printWriter.println("Connected successfully well done.");
			}

		} catch (ClassNotFoundException | SQLException e) {
			printWriter.print(e.getMessage());
			e.printStackTrace();
		}

	}

}
