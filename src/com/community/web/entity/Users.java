package com.community.web.entity;

import java.util.Arrays;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
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
	
	@Column(name="ENABLED")
	private boolean ENABLED;
	
	@ManyToOne
	@JoinColumn(name="EMAIL", referencedColumnName ="EMAIL", insertable=false, updatable=false)
	private Authorities authorities;
	
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

	public boolean isENABLED() {
		return ENABLED;
	}

	public void setENABLED(boolean eNABLED) {
		ENABLED = eNABLED;
	}

	public Authorities getAuthorities() {
		return authorities;
	}

	public void setAuthorities(Authorities authorities) {
		this.authorities = authorities;
	}

	@Override
	public String toString() {
		return "Users [ID=" + ID + ", FIRSTNAME=" + FIRSTNAME + ", LASTNAME=" + LASTNAME + ", EMAIL=" + EMAIL
				+ ", COUNTRY=" + COUNTRY + ", BIRTHDAY=" + BIRTHDAY + ", NICKNAME=" + NICKNAME + ", PASSWORD="
				+ PASSWORD + ", ABOUT=" + ABOUT + ", FAV_PROG_LANG=" + FAV_PROG_LANG + ", PICTURE="
				+ Arrays.toString(PICTURE) + ", VOTE=" + VOTE + ", ANSWERCOUNT=" + ANSWERCOUNT + ", QUESTIONCOUNT="
				+ QUESTIONCOUNT + ", REGISTERDATE=" + REGISTERDATE + ", UUID=" + UUID + ", ENABLED=" + ENABLED + "]";
	}

	public Users(int iD, String fIRSTNAME, String lASTNAME, String eMAIL, String cOUNTRY, String bIRTHDAY,
			String nICKNAME, String pASSWORD, String aBOUT, String fAV_PROG_LANG, byte[] pICTURE, int vOTE,
			int aNSWERCOUNT, int qUESTIONCOUNT, String rEGISTERDATE, String uUID, boolean eNABLED) {
		super();
		ID = iD;
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
		ANSWERCOUNT = aNSWERCOUNT;
		QUESTIONCOUNT = qUESTIONCOUNT;
		REGISTERDATE = rEGISTERDATE;
		UUID = uUID;
		ENABLED = eNABLED;
	}

	public Users(String eMAIL, String pASSWORD) {
		super();
		EMAIL = eMAIL;
		PASSWORD = pASSWORD;
	}
	
	public Users(String eMAIL, String pASSWORD, boolean eNABLED) {
		super();
		EMAIL = eMAIL;
		PASSWORD = pASSWORD;
		ENABLED = eNABLED;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((ABOUT == null) ? 0 : ABOUT.hashCode());
		result = prime * result + ANSWERCOUNT;
		result = prime * result + ((BIRTHDAY == null) ? 0 : BIRTHDAY.hashCode());
		result = prime * result + ((COUNTRY == null) ? 0 : COUNTRY.hashCode());
		result = prime * result + ((EMAIL == null) ? 0 : EMAIL.hashCode());
		result = prime * result + (ENABLED ? 1231 : 1237);
		result = prime * result + ((FAV_PROG_LANG == null) ? 0 : FAV_PROG_LANG.hashCode());
		result = prime * result + ((FIRSTNAME == null) ? 0 : FIRSTNAME.hashCode());
		result = prime * result + ID;
		result = prime * result + ((LASTNAME == null) ? 0 : LASTNAME.hashCode());
		result = prime * result + ((NICKNAME == null) ? 0 : NICKNAME.hashCode());
		result = prime * result + ((PASSWORD == null) ? 0 : PASSWORD.hashCode());
		result = prime * result + Arrays.hashCode(PICTURE);
		result = prime * result + QUESTIONCOUNT;
		result = prime * result + ((REGISTERDATE == null) ? 0 : REGISTERDATE.hashCode());
		result = prime * result + ((UUID == null) ? 0 : UUID.hashCode());
		result = prime * result + VOTE;
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
		Users other = (Users) obj;
		if (ABOUT == null) {
			if (other.ABOUT != null)
				return false;
		} else if (!ABOUT.equals(other.ABOUT))
			return false;
		if (ANSWERCOUNT != other.ANSWERCOUNT)
			return false;
		if (BIRTHDAY == null) {
			if (other.BIRTHDAY != null)
				return false;
		} else if (!BIRTHDAY.equals(other.BIRTHDAY))
			return false;
		if (COUNTRY == null) {
			if (other.COUNTRY != null)
				return false;
		} else if (!COUNTRY.equals(other.COUNTRY))
			return false;
		if (EMAIL == null) {
			if (other.EMAIL != null)
				return false;
		} else if (!EMAIL.equals(other.EMAIL))
			return false;
		if (ENABLED != other.ENABLED)
			return false;
		if (FAV_PROG_LANG == null) {
			if (other.FAV_PROG_LANG != null)
				return false;
		} else if (!FAV_PROG_LANG.equals(other.FAV_PROG_LANG))
			return false;
		if (FIRSTNAME == null) {
			if (other.FIRSTNAME != null)
				return false;
		} else if (!FIRSTNAME.equals(other.FIRSTNAME))
			return false;
		if (ID != other.ID)
			return false;
		if (LASTNAME == null) {
			if (other.LASTNAME != null)
				return false;
		} else if (!LASTNAME.equals(other.LASTNAME))
			return false;
		if (NICKNAME == null) {
			if (other.NICKNAME != null)
				return false;
		} else if (!NICKNAME.equals(other.NICKNAME))
			return false;
		if (PASSWORD == null) {
			if (other.PASSWORD != null)
				return false;
		} else if (!PASSWORD.equals(other.PASSWORD))
			return false;
		if (!Arrays.equals(PICTURE, other.PICTURE))
			return false;
		if (QUESTIONCOUNT != other.QUESTIONCOUNT)
			return false;
		if (REGISTERDATE == null) {
			if (other.REGISTERDATE != null)
				return false;
		} else if (!REGISTERDATE.equals(other.REGISTERDATE))
			return false;
		if (UUID == null) {
			if (other.UUID != null)
				return false;
		} else if (!UUID.equals(other.UUID))
			return false;
		if (VOTE != other.VOTE)
			return false;
		return true;
	}
	
}







