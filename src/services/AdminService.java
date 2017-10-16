package services;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.UserBullyReportDao;
import dao.UserFriendDao;
import dao.UserPostDao;
import dao.UserProfileDao;
import impl.UserBullyReportDaoImpl;
import impl.UserFriendDaoImpl;
import impl.UserPostDaoImpl;
import impl.UserProfileDaoImpl;
import models.UserBullyRecord;
import models.UserFriend;
import models.UserLike;
import models.UserPost;
import models.UserProfile;

public class AdminService extends UNSWBookService{
	
	private static UserProfileDao userDao = new UserProfileDaoImpl();
	
	private static UserPostDao userPostDao = new UserPostDaoImpl();
	
	private static UserFriendDao userFriendDao = new UserFriendDaoImpl();
	
	private static UserBullyReportDao userBullyReportDao = new UserBullyReportDaoImpl();
	
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
				request.setAttribute("error", "Something went wrong banning that user");
			}else{
				request.setAttribute("success", "User successfully banned");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
		
	}
	
	/**
	 * UnBans a user from UNSW Book
	 * @param request
	 * @param userid
	 * @return
	 */
	public boolean unBanUser(HttpServletRequest request, Long userId) {
		initConnection();

		String sql = "UPDATE user_profile SET status = 'CREATED' WHERE id = " + userId;
		try {
			statement.executeUpdate(sql);
			
			UserProfile createdUser = userDao.findById(userId);
			if (!createdUser.getStatus().equals("CREATED")){
				request.setAttribute("error", "Something went wrong in unbanning that user");
			}else{
				request.setAttribute("success", "User successfully unbanned");
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
	
	public List<UserProfile> adminSearch(String name, String gender, String dob){
		return userDao.advancedSearch(name, gender, dob);
	}
	
	public void logout(HttpServletRequest request) {
		request.getSession().invalidate();
	}
	
	public List<UserPost> getAllUserPosts(Long userId){
		return userPostDao.findPostsByUser(userId);
	}
	
	public List<UserFriend> getAllUserFriends(Long userId){
		return userFriendDao.findUserFriendsRelationship(userId);
	}
	
	public UserProfile getUserById(Long userId){
		return userDao.findById(userId);
	}
	
	public List<UserLike> getUserLikes(Long userId){
		return userPostDao.findUserLikes(userId);
	}
	
	public List<UserBullyRecord> getUserBullyReport(Long userId){
		return userBullyReportDao.findUserBullyReports(userId);
	}
	
	
}
