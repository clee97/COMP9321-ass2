package dao;

import models.FriendRequest;

public interface FriendRequestDao {

	public FriendRequest findByFromTo(Long fromUser, Long toUser);
}
