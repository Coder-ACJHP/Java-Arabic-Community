package com.community.web.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Ucomment")
public class Ucomment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="ID")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int ID;
	
	@Column(name="USERID")
	private int USERID;
	
	@Column(name="COMMENTEDBY")
	private String COMMENTEDBY;
	
	@Column(name="COMMENT")
	private String COMMENT;
	
	@Column(name="CREATIONDATE")
	private String CREATIONDATE;
	
	public Ucomment() {
		// TODO Auto-generated constructor stub
	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getUSERID() {
		return USERID;
	}

	public void setUSERID(int uSERID) {
		USERID = uSERID;
	}

	public String getCOMMENTEDBY() {
		return COMMENTEDBY;
	}

	public void setCOMMENTEDBY(String cOMMENTEDBY) {
		COMMENTEDBY = cOMMENTEDBY;
	}

	public String getCOMMENT() {
		return COMMENT;
	}

	public void setCOMMENT(String cOMMENT) {
		COMMENT = cOMMENT;
	}

	public String getCREATIONDATE() {
		return CREATIONDATE;
	}

	public void setCREATIONDATE(String cREATIONDATE) {
		CREATIONDATE = cREATIONDATE;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((COMMENT == null) ? 0 : COMMENT.hashCode());
		result = prime * result + ((COMMENTEDBY == null) ? 0 : COMMENTEDBY.hashCode());
		result = prime * result + ((CREATIONDATE == null) ? 0 : CREATIONDATE.hashCode());
		result = prime * result + ID;
		result = prime * result + USERID;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Ucomment other = (Ucomment) obj;
		if (COMMENT == null) {
			if (other.COMMENT != null)
				return false;
		} else if (!COMMENT.equals(other.COMMENT))
			return false;
		if (COMMENTEDBY == null) {
			if (other.COMMENTEDBY != null)
				return false;
		} else if (!COMMENTEDBY.equals(other.COMMENTEDBY))
			return false;
		if (CREATIONDATE == null) {
			if (other.CREATIONDATE != null)
				return false;
		} else if (!CREATIONDATE.equals(other.CREATIONDATE))
			return false;
		if (ID != other.ID)
			return false;
		if (USERID != other.USERID)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Ucomment [ID=" + ID + ", USERID=" + USERID + ", COMMENTEDBY=" + COMMENTEDBY + ", COMMENT=" + COMMENT
				+ ", CREATIONDATE=" + CREATIONDATE + "]";
	}

	public Ucomment(int iD, int uSERID, String cOMMENTEDBY, String cOMMENT, String cREATIONDATE) {
		super();
		ID = iD;
		USERID = uSERID;
		COMMENTEDBY = cOMMENTEDBY;
		COMMENT = cOMMENT;
		CREATIONDATE = cREATIONDATE;
	}

	
}
