package com.community.web.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="UserMessages")
public class UserMessages implements Serializable {

	@Id
	@Column(name="Id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int Id;
	
	@Column(name="userId")
	private int userId;
	
	@Column(name="header")
	private String header;
	
	@Column(name="link")
	private String link;
	
	@Column(name="detail")
	private String detail;
	
	@Column(name="creationDate")
	private String creationDate = LocalDateTime.now().toString();
	
	@Column(name="isRead")
	private boolean isRead;
	
	private static final long serialVersionUID = 1L;

	public UserMessages() {}
	
	public UserMessages(int userId, String header, String link, String detail, boolean isRead) {
		this.userId = userId;
		this.header = header;
		this.link = link;
		this.detail = detail;
		this.isRead = isRead;
	}

	public UserMessages(int id, int userId, String header, String link, String detail, String creationDate,
			boolean isRead) {
		Id = id;
		this.userId = userId;
		this.header = header;
		this.link = link;
		this.detail = detail;
		this.creationDate = creationDate;
		this.isRead = isRead;
	}

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}

	public boolean getIsRead() {
		return isRead;
	}

	public void setIsRead(boolean isRead) {
		this.isRead = isRead;
	}

	@Override
	public String toString() {
		return "UserMessages [Id=" + Id + ", userId=" + userId + ", header=" + header + ", link=" + link + ", detail="
				+ detail + ", creationDate=" + creationDate + ", isRead=" + isRead + "]";
	}

	
}
