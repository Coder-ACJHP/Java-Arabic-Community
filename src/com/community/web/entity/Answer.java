package com.community.web.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

@Entity
@Table(name="Answers")
public class Answer {

	@Id
	@Column(name="ID")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int ID;
	
	@Column(name="QUESTIONSID")
	private int QUESTIONSID;
	
	@Column(name="ANSWER")
	private String ANSWER;
	
	@Column(name="USERID")
	private int USERID;
	
	@Column(name="CREATIONDATE")
	private String CREATIONDATE;
	
	@Column(name="ISACCEPTED", nullable=false, columnDefinition="TINYINT")
	@Type(type="org.hibernate.type.NumericBooleanType")
	private boolean ISACCEPTED;
	
	@Column(name="VOTE")
	private int VOTE;
	
	public Answer() {
		
	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getQUESTIONSID() {
		return QUESTIONSID;
	}

	public void setQUESTIONSID(int qUESTIONSID) {
		QUESTIONSID = qUESTIONSID;
	}

	public String getANSWER() {
		return ANSWER;
	}

	public void setANSWER(String aNSWER) {
		ANSWER = aNSWER;
	}

	public int getUSERID() {
		return USERID;
	}

	public void setUSERID(int uSERID) {
		USERID = uSERID;
	}

	public String getCREATIONDATE() {
		return CREATIONDATE;
	}

	public void setCREATIONDATE(String cREATIONDATE) {
		CREATIONDATE = cREATIONDATE;
	}

	public boolean isISACCEPTED() {
		return ISACCEPTED;
	}

	public void setISACCEPTED(boolean iSACCEPTED) {
		ISACCEPTED = iSACCEPTED;
	}

	public int getVOTE() {
		return VOTE;
	}

	public void setVOTE(int vOTE) {
		VOTE = vOTE;
	}

	@Override
	public String toString() {
		return "Answer [ID=" + ID + ", QUESTIONSID=" + QUESTIONSID + ", ANSWER=" + ANSWER + ", USERID=" + USERID
				+ ", CREATIONDATE=" + CREATIONDATE + ", ISACCEPTED=" + ISACCEPTED + ", VOTE=" + VOTE + "]";
	}

}





