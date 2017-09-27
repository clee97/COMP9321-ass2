package impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import dao.UserPostDao;
import models.UserLike;
import models.UserPost;

public class UserPostDaoImpl extends UNSWDaoImpl implements UserPostDao {
	
	@Override
	public List<UserPost> findPostsByUser(Long id) {
		List<UserPost> toReturn = new ArrayList<UserPost>();
		initConnection();
		String sql = "SELECT * FROM user_post WHERE user_id = " + id;
		try {
			ResultSet results = statement.executeQuery(sql);
			while(results.next()){
				Long postId = results.getLong("id");
				UserPost newPost = new UserPost();
				newPost.setId(postId);
				newPost.setPosterId(results.getLong("user_id"));
				newPost.setContent(results.getString("post"));
				newPost.setDate(results.getString("date"));
				newPost.setImgPath(results.getString("imgpath"));
				toReturn.add(newPost);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		Collections.sort(toReturn, new Comparator<UserPost>() {
		  public int compare(UserPost o1, UserPost o2) {
		      try {
				return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(o1.getDate()).compareTo(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(o2.getDate()));
		      } catch (ParseException e) {
				e.printStackTrace();
		      }
		      return 0;
		  }
		});
		Collections.reverse(toReturn);
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
				toRtn.add(results.getLong("user_id"));
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
	
	public UserPost toUserPost(Long id, Long userId, String content, String date, String imgpath){
		UserPost post = new UserPost();
		post.setId(userId);
		post.setPosterId(userId);
		post.setContent(content);
		post.setDate(date);
		post.setImgPath(imgpath);
		
		return post;
	}
	
	public UserLike toUserLike(Long userId, Long likesPostId, String date){
		UserLike userLike = new UserLike();
		userLike.setUserId(userId);
		userLike.setLikesPostId(likesPostId);
		userLike.setDate(date);
		return userLike;
	}

	@Override
	public UserPost findById(Long postId) {
		initConnection();
		Boolean toRtn = false;
		String sql = "SELECT * FROM user_post WHERE id = " + postId;
		UserPost post = null;
		try {
			ResultSet results = statement.executeQuery(sql);
			
			if (results.next()){ //If exists
				post = toUserPost(results.getLong("id"), results.getLong("user_id"), results.getString("post"), results.getString("date"), results.getString("imgpath"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return post;
	}

	@Override
	public List<UserLike> findUserLikes(Long userId) {
		initConnection();
		String sql = "SELECT * FROM user_like WHERE user_id = " + userId;
		List<UserLike> allLikes = new ArrayList<UserLike>();
		try {
			ResultSet results = statement.executeQuery(sql);
			
			while (results.next()){
				allLikes.add(toUserLike(results.getLong("user_id"), results.getLong("like_post"), results.getString("date")));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		
		Collections.sort(allLikes, new Comparator<UserLike>() {
		  public int compare(UserLike o1, UserLike o2) {
		      try {
				return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(o1.getDate()).compareTo(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(o2.getDate()));
		      } catch (ParseException e) {
				e.printStackTrace();
		      }
		      return 0;
		  }
		});
		Collections.reverse(allLikes);
			
		return allLikes;
	}
	
}
