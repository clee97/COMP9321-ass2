package impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.UserFriendDao;
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
						results.getString("dob"), results.getString("status"), results.getString("imgpath"));
				
				friends.add(friend);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return friends;
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
	private UserProfile toUserProfile(Long id, String userType, String user, String pass, String fname, String lname, String email, String gender, String dob, String status, String imgPath){
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
		return profile;
	}
	
}
