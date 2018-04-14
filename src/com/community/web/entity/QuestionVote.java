package com.community.web.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="QuestionVote")
public class QuestionVote implements Serializable {

	/**
	 * 
	 */
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="Id")
	private int Id;
	
	@Column(name="Users_Id")
	private int Users_Id;
	
	@Column(name="Question_Id")
	private int Question_Id;
	
	@Column(name="Vote")
	private int Vote;
	
	private static final long serialVersionUID = 1L;

	public QuestionVote() {}

	public QuestionVote(int users_Id, int question_Id, int vote) {
		Users_Id = users_Id;
		Question_Id = question_Id;
		Vote = vote;
	}
	
	public QuestionVote(int id, int users_Id, int question_Id, int vote) {
		Id = id;
		Users_Id = users_Id;
		Question_Id = question_Id;
		Vote = vote;
	}

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public int getUsers_Id() {
		return Users_Id;
	}

	public void setUsers_Id(int users_Id) {
		Users_Id = users_Id;
	}

	public int getQuestion_Id() {
		return Question_Id;
	}

	public void setQuestion_Id(int question_Id) {
		Question_Id = question_Id;
	}

	public int getVote() {
		return Vote;
	}

	public void setVote(int vote) {
		Vote = vote;
	}

	@Override
	public String toString() {
		return "QuestionVote [Id=" + Id + ", Users_Id=" + Users_Id + ", Question_Id=" + Question_Id + ", Vote=" + Vote
				+ "]";
	}
	

}
