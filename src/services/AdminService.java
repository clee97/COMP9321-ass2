package services;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.mysql.jdbc.PreparedStatement;

import dao.FriendRequestDao;
import dao.UserProfileDao;
import impl.FriendRequestDaoImpl;
import impl.UserProfileDaoImpl;
import models.FriendRequest;
import models.UserProfile;

public class AdminService extends UNSWBookService{
	
	private static FriendRequestDao friendRequestDao = new FriendRequestDaoImpl();
	
	private static UserProfileDao userProfileDao = new UserProfileDaoImpl();
	
	/**
	 * Sends a friend request to a user
	 * @param request
	 * @param toUser
	 * @return
	 */
	public void banUser(HttpServletRequest request, UserProfile selectedUser){
		initConnection();
		
		selectedUser.setStatus("BANNED");
		// create the java mysql update preparedstatement
	      String sql = "UPDATE user_profile SET status = 'BANNED' WHERE id = " + selectedUser.getId();

		try {
			statement.executeUpdate(sql);
			request.getSession().setAttribute("isBanned", "true");
			//System.out.println("banSuccess " + selectedUser.getStatus());
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		System.out.println("banSuccess where isBan= " + request.getSession().getAttribute("isBanned"));
	}
	
	public void unbanUser(HttpServletRequest request, UserProfile selectedUser){
		initConnection();
		
		//selectedUser.setStatus("BANNED");
		// create the java mysql update preparedstatement
	      String sql = "UPDATE user_profile SET status = 'CREATED' WHERE id = " + selectedUser.getId();

		try {
			statement.executeUpdate(sql);
			//request.setAttribute("isBanned", "false");
			request.getSession().setAttribute("isBanned", "false");
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		System.out.println("UNbanSuccess where isBan= " + request.getSession().getAttribute("isBanned"));
	}
}
	