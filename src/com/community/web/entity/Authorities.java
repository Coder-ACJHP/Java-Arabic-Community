package com.community.web.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
	@Column(name="ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int ID;
	
	@Column(name="AUTHORITY", nullable=false)
	private String AUTHORITY;

	@Column(name="ENABLED", nullable=false)
	private boolean ENABLED;
	
	public Authorities() {}

	public Authorities(String aUTHORITY, boolean eNABLED) {
		AUTHORITY = aUTHORITY;
		ENABLED = eNABLED;
	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getAUTHORITY() {
		return AUTHORITY;
	}

	public void setAUTHORITY(String aUTHORITY) {
		AUTHORITY = aUTHORITY;
	}

	public boolean isENABLED() {
		return ENABLED;
	}

	public void setENABLED(boolean eNABLED) {
		ENABLED = eNABLED;
	}

	@Override
	public String toString() {
		return "Authority [ID=" + ID + ", AUTHORITY=" + AUTHORITY + ", ENABLED=" + ENABLED + "]";
	}
	
	
}
