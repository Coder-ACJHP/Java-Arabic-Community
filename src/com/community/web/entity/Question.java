package com.community.web.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Type;
import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="Questions")
public class Question {

	@Id
	@Column(name="ID")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int ID;
	
	@NotNull
	@Column(name="USERID")
	private int USERID;
	
	@NotEmpty(message="Question is required!")
	@Column(name="QUESTIONS")
	private String QUESTIONS;
	
	@NotEmpty(message="Question detail is required!")
	@Column(name="QEXPLAIN")
	private String QEXPLAIN;
	
	@NotEmpty(message="Question tags are required!")
	@Column(name="TAGS")
	private String TAGS;
	
	@Column(name="CREATIONDATE")
	private String CREATIONDATE = LocalDateTime.now().toString();
	
	@Column(name="ISANSWERED", nullable=false, columnDefinition="TINYINT")
	@Type(type="org.hibernate.type.NumericBooleanType")
	private boolean ISANSWERED;
	
	@Column(name="VOTE")
	private int VOTE;
	
	public Question() {
		
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

	public String getQUESTIONS() {
		return QUESTIONS;
	}

	public void setQUESTIONS(String qUESTIONS) {
		QUESTIONS = qUESTIONS;
	}

	public String getQEXPLAIN() {
		return QEXPLAIN;
	}

	public void setQEXPLAIN(String qEXPLAIN) {
		QEXPLAIN = qEXPLAIN;
	}

	public String getTAGS() {
		return TAGS;
	}

	public void setTAGS(String tAGS) {
		TAGS = tAGS;
	}

	public String getCREATIONDATE() {
		return CREATIONDATE;
	}

	public void setCREATIONDATE(String cREATIONDATE) {
		CREATIONDATE = cREATIONDATE;
	}

	public boolean isISANSWERED() {
		return ISANSWERED;
	}

	public void setISANSWERED(boolean iSANSWERED) {
		ISANSWERED = iSANSWERED;
	}

	public int getVOTE() {
		return VOTE;
	}

	public void setVOTE(int vOTE) {
		VOTE = vOTE;
	}

	@Override
	public String toString() {
		return "Question [ID=" + ID + ", USERID=" + USERID + ", QUESTIONS=" + QUESTIONS + ", QEXPLAIN=" + QEXPLAIN
				+ ", TAGS=" + TAGS + ", CREATIONDATE=" + CREATIONDATE + ", ISANSWERED=" + ISANSWERED + ", VOTE=" + VOTE
				+ "]";
	}
	
}