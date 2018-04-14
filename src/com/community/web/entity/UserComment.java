package com.community.web.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

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
@Table(name = "UserComment")
public class UserComment implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ID;

    @Column(name = "COMMENTEDBY")
    private String COMMENTEDBY;

    @Column(name = "COMMENT")
    private String COMMENT;

    @Column(name = "CREATIONDATE")
    private String CREATIONDATE = LocalDateTime.now().toString();

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.DETACH, CascadeType.REFRESH})
    @JoinColumn(name = "Users_Id")
    private Users users;

    public UserComment() {
    }

    public int getID() {
        return ID;
    }

    public void setID(int iD) {
        ID = iD;
    }

    public String getCOMMENTEDBY() {
        return COMMENTEDBY;
    }

    public void setCOMMENTEDBY(String cOMMENTEDBY) {
        COMMENTEDBY = cOMMENTEDBY;
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

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    @Override
    public String toString() {
        return "Ucomment [ID=" + ID + ", COMMENTEDBY=" + COMMENTEDBY + ", COMMENT=" + COMMENT
                + ", CREATIONDATE=" + CREATIONDATE + "]";
    }

    public UserComment(String cOMMENTEDBY, String cOMMENT) {

        COMMENTEDBY = cOMMENTEDBY;
        COMMENT = cOMMENT;
    }

}
