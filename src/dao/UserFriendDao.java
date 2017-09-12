package dao;

import java.util.List;

import models.UserProfile;

public interface UserFriendDao {

	public List<UserProfile> findUserFriends(Long userId);
	
}
