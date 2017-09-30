package models;

import java.sql.Date;
import java.sql.Timestamp;

public class UserProfile {

	private Long id;

	private String user;
	
	private String pass;
	
	private String userType;
	
	private String firstname;
	
	private String lastname;
	
	private String email;
	
	private String gender;
	
	private String dob;

	private String status;
	
	private String imgPath;
	
	private Timestamp dateJoined;

	public UserProfile(){}
	
	public UserProfile(Boolean b) {
		if (b) {
			this.user = "offlineGuest";
			this.dob = "1234-12-12";
			this.email = "offline@guest.com";
			
		}
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getImgPath() {
		if (imgPath == null){
			imgPath = "default.jpg";
		}
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		
		this.imgPath = imgPath;
	}
	
	public Timestamp getDateJoined() {
		return dateJoined;
	}

	public void setDateJoined(Timestamp dateJoined) {
		
		this.dateJoined = dateJoined;
	}
	
	
}
