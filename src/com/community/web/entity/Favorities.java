package com.community.web.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="Favorities")
public class Favorities implements Serializable {

	/**
	 * 
	 */
	@Id
	@Column(name="ID")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int Id;
	
	@Column(name="FAVQID", nullable=true)
	private int FavQuestionId;
	
	@ManyToOne(cascade= {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.DETACH, CascadeType.REFRESH})
	@JoinColumn(name="Users_Id")
	private Users users;
	
	private static final long serialVersionUID = 1L;
	
	public Favorities() {}

	public Favorities(int favQuestionId) {
		FavQuestionId = favQuestionId;
	}

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public int getFavQuestionId() {
		return FavQuestionId;
	}

	public void setFavQuestionId(int favQuestionId) {
		FavQuestionId = favQuestionId;
	}

	public Users getUsers() {
		return users;
	}
	
	public void setUsers(Users users) {
		this.users = users;
	}

	@Override
	public String toString() {
		return "Favorities [Id=" + Id + ", FavQuestionId=" + FavQuestionId + "]";
	}

	
}
