package services;

import java.io.File;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.UserProfileDao;
import impl.UserProfileDaoImpl;
import models.UserProfile;

public class UserProfileService extends UNSWBookService{

	private static UserProfileDao userDao = new UserProfileDaoImpl();;
	
	private static final String UPLOAD_DIRECTORY = System.getProperty("user.dir").replace("\\", "/") + "/WebContent/dps/";
	
	public UserProfileService(){}
	
	/**
	 * Registers a user to UNSWBook
	 * @param request
	 * @param newProfile
	 * @return
	 */
	public boolean registerUser(HttpServletRequest request, UserProfile newProfile) {
		initConnection();
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
	
	/**
	 * Activates a user after they click on an activation link
	 * @param request
	 * @param userId
	 * @return
	 */
	public boolean activateUser(HttpServletRequest request, Long userId){
		initConnection();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentDate = format.format(new Date());
		String sql = "UPDATE user_profile SET status = 'CREATED', date_joined = '" + currentDate + "' WHERE id = " + userId.toString();
		boolean activated = false;	
		try {
			statement.executeUpdate(sql);
			
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
	
	/**
	 * Logs a user in based on user and pass
	 * @param request
	 * @param user
	 * @param pass
	 * @return
	 */
	public boolean login(HttpServletRequest request, String user, String pass){
		boolean correctCredentials = false;
		
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
	
	public UserProfile findById(Long id){
		UserProfile user = userDao.findById(id);
		return user;
	}
	
	public List<UserProfile> searchByName(HttpServletRequest request, String searchString){
		List<UserProfile> users = userDao.searchByName(searchString);
		UserProfile loggedInUser = (UserProfile)request.getSession().getAttribute("loggedInUser");
		return users.stream().filter(p -> !p.getId().equals(loggedInUser.getId())).collect(Collectors.toList());
	}
	
	
	
	public boolean postToWall(HttpServletRequest request) {
		
		
		return true;
	}
	
	
	public List<UserProfile> advancedSearch(HttpServletRequest request, String name, String gender, String dob){
		List<UserProfile> users = userDao.advancedSearch(name, gender, dob);
		UserProfile loggedInUser = (UserProfile)request.getSession().getAttribute("loggedInUser");
		return users.stream().filter(p -> !p.getId().equals(loggedInUser.getId())).collect(Collectors.toList());
	}
	
	public void updateProfile(HttpServletRequest request, String firstName, String lastName, String email, String gender, String dob, String password){
		initConnection();
		UserProfile loggedInUser = (UserProfile)request.getSession().getAttribute("loggedInUser");
		String sql = "UPDATE user_profile SET password = '" + password + "', firstname = '" + firstName + "', lastname = '" + lastName + "', email = '" + email + "', gender = '" + gender + "', dob = '" + dob + "' WHERE id = " + loggedInUser.getId();
		System.out.println(sql);
		try {
			statement.executeUpdate(sql);
			
			UserProfile updatedUser = userDao.findById(loggedInUser.getId());
			
			if (updatedUser.getPass().equals(password) && updatedUser.getFirstname().equals(firstName) 
					&& updatedUser.getLastname().equals(lastName) && updatedUser.getEmail().equals(email) && updatedUser.getGender().equals(gender) && updatedUser.getDob().equals(dob)){
				request.setAttribute("updateSuccess", "Changes saved successfully!");
				request.getSession().setAttribute("loggedInUser", updatedUser);
			}else{
				request.setAttribute("updateError", "Something went wrong in updating your profile");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
	}
	
	public void uploadImage(HttpServletRequest request){
		UserProfile loggedInUser = (UserProfile)request.getSession().getAttribute("loggedInUser");
		if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
              
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                    	String location = UPLOAD_DIRECTORY + loggedInUser.getId() + ".jpg";
                        item.write( new File(location));
                    }
                }
                initConnection();
                String sql = "UPDATE user_profile SET imgpath = '" + loggedInUser.getId() + ".jpg" + "' WHERE id = " + loggedInUser.getId();
                statement.executeUpdate(sql);
                
                UserProfile updatedUser = userDao.findById(loggedInUser.getId());
                if (updatedUser.getImgPath().equals(loggedInUser.getId() + ".jpg")){
                	request.setAttribute("updateSuccess", "Changes saved successfully!");
                	request.getSession().setAttribute("loggedInUser", updatedUser);
                }else{
                	request.setAttribute("updateError", "Something went wrong in updating your profile");
                }
            } catch (Exception ex) {
              ex.printStackTrace();
            }          
         
        }else{
            request.setAttribute("updateError", "Sorry this form only handles file upload request");
        }
    
     
    }
	/**
	 * Logs a user out
	 * @param request
	 */
	public void logout(HttpServletRequest request){
		request.getSession().invalidate();
	}
	
}
