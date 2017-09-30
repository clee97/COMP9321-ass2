package services;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	public void banUser(HttpServletRequest request, String userID){
		initConnection();		
		// create the java mysql update preparedstatement
	      String sql = "UPDATE user_profile SET status = 'BANNED' WHERE id = '" + userID + "'";

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
	
	public void unbanUser(HttpServletRequest request, String userID){
		initConnection();
		
		//selectedUser.setStatus("BANNED");
		// create the java mysql update preparedstatement
	      String sql = "UPDATE user_profile SET status = 'CREATED' WHERE id = '" + userID + "'";

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
	
	/**
	 * Retrieves a user's report activity
	 */
	public List<String> userActivityReport(HttpServletRequest request, Long userID) {
		System.out.println("Entered AdminService userActivityReport method");
		initConnection();
		List<String> report = new ArrayList<String>();
		String sql = ""
				+ "SELECT id, date_joined, \"User joined unswbook\" as Activity FROM user_profile where id='" + userID+ "' "
				+ "UNION SELECT userid1, date_added_friend, concat(\"User added \", (select concat(firstname, \" \",lastname) from user_profile where id =  userid2), \" as friend\") as Activity  FROM user_friend where userid1='" + userID+ "' " 
				+ "UNION SELECT user_id, date_liked, \"User liked post\" as Activity FROM user_like where user_id='" + userID+ "' "
				+ "UNION SELECT id, date, \"User posted\" as Activity FROM user_post where id='" + userID+ "' "
				+ "ORDER BY date_joined desc";
		System.out.println("SQL statement: "+ sql);
		try {
			ResultSet results = statement.executeQuery(sql);
			

			while(results.next()){				
				String[] parts = results.getString("date_joined").split(":");
				report.add(parts[0]+":"+parts[1]);
				report.add(results.getString("Activity"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return report;
	}
}
	