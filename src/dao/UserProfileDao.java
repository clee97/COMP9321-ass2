package dao;

import java.util.List;

import models.UserProfile;

public interface UserProfileDao {
	
	public UserProfile findByUserAndPass(String user, String pass);	

	public UserProfile findByAdminUserAndPass(String user, String pass);
	
	public UserProfile findByUser(String user);
	
	public List<UserProfile> searchByName(String search);
	
	public List<UserProfile> advancedSearch(String name, String gender, String dob);
	
	public UserProfile findById(Long id);


}
