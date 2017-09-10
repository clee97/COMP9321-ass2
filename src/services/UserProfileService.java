package services;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import dao.UserProfileDao;
import impl.UserProfileDaoImpl;
import models.UserProfile;
import utils.EmailService;

public class UserProfileService extends UNSWBookService{

	private static UserProfileDao userDao;
	
	public UserProfileService(){}
	
	public boolean registerUser(HttpServletRequest request, UserProfile newProfile) {
		initConnection();
		userDao = new UserProfileDaoImpl();
		UserProfile taken = userDao.findByUser(newProfile.getUser());
		boolean created = false;
		if (taken != null){
			request.setAttribute("registerError", "That username has been taken already, pick another one");
			return created;
		}
		String sql = "INSERT INTO user_profile (id, usertype, username, password, firstname, lastname, email, gender, dob, status, imgpath) "
				+ "VALUES (null, '" + newProfile.getUserType() + "', '" + newProfile.getUser() + "', '" + newProfile.getPass() 
				+ "', '" + newProfile.getFirstname() + "', '" +  newProfile.getLastname() + "', '" + newProfile.getEmail() 
				+ "', '" + newProfile.getGender() + "', '" + newProfile.getDob() + "', '" + newProfile.getStatus() + "', '" + newProfile.getImgPath() + "')";
		try {
			statement.executeUpdate(sql);
			
			UserProfile createdUser = userDao.findByUserAndPass(newProfile.getUser(), newProfile.getPass());
			if (createdUser == null){
				request.setAttribute("registerError", "Something went wrong in creating your account");
				return created;
			}
			created = true;
			EmailService.sendActivationEmail(createdUser);
			System.out.println(createdUser.getId());
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
		
	}
	
	public boolean activateUser(HttpServletRequest request, Long userId){
		initConnection();
		String sql = "UPDATE user_profile SET status = 'CREATED' WHERE id = " + userId.toString();
		boolean activated = false;	
		try {
			statement.executeUpdate(sql);
			
			userDao = new UserProfileDaoImpl();
			UserProfile activatedUser = userDao.findById(userId);
			
			if (!activatedUser.getStatus().equals("CREATED") || activatedUser == null){
				request.setAttribute("loginError", "Something went wrong in activating your account");
				return activated;
			}
			activated = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return activated;
		
	}
	
	public boolean login(HttpServletRequest request, String user, String pass){
		boolean correctCredentials = false;
		userDao = new UserProfileDaoImpl();
		UserProfile existingUser = userDao.findByUserAndPass(user, pass);
		if (existingUser == null){
			request.setAttribute("loginError", "Wrong username or password, please try again");
			return correctCredentials; //if no user is found with given user and pass then fail to log in
		}
		if (existingUser.getStatus().equals("PENDING")){
			request.setAttribute("loginError", "Your account has been created but not activated yet");
			return correctCredentials;
		}
		correctCredentials = true;
		request.getSession().setAttribute("loggedInUser", existingUser);
		return correctCredentials;
	}
	
}
