package services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import dao.UserProfileDao;
import impl.UserProfileDaoImpl;
import models.UserProfile;

public class UserProfileService extends UNSWBookService{

	private static UserProfileDao userDao;
	
	public UserProfileService(){}
	
	public boolean registerUser(UserProfile newProfile) {
		initConnection();
		String sql = "INSERT INTO user_profile (id, usertype, username, password, firstname, lastname, email, gender, dob, status, imgpath) "
				+ "VALUES (null, '" + newProfile.getUserType() + "', '" + newProfile.getUser() + "', '" + newProfile.getPass() 
				+ "', '" + newProfile.getFirstname() + "', '" +  newProfile.getLastname() + "', '" + newProfile.getEmail() 
				+ "', '" + newProfile.getGender() + "', '" + newProfile.getDob() + "', '" + newProfile.getStatus() + "', '" + newProfile.getImgPath() + "')";
		try {
			boolean created = false;
			statement.executeUpdate(sql);
			
			userDao = new UserProfileDaoImpl();
			UserProfile createdUser = userDao.findByUserAndPass(newProfile.getUser(), newProfile.getPass());
			if (createdUser == null){
				return created;
			}
			created = true;
			System.out.println(createdUser.getId());
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
		
	}
	
	public boolean login(HttpServletRequest request, String user, String pass){
		boolean correctCredentials = false;
		userDao = new UserProfileDaoImpl();
		UserProfile existingUser = userDao.findByUserAndPass(user, pass);
		if (existingUser == null){
			return correctCredentials; //if no user is found with given user and pass then fail to log in
		}
		correctCredentials = true;
		request.getSession().setAttribute("loggedInUser", existingUser);
		return correctCredentials;
	}
	
}
