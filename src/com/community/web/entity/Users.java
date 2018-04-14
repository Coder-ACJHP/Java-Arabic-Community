package com.community.web.entity;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "Users")
public class Users implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int ID;
	
	@NotEmpty(message="First name cannot be empty!")
	@Column(name = "FIRSTNAME")
	private String FIRSTNAME;

	@NotEmpty(message="Last name cannot be empty!")
	@Column(name = "LASTNAME")
	private String LASTNAME;

	@Email(regexp="^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$", message="Invalid email!")
	@NotEmpty(message="Email cannot be empty!")
	@Column(name = "EMAIL")
	private String EMAIL;

	@NotEmpty(message="Country cannot be empty!")
	@Column(name = "COUNTRY")
	private String COUNTRY;

	@NotEmpty(message="Birthdate cannot be empty!")
	@Column(name = "BIRTHDAY")
	private String BIRTHDAY;

	@NotEmpty(message="Nickname cannot be empty!")
	@Column(name = "NICKNAME")
	private String NICKNAME;

	@NotEmpty(message="Password cannot be empty!")
	@Column(name = "PASSWORD")
	private String PASSWORD;

	@NotEmpty(message="About cannot be empty!")
	@Column(name = "ABOUT")
	private String ABOUT;

	@NotEmpty(message="Favorite language cannot be empty!")
	@Column(name = "FAV_PROG_LANG")
	private String FAV_PROG_LANG;

	@Lob
	@Column(name = "PICTURE")
	private byte[] PICTURE;

	@Column(name = "VOTE")
	private int VOTE;

	@Column(name = "ANSWERCOUNT")
	private int ANSWERCOUNT;

	@Column(name = "QUESTIONCOUNT")
	private int QUESTIONCOUNT;

	@Column(name = "REGISTERDATE")
	private String REGISTERDATE = LocalDateTime.now().toString();

	@Column(name = "UUID")
	private String UUID;

	@Column(name = "UUIDEXPDATE")
	private String UUIDEXPDATE;
	
	@OneToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="Users_Authority_Id")
	private Authorities authorities;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy="users", cascade=CascadeType.ALL)
	private List<UserComment> userComments;

	@OneToMany(mappedBy="users", cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<Favorities> favorities;
	
	public Users() {}

	public Users(String fIRSTNAME, String lASTNAME, String eMAIL, String cOUNTRY, String bIRTHDAY, String nICKNAME,
			String pASSWORD, String aBOUT, String fAV_PROG_LANG, byte[] pICTURE, int vOTE) {
		FIRSTNAME = fIRSTNAME;
		LASTNAME = lASTNAME;
		EMAIL = eMAIL;
		COUNTRY = cOUNTRY;
		BIRTHDAY = bIRTHDAY;
		NICKNAME = nICKNAME;
		PASSWORD = pASSWORD;
		ABOUT = aBOUT;
		FAV_PROG_LANG = fAV_PROG_LANG;
		PICTURE = pICTURE;
		VOTE = vOTE;
	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getFIRSTNAME() {
		return FIRSTNAME;
	}

	public void setFIRSTNAME(String fIRSTNAME) {
		FIRSTNAME = fIRSTNAME;
	}

	public String getLASTNAME() {
		return LASTNAME;
	}

	public void setLASTNAME(String lASTNAME) {
		LASTNAME = lASTNAME;
	}

	public String getEMAIL() {
		return EMAIL;
	}

	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}

	public String getCOUNTRY() {
		return COUNTRY;
	}

	public void setCOUNTRY(String cOUNTRY) {
		COUNTRY = cOUNTRY;
	}

	public String getBIRTHDAY() {
		return BIRTHDAY;
	}

	public void setBIRTHDAY(String bIRTHDAY) {
		BIRTHDAY = bIRTHDAY;
	}

	public String getNICKNAME() {
		return NICKNAME;
	}

	public void setNICKNAME(String nICKNAME) {
		NICKNAME = nICKNAME;
	}

	public String getPASSWORD() {
		return PASSWORD;
	}

	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}

	public String getABOUT() {
		return ABOUT;
	}

	public void setABOUT(String aBOUT) {
		ABOUT = aBOUT;
	}

	public String getFAV_PROG_LANG() {
		return FAV_PROG_LANG;
	}

	public void setFAV_PROG_LANG(String fAV_PROG_LANG) {
		FAV_PROG_LANG = fAV_PROG_LANG;
	}

	public byte[] getPICTURE() {
		return PICTURE;
	}

	public void setPICTURE(byte[] pICTURE) {
		PICTURE = pICTURE;
	}

	public int getVOTE() {
		return VOTE;
	}

	public void setVOTE(int vOTE) {
		VOTE = vOTE;
	}

	public int getANSWERCOUNT() {
		return ANSWERCOUNT;
	}

	public void setANSWERCOUNT(int aNSWERCOUNT) {
		ANSWERCOUNT = aNSWERCOUNT;
	}

	public int getQUESTIONCOUNT() {
		return QUESTIONCOUNT;
	}

	public void setQUESTIONCOUNT(int qUESTIONCOUNT) {
		QUESTIONCOUNT = qUESTIONCOUNT;
	}

	public String getREGISTERDATE() {
		return REGISTERDATE;
	}

	public void setREGISTERDATE(String rEGISTERDATE) {
		REGISTERDATE = rEGISTERDATE;
	}

	public String getUUID() {
		return UUID;
	}

	public void setUUID(String uUID) {
		UUID = uUID;
	}

	public String getUUIDEXPDATE() {
		return UUIDEXPDATE;
	}

	public void setUUIDEXPDATE(String uUIDEXPDATE) {
		UUIDEXPDATE = uUIDEXPDATE;
	}

	public Authorities getAuthority() {
		return authorities;
	}

	public void setAuthority(Authorities authority) {
		this.authorities = authority;
	}

	public List<UserComment> getUserComments() {
		return userComments;
	}
	
	public void setUserComments(List<UserComment> userComments) {
		this.userComments = userComments;
	}
	
	public List<Favorities> getFavorities() {
		return favorities;
	}
	
	public void setFavorities(List<Favorities> favorities) {
		this.favorities = favorities;
	}
	
	
	@Override
	public String toString() {
		return "Users [ID=" + ID + ", FIRSTNAME=" + FIRSTNAME + ", LASTNAME=" + LASTNAME + ", EMAIL=" + EMAIL
				+ ", COUNTRY=" + COUNTRY + ", BIRTHDAY=" + BIRTHDAY + ", NICKNAME=" + NICKNAME + ", PASSWORD="
				+ PASSWORD + ", ABOUT=" + ABOUT + ", FAV_PROG_LANG=" + FAV_PROG_LANG + ", PICTURE="
				+ Arrays.toString(PICTURE) + ", VOTE=" + VOTE + ", ANSWERCOUNT=" + ANSWERCOUNT + ", QUESTIONCOUNT="
				+ QUESTIONCOUNT + ", REGISTERDATE=" + REGISTERDATE + ", UUID=" + UUID + ", UUIDEXPDATE=" + UUIDEXPDATE
				+ ", authority=" + authorities + "]";
	}

	public void addComments(UserComment comment) {
		
		if(userComments == null) {
			userComments = new ArrayList<>();
		}
		
		userComments.add(comment);
		comment.setUsers(this);
		
	}
	
	public void addFavority(Favorities favority) {
		
		if(favorities == null) {
			favorities = new ArrayList<>();
		}
		
		favorities.add(favority);
		favority.setUsers(this);
		
	}
	
}
