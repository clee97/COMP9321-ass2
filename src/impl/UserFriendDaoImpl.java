package impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import dao.UserFriendDao;
import models.UserFriend;
import models.UserPost;
import models.UserProfile;

public class UserFriendDaoImpl extends UNSWDaoImpl implements UserFriendDao{

	@Override
	public List<UserProfile> findUserFriends(Long userId) {
		initConnection();
		String sql = "SELECT * FROM user_profile WHERE id IN "
						+ "("
							+ "SELECT userid2 "
							+ "FROM user_friend "
							+ "WHERE userid1 = " + userId 
						+ ")";
		
		List<UserProfile> friends = new ArrayList<UserProfile>();
		try {
			ResultSet results = statement.executeQuery(sql);
			while(results.next()){
				UserProfile friend = toUserProfile(results.getLong("id"), results.getString("usertype"), results.getString("username"), results.getString("password"), 
						results.getString("firstname"), results.getString("lastname"), results.getString("email"), results.getString("gender"), 
						results.getString("dob"), results.getString("status"), results.getString("imgpath"), results.getString("date_joined"));
				
				friends.add(friend);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return friends;
	}
	
	@Override
	public List<UserFriend> findUserFriendsRelationship(Long userId) {
		initConnection();
		String sql = "SELECT * FROM user_friend WHERE userid1 = " + userId;
		
		List<UserFriend> friends = new ArrayList<UserFriend>();
		try {
			ResultSet results = statement.executeQuery(sql);
			while(results.next()){
				UserFriend friend = toUserFriend(results.getLong("userid1"), results.getLong("userid2"), results.getString("date_friend"));
				friends.add(friend);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		Collections.sort(friends, new Comparator<UserFriend>() {
		  public int compare(UserFriend o1, UserFriend o2) {
		      try {
				return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(o1.getDate()).compareTo(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(o2.getDate()));
		      } catch (ParseException e) {
				e.printStackTrace();
		      }
		      return 0;
		  }
		});
		Collections.reverse(friends);
		return friends;
	}
	
	@Override
	public List<Long> findUserFriendsIds(Long userId){
		return findUserFriends(userId).stream().map(f -> f.getId()).collect(Collectors.toList());
	}
	
	/**
	 * Converts database fields into a UserProfile Object
	 * @param id
	 * @param userType
	 * @param user
	 * @param pass
	 * @param fname
	 * @param lname
	 * @param email
	 * @param gender
	 * @param dob
	 * @param status
	 * @param imgPath
	 * @return
	 */
	private UserProfile toUserProfile(Long id, String userType, String user, String pass, String fname, String lname, String email, String gender, String dob, String status, String imgPath, String dateJoined){
		UserProfile profile = new UserProfile();
		profile.setId(id);
		profile.setUserType(userType);
		profile.setUser(user);
		profile.setPass(pass);
		profile.setFirstname(fname);
		profile.setLastname(lname);
		profile.setEmail(email);
		profile.setGender(gender);
		profile.setDob(dob);
		profile.setStatus(status);
		profile.setImgPath(imgPath);
		profile.setDateJoined(dateJoined);
		return profile;
	}
	
	private UserFriend toUserFriend(Long userId1, Long userId2, String date) {
		UserFriend uf = new UserFriend();
		uf.setUserId1(userId1);
		uf.setUserId2(userId2);
		uf.setDate(date);
		return uf;
	}

}
