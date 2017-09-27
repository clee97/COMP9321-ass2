package services;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import dao.FriendRequestDao;
import dao.UserProfileDao;
import impl.FriendRequestDaoImpl;
import impl.UserProfileDaoImpl;
import models.FriendRequest;
import models.UserProfile;

public class FriendRequestService extends UNSWBookService{
	
	private static FriendRequestDao friendRequestDao = new FriendRequestDaoImpl();
	
	private static UserProfileDao userProfileDao = new UserProfileDaoImpl();
	
	public FriendRequestService(){}
	
	/**
	 * Sends a friend request to a user
	 * @param request
	 * @param toUser
	 * @return
	 */
	public boolean sendFriendRequest(HttpServletRequest request, Long toUser){
		initConnection();
		Long fromUser = ((UserProfile)request.getSession().getAttribute("loggedInUser")).getId();
		boolean sent = false;
		
		FriendRequest exists = friendRequestDao.findByFromTo(fromUser, toUser);
		if (exists != null){
			request.setAttribute("frError", "A friend request already exists between those two users");
			return sent;
		}
		String sql = "INSERT INTO user_friend_request(from_user, to_user, status) VALUES (" + fromUser + ", " + toUser + ", 'PENDING')";
		try {
			statement.executeUpdate(sql);
			
			FriendRequest sentRequest = friendRequestDao.findByFromTo(fromUser, toUser);
			
			if (sentRequest == null){
				request.setAttribute("frError", "Something went wrong in sending the friend request");
				return sent;
			}
			EmailService.sendFriendRequest(((UserProfile)request.getSession().getAttribute("loggedInUser")), userProfileDao.findById(toUser));
			sent = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return sent;
		
	}
	
	/**
	 * Accepts a friend request sent by a user
	 * @param request
	 * @param toUser
	 * @return
	 */
	public boolean acceptFriendRequest(HttpServletRequest request, Long toUser){
		initConnection();
		boolean accepted = false;
		Long fromUser = ((UserProfile)request.getSession().getAttribute("loggedInUser")).getId();
		
		FriendRequest exists = friendRequestDao.findByFromTo(fromUser, toUser);
		if (exists == null){
			request.setAttribute("frError", "This friend request does not exist");
			return accepted;
		}
		if (exists.getStatus().equals("ACCEPTED")){
			request.setAttribute("frError", "This friend request has already been accepted");
			return accepted;
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentDate = format.format(new Date());
		String sql = "UPDATE user_friend_request SET status = 'ACCEPTED' WHERE from_user = " + fromUser + " AND to_user = " + toUser;
		try {
			statement.executeUpdate(sql);
			
			FriendRequest sentRequest = friendRequestDao.findByFromTo(fromUser, toUser);
			
			if (!sentRequest.getStatus().equals("ACCEPTED")){
				request.setAttribute("frError", "Something went wrong in accepting the friend request");
				return accepted;
			}
			statement.executeUpdate("INSERT INTO user_friend(userid1, userid2, date_friend) VALUES (" + fromUser + ", " + toUser + ", " + currentDate + ")");
			statement.executeUpdate("INSERT INTO user_friend(userid1, userid2, date_friend) VALUES (" + toUser + ", " + fromUser + ", " + currentDate + ")");
			accepted = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return accepted;
	}
}
