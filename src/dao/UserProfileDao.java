package dao;

import models.UserProfile;

public interface UserProfileDao {
	
	public UserProfile findByUserAndPass(String user, String pass);
	
	public UserProfile findById(Long id);


}
