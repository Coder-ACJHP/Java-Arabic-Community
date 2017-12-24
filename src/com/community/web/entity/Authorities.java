package com.community.web.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Authorities")
public class Authorities implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="EMAIL")
	private String Email;
	
	@Column(name="AUTHORITY")
	private String Authority;
	
	public Authorities() {}

	public String getEmail() {
		return Email;
	}

	public void setEmail(String email) {
		Email = email;
	}

	public String getAuthority() {
		return Authority;
	}

	public void setAuthority(String authority) {
		Authority = authority;
	}

	@Override
	public String toString() {
		return "Authorities [Email=" + Email + ", Authority=" + Authority + "]";
	}

	public Authorities(String email, String authority) {
		super();
		Email = email;
		Authority = authority;
	}

}
