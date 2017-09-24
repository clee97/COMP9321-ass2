package impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.UserPostDao;
import models.UserPost;
import models.UserProfile;

public class UserPostDaoImpl extends UNSWDaoImpl implements UserPostDao {

	@Override
	public List<UserPost> findPostsByUser(Long id) {
		List<UserPost> toReturn = new ArrayList<UserPost>();
		initConnection();
		String sql = "SELECT * FROM user_post WHERE user_id = '" + id + "'";
		try {
			ResultSet results = statement.executeQuery(sql);
			while(results.next()){
				Long postId = results.getLong("id");
				UserPost newPost = new UserPost(
						postId,
						results.getLong("user_id"),
						results.getString("post"), 
						results.getString("date"));
				if (results.getString("imgpath") != null) {
					newPost.SetImgPath(results.getString("imgpath"));
				}
				
				String findLikers = "SELECT user_like.user_id AS user_id "
						+ "FROM user_like, user_post WHERE like_post = '" + postId + "'";
				try {
					ResultSet resultLikers = statement.executeQuery(findLikers);
					while(resultLikers.next()){	
						newPost.AddLiker(results.getLong("user_id"));
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					close(statement);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return toReturn;
	}
	
	@Override
	public List<Long> findLikersOfPost(Long postId) {
		initConnection();
		List<Long> toRtn = new ArrayList<Long>();
		String sql = "SELECT * FROM user_like WHERE like_post = '" + postId + "'";
		try {
			ResultSet results = statement.executeQuery(sql);
			
			while(results.next()){	
				toRtn.add(results.getLong("like_post"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		
		return toRtn;
	}


	@Override
	public Boolean doesLikePostExist(Long userId, Long postId) {
		initConnection();
		Boolean toRtn = false;
		String sql = "SELECT * FROM user_like WHERE user_id = '" + userId + "' AND like_post = '" + postId + "'";
		try {
			ResultSet results = statement.executeQuery(sql);
			
			if (results.next()){ //If exists
				toRtn = true;
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return toRtn;
	}

	
	
	
}
