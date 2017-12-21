package com.community.web.test;

import java.io.IOException;

import org.jasypt.digest.PooledStringDigester;

public class PasswordEncrytor {


	public boolean checkPassword(String inputPassword, String dbPassword) {
		boolean isMatch = false;
		PooledStringDigester degister = new PooledStringDigester();
		degister.setPoolSize(4);
		degister.setAlgorithm("SHA-1");
		degister.setIterations(50000);

		String digest = degister.digest(dbPassword);
		System.out.println(digest);
		if (degister.matches(inputPassword, digest)) {
			isMatch = true;
		} else {
			isMatch = false;
		}
		
		return isMatch;
	}
	
	public static void main(String[] args) throws IOException {
		PooledStringDigester digester = new PooledStringDigester();
		digester.setPoolSize(4);          // This would be a good value for a 4-core system 
		digester.setAlgorithm("SHA-1");
		digester.setIterations(50000);
		String digest = digester.digest("fQvXtwO360oY2lugc4Z1dTtBQuNwn+2QLftvkA==");
		if (digester.matches("admin", digest)) {
			System.out.println("cevap TRUE");
			} else {
				System.out.println("cevap FALSE");
			}
		
		
	}
	
}
