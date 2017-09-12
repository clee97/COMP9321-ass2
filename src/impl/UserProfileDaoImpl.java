package impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.UserProfileDao;
import models.UserProfile;

public class UserProfileDaoImpl extends UNSWDaoImpl implements UserProfileDao{
	
	public UserProfileDaoImpl(){}
	
	public static void main(String[] args) {
		UserProfileDaoImpl dao = new UserProfileDaoImpl();
		System.out.println(dao.findByUserAndPass("systemadmin", "admin").getFirstname());
	}
	
	/**
	 * Retrieves a user based on their username and password
	 */
	@Override
	public UserProfile findByUserAndPass(String user, String pass) {
		initConnection();
		UserProfile profile = null;
		try {
			ResultSet results = statement.executeQuery("SELECT * FROM user_profile WHERE username = '" + user + "' AND password = '" + pass + "'");
			
			while(results.next()){
				profile = toUserProfile(results.getLong("id"), results.getString("usertype"), results.getString("username"), results.getString("password"), 
						results.getString("firstname"), results.getString("lastname"), results.getString("email"), results.getString("gender"), 
						results.getString("dob"), results.getString("status"), results.getString("imgpath"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return profile;
	}
	
	

	@Override
	public UserProfile findById(Long id) {
		initConnection();
		UserProfile profile = null;
		try {
			ResultSet results = statement.executeQuery("SELECT * FROM user_profile WHERE id = " + id);
			
			while(results.next()){
				profile = toUserProfile(results.getLong("id"), results.getString("usertype"), results.getString("username"), results.getString("password"), 
						results.getString("firstname"), results.getString("lastname"), results.getString("email"), results.getString("gender"), 
						results.getString("dob"), results.getString("status"), results.getString("imgpath"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return profile;
	}

	@Override
	public UserProfile findByUser(String user) {
		initConnection();
		UserProfile profile = null;
		try {
			ResultSet results = statement.executeQuery("SELECT * FROM user_profile WHERE user = '" + user + "'");
			
			while(results.next()){
				profile = toUserProfile(results.getLong("id"), results.getString("usertype"), results.getString("username"), results.getString("password"), 
						results.getString("firstname"), results.getString("lastname"), results.getString("email"), results.getString("gender"), 
						results.getString("dob"), results.getString("status"), results.getString("imgpath"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return profile;
	}
	
	@Override
	public List<UserProfile> searchByName(String search) {
		initConnection();
		List<UserProfile> profiles = new ArrayList<UserProfile>();
		try {
			ResultSet results = statement.executeQuery("SELECT * FROM user_profile WHERE CONCAT(LCASE(firstname), ' ', LCASE(lastname)) LIKE '%" + search.toLowerCase() + "%' AND usertype = 'USER'");
			
			while(results.next()){
				
				UserProfile profile = toUserProfile(results.getLong("id"), results.getString("usertype"), results.getString("username"), results.getString("password"), 
						results.getString("firstname"), results.getString("lastname"), results.getString("email"), results.getString("gender"), 
						results.getString("dob"), results.getString("status"), results.getString("imgpath"));
				
				profiles.add(profile);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return profiles;
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
