package services;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.UserProfileDao;
import impl.UserProfileDaoImpl;
import models.UserProfile;

public class AdminService extends UNSWBookService{
	
	private static UserProfileDao userDao = new UserProfileDaoImpl();
	
	public AdminService(){}
	
	/**
	 * Bans a user from UNSW Book
	 * @param request
	 * @param userid
	 * @return
	 */
	public boolean banUser(HttpServletRequest request, Long userId) {
		initConnection();

		String sql = "UPDATE user_profile SET status = 'BANNED' WHERE id = " + userId;
		try {
			statement.executeUpdate(sql);
			
			UserProfile createdUser = userDao.findById(userId);
			if (!createdUser.getStatus().equals("BANNED")){
				request.setAttribute("banningError", "Something went wrong banning that user");
			}else{
				request.setAttribute("banningSuccess", "User successfully banned");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
		
	}
	
	public List<UserProfile> searchByName(String name){
		return userDao.searchByName(name);
	}
	
	
}
