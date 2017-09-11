package impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import dao.FriendRequestDao;
import models.FriendRequest;

public class FriendRequestDaoImpl extends UNSWDaoImpl implements FriendRequestDao{

	public FriendRequestDaoImpl() {}
	
	@Override
	public FriendRequest findByFromTo(Long fromUser, Long toUser) {
		initConnection();
		FriendRequest request = null;
		try {
			ResultSet results = statement.executeQuery("SELECT * FROM user_friend_request WHERE from_user = " + fromUser + " AND to_user = " + toUser);
			
			while(results.next()){
				request = toFriendRequest(results.getLong("from_user"), results.getLong("to_user"), results.getString("status"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return request;
	}
	
	private FriendRequest toFriendRequest(Long fromUser, Long toUser, String status){
		FriendRequest request = new FriendRequest();
		request.setFromUser(fromUser);
		request.setToUser(toUser);
		request.setStatus(status);
		return request;
	}
	
	

}
