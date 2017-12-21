package com.community.web.entity;

import java.util.Arrays;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name="Users")
public class Users {

	@Id
	@Column(name="ID")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int ID;
	
	@Column(name="FIRSTNAME")
	private String FIRSTNAME;
	
	@Column(name="LASTNAME")
	private String LASTNAME;
	
	@Column(name="EMAIL")
	private String EMAIL;
	
	@Column(name="COUNTRY")
	private String COUNTRY;
	
	@Column(name="BIRTHDAY")
	private String BIRTHDAY;
	
	@Column(name="NICKNAME")
	private String NICKNAME;
	
	@Column(name="PASSWORD")
	private String PASSWORD;
	
	@Column(name="ABOUT")
	private String ABOUT;
	
	@Column(name="FAV_PROG_LANG")
	private String FAV_PROG_LANG;
	
	@Lob
	@Column(name="PICTURE")
	private byte[] PICTURE;
	
	@Column(name="VOTE")
	private int VOTE;
	
	@Column(name="ANSWERCOUNT")
	private int ANSWERCOUNT;
	
	@Column(name="QUESTIONCOUNT")
	private int QUESTIONCOUNT;
	
	@Column(name="REGISTERDATE")
	private String REGISTERDATE;
	
	@Column(name="UUID")
	private String UUID;
	
	public Users() {
		
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

	@Override
	public String toString() {
		return "Users [ID=" + ID + ", FIRSTNAME=" + FIRSTNAME + ", LASTNAME=" + LASTNAME + ", EMAIL=" + EMAIL
				+ ", COUNTRY=" + COUNTRY + ", BIRTHDAY=" + BIRTHDAY + ", NICKNAME=" + NICKNAME + ", PASSWORD="
				+ PASSWORD + ", ABOUT=" + ABOUT + ", FAV_PROG_LANG=" + FAV_PROG_LANG + ", PICTURE="
				+ Arrays.toString(PICTURE) + ", VOTE=" + VOTE + ", ANSWERCOUNT=" + ANSWERCOUNT + ", QUESTIONCOUNT="
				+ QUESTIONCOUNT + ", REGISTERDATE=" + REGISTERDATE + ", UUID=" + UUID + "]";
	}
	
}







