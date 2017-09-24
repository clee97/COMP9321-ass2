package services;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import dao.UserPostDao;
import impl.UserPostDaoImpl;
import models.UserPost;
import models.UserProfile;

public class UserPostService extends UNSWBookService {
	private static UserPostDao postDao = new UserPostDaoImpl();
	
	public UserPostService(){}
	
	/**
	 * Registers a user to UNSWBook
	 * @param request
	 * @param newProfile
	 * @return
	 */
	public boolean postToWall(HttpServletRequest request, UserPost newPost) {
		initConnection();
		UserProfile loggedInUser = (UserProfile) request.getSession().getAttribute("loggedInUser");
		Long uid = loggedInUser.getId();
		
		String sql = "INSERT INTO user_post (id, user_id, post, date, imgpath) "
				+ "VALUES (null, '" + uid + "', '" + newPost.getContent() + "', '" + newPost.getDate() 
				+ "', '" + newPost.getImgPath() + "')";
		
		try {
			statement.executeUpdate(sql);			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
	}
	
	public boolean LikePost(HttpServletRequest request, UserPost postToLike) {
		initConnection();
		UserProfile loggedInUser = (UserProfile) request.getSession().getAttribute("loggedInUser");
		
		Long uid = loggedInUser.getId();
		Long postId = postToLike.getId();
		
		String sql = "INSERT INTO user_like (user_id, like_post) "
				+ "VALUES (" + uid + ", '" + postId + "')";
		try {
			statement.executeUpdate(sql);			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
	}
	public boolean UnlikePost(HttpServletRequest request, UserPost postToUnlike) {
		initConnection();
		UserProfile loggedInUser = (UserProfile) request.getSession().getAttribute("loggedInUser");
		
		Long uid = loggedInUser.getId();
		Long postId = postToUnlike.getId();
		
		if (! postDao.doesLikePostExist(uid, postId)) {
			return true;
		}
		
		String sql = "DELETE FROM user_like WHERE "
				+ "user_id = " + uid + " AND like_post = " + postId;
		try {
			statement.executeUpdate(sql);			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
	}

}
