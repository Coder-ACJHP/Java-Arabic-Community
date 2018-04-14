package com.community.web.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="AnswerVote")
public class AnswerVote implements Serializable {

	/**
	 * 
	 */
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="Id")
	private int Id;
	
	@Column(name="Users_Id")
	private int Users_Id;
	
	@Column(name="Answer_Id")
	private int Answer_Id;
	
	@Column(name="Vote")
	private int Vote;
	
	private static final long serialVersionUID = 1L;

	public AnswerVote() {}

	public AnswerVote(int users_Id, int answer_Id, int vote) {
		Users_Id = users_Id;
		Answer_Id = answer_Id;
		Vote = vote;
	}

	public AnswerVote(int id, int users_Id, int answer_Id, int vote) {
		Id = id;
		Users_Id = users_Id;
		Answer_Id = answer_Id;
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

	public int getAnswer_Id() {
		return Answer_Id;
	}

	public void setAnswer_Id(int answer_Id) {
		Answer_Id = answer_Id;
	}

	public int getVote() {
		return Vote;
	}

	public void setVote(int vote) {
		Vote = vote;
	}
	
	@Override
	public String toString() {
		return "AnswerVote [Id=" + Id + ", Users_Id=" + Users_Id + ", Answer_Id=" + Answer_Id + ", Vote=" + Vote + "]";
	}	

}
