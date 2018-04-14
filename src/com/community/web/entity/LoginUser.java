package com.community.web.entity;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;

public class LoginUser implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Size(min=2, max=30)
	@Email(regexp="^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$", message="Invalid email!")
	@NotNull(message="Email cannot be empty!")
	private String email;
	
	@Size(min=2, max=30)
	@NotNull(message="Password cannot be empty!")
	private String password;
	
	public LoginUser() {}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public LoginUser(String email, String password) {
		this.email = email;
		this.password = password;
	}
	
	
}
