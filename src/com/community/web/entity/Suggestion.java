package com.community.web.entity;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;

public class Suggestion {
	
	/**
	 * 	@Email(regexp="^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$", message="Invalid email!")

	 */
	
	@Size(min=2, max=30)
	@NotNull(message="Email cannot be empty!")
	private String name;
	
	@Size(min=2, max=30)
	@Email(regexp="^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$", message="Invalid email!")
	@NotNull(message="Email cannot be empty!")
	private String email;
	
	@Size(min=2, max=30)
	@NotNull(message="Select one of the countries.")
	private String country;
	
	@Size(min=2, max=30)
	@NotNull(message="Category cannot be empty!")
	private String category;
	
	@Size(min=1, max=500)
	@NotNull(message="Subject cannot be empty!")
	private String subject;
	
	@Size(min=1, max=5000)
	@NotNull(message="Message cannot be empty!")
	private String message;
	
	public Suggestion() {
		
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


	@Override
	public String toString() {
		return "Suggestion [name=" + name + ", email=" + email + ", country=" + country + ", category=" + category
				+ ", subject=" + subject + ", message=" + message + "]";
	}

}
