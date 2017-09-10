package dao;

import models.UserProfile;

public interface UserProfileDao {
	
	public UserProfile findByUserAndPass(String user, String pass);
	
	public UserProfile findByUser(String user);
	
	public UserProfile findById(Long id);


}
