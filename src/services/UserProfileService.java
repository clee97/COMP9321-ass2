package services;

import javax.servlet.http.HttpServletRequest;

import dao.UserProfileDao;
import impl.UserProfileDaoImpl;
import models.UserProfile;

public class UserProfileService {

	private static UserProfileDao userDao;
	
	public static void registerUser(UserProfile newProfile) {
		
	}
	
	public static boolean login(HttpServletRequest request, String user, String pass){
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
