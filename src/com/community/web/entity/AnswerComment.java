package com.community.web.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="AnswerComment")
public class AnswerComment {

	@Id
	@Column(name="ID")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int ID;
	
	@Column(name="ANSWERID")
	private int ANSWERID;
	
	@Column(name="USERNICKNAME")
	private String USERNICKNAME;

	@Column(name="COMMENT")
	private String COMMENT;
	
	@Column(name="CREATIONDATE")
	private String CREATIONDATE = LocalDateTime.now().toString();
	
	public AnswerComment() {}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getANSWERID() {
		return ANSWERID;
	}

	public void setANSWERID(int aNSWERID) {
		ANSWERID = aNSWERID;
	}

	public String getUSERNICKNAME() {
		return USERNICKNAME;
	}

	public void setUSERNICKNAME(String uSERNICKNAME) {
		USERNICKNAME = uSERNICKNAME;
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
	public String toString() {
		return "Acomment [ID=" + ID + ", ANSWERID=" + ANSWERID + ", USERNICKNAME=" + USERNICKNAME + ", COMMENT="
				+ COMMENT + ", CREATIONDATE=" + CREATIONDATE + "]";
	}
	
}




