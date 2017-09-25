package dao;

import java.util.List;

import models.FriendRequest;

public interface FriendRequestDao {

	public FriendRequest findByFromTo(Long fromUser, Long toUser);
	
	public List<FriendRequest> findByAccepted(Long fromUser);
}
