package impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.FriendRequestDao;
import models.FriendRequest;

public class FriendRequestDaoImpl extends UNSWDaoImpl implements FriendRequestDao{

	public FriendRequestDaoImpl() {}
	
	/**
	 * Find a friend request by a sender and a receiver
	 */
	@Override
	public FriendRequest findByFromTo(Long fromUser, Long toUser) {
		initConnection();
		FriendRequest request = null;
		String sql = "SELECT * FROM user_friend_request WHERE from_user = '" + fromUser + "' AND to_user = '" + toUser + "'";
		try {
			ResultSet results = statement.executeQuery(sql);
			
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
	
	/**
	 * Converts database fields into a FriendRequest Object
	 * @param fromUser
	 * @param toUser
	 * @param status
	 * @return
	 */
	private FriendRequest toFriendRequest(Long fromUser, Long toUser, String status){
		FriendRequest request = new FriendRequest();
		request.setFromUser(fromUser);
		request.setToUser(toUser);
		request.setStatus(status);
		return request;
	}

	@Override
	public List<FriendRequest> findByAccepted(Long fromUser) {
		initConnection();
		List<FriendRequest> requests = new ArrayList<FriendRequest>();
		String sql = "SELECT * FROM user_friend_request WHERE from_user = '" + fromUser + "' AND status = 'ACCEPTED'";
		try {
			ResultSet results = statement.executeQuery(sql);
			
			while(results.next()){
				requests.add(toFriendRequest(results.getLong("from_user"), results.getLong("to_user"), results.getString("status")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return requests;
	}
	
	

}
