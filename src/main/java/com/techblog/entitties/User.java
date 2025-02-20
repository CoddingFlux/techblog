package com.techblog.entitties;

import java.sql.Timestamp;

public class User {

    private Long uId;
    private String uName;
    private String uEmail;
    private String uPassword;
    private String uGender;
    private String uAbout;
    private String uProfile;
    private Timestamp timestamp;


	public User() {
    }

    public User(Long uId, String uName, String uEmail, String uPassword, String uGender, String uAbout,
            Timestamp timestamp) {
        this.uId = uId;
        this.uName = uName;
        this.uEmail = uEmail;
        this.uPassword = uPassword;
        this.uGender = uGender;
        this.uAbout = uAbout;
        this.timestamp = timestamp;
    }
    
    public User(Long uId, String uName, String uEmail, String uPassword, String uGender, String uAbout,
           String uprofile, Timestamp timestamp) {
        this.uId = uId;
        this.uName = uName;
        this.uEmail = uEmail;
        this.uPassword = uPassword;
        this.uGender = uGender;
        this.uAbout = uAbout;
        this.uProfile=uprofile;
        this.timestamp = timestamp;
    }

    public User(String uName, String uEmail, String uPassword, String uGender, String uAbout) {
        this.uName = uName;
        this.uEmail = uEmail;
        this.uPassword = uPassword;
        this.uGender = uGender;
        this.uAbout = uAbout;
    }

    // /getters & setters



	public User(String uName, String uProfile) {
		this.uName=uName;
		this.uProfile=uProfile;
	}

	public Long getuId() {
        return uId;
    }


    public void setuId(Long uId) {
        this.uId = uId;
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName;
    }

    public String getuEmail() {
        return uEmail;
    }

    public void setuEmail(String uEmail) {
        this.uEmail = uEmail;
    }

    public String getuPassword() {
        return uPassword;
    }

    public void setuPassword(String uPassword) {
        this.uPassword = uPassword;
    }

    public String getuGender() {
        return uGender;
    }

    public void setuGender(String uGender) {
        this.uGender = uGender;
    }

    public String getuAbout() {
        return uAbout;
    }

    public void setuAbout(String uAbout) {
        this.uAbout = uAbout;
    }

    public String getuProfile() {
		return uProfile;
	}

	public void setuProfile(String uProfile) {
		this.uProfile = uProfile;
	}
    
    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    // /getters & setters

}
