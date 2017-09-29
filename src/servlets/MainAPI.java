package servlets;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserProfileDao;
import impl.UserProfileDaoImpl;
import models.UserPost;
import models.UserProfile;
import services.AdminService;
import services.FriendRequestService;
import services.UserPostService;
import services.UserProfileService;


/**
 * Main Servlet which controls what the system does
 */
@WebServlet("/API")
public class MainAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static UserProfileService userProfileService = new UserProfileService();
	
	private static UserPostService userPostService = new UserPostService();
	
	private static FriendRequestService friendRequestService = new FriendRequestService();
	
	private static AdminService adminService = new AdminService();
	
	private UserProfileDao userProfileDao = new UserProfileDaoImpl();
	
	
    public MainAPI() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isAdminLoginPage = request.getParameter("isAdminLoginPage");
		String action = request.getParameter("action");
		String isBanned = request.getParameter("isBanned"); //LM
		int isAdminSearchResult = 0;
		String[] adminSearchResultParams = new String[3];
		if (action.equals("login")){
			boolean successful = userProfileService.login(request, request.getParameter("username"), request.getParameter("password"), isAdminLoginPage, isBanned);
			if (successful){
				if (isAdminLoginPage != null && isAdminLoginPage.equals("true")) {
					request.getRequestDispatcher("adminHome.jsp").forward(request, response);
				} else {
					request.getRequestDispatcher("home.jsp").forward(request, response);
				}
				//request.getRequestDispatcher("home.jsp").forward(request, response);
			}else{
				if (isAdminLoginPage != null && isAdminLoginPage.equals("true")) {
					request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
				} else {
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
			}
		} else if (action.equals("register")){
			//getting current date for admin reporting
			DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date date = new Date();
			System.out.println(dateFormat.format(date));
			
			System.out.println("Testing API register");
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		    
/*		    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		    LocalDateTime now = LocalDateTime.now();
		    Date currentDate = (Date)now;
		    java.sql.Date sqlDate = new java.sql.Date(dtf.format(now));
		    
		    System.out.println(dtf.format(now)); //2016/11/16 12:08:43
*/
			UserProfile newUser = new UserProfile();
			newUser.setUserType("USER");
			newUser.setUser(request.getParameter("username"));
			newUser.setPass(request.getParameter("password"));
			newUser.setFirstname(request.getParameter("firstname"));
			newUser.setLastname(request.getParameter("lastname"));
			newUser.setEmail(request.getParameter("email"));
			newUser.setGender(request.getParameter("gender"));
			newUser.setDob(request.getParameter("dob"));
			newUser.setStatus("PENDING");
			newUser.setImgPath(request.getParameter("default.jpg"));
			newUser.setDateJoined(sqlDate);
			System.out.println("TESTING date joined");
			System.out.println("Date joined: " + newUser.getDateJoined());
			boolean registered = userProfileService.registerUser(request, newUser); 
			if (registered){
				request.getRequestDispatcher("activation.jsp").forward(request, response);
			}else{
				request.getRequestDispatcher("register.jsp").forward(request, response);
			}
			
		}else if (action.equals("activateAccount")){
			Long id = Long.parseLong(request.getParameter("userId"));
			boolean activated = userProfileService.activateUser(request, id);
			if (activated){
				request.getRequestDispatcher("activated.jsp").forward(request, response);
			}else{
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}else if (action.equals("logout")){
			boolean isAdmin = request.getSession().getAttribute("isAdmin").equals("true");
			System.out.println("Is this admin: " + isAdmin);
			userProfileService.logout(request);
			if (isAdmin){
				System.out.println("Logging out, admin is: " + isAdmin);
				request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
			} else {
				System.out.println("Logging out, admin is: " + isAdmin);
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}			
		}else if (action.equals("sendFriendRequest")){
			boolean sent = friendRequestService.sendFriendRequest(request, Long.parseLong(request.getParameter("userId")));
			UserProfile user = userProfileDao.findById(Long.parseLong(request.getParameter("userId")));
			request.setAttribute("user", user);
			if (sent){
				request.getRequestDispatcher("userpage.jsp").forward(request, response);
			}else{
				request.getRequestDispatcher("userpage.jsp").forward(request, response);
			}

		}else if (action.equals("acceptFriendRequest")){
			boolean accepted = friendRequestService.acceptFriendRequest(request, Long.parseLong(request.getParameter("toUser")));
			if (accepted){
				request.getRequestDispatcher("home.jsp").forward(request, response);
			}else{
				request.getRequestDispatcher("home.jsp").forward(request, response);
			}
		}else if (action.equals("search")){
			List<UserProfile> results = userProfileService.searchByName(request, request.getParameter("searchString"));
			request.setAttribute("results", results);
			request.getRequestDispatcher("results.jsp").forward(request, response);
		}else if (action.equals("viewUser")){
			if (request.getSession().getAttribute("isAdmin").equals("true")){
				System.out.println("viewuser: is admin");
			} else {
				System.out.println("viewuser: is NOT admin");
			}
			UserProfile user = userProfileService.findById(Long.parseLong(request.getParameter("userId")));
			request.setAttribute("user", user);
			request.getRequestDispatcher("userpage.jsp").forward(request, response);
		} else if (action.equals("postToWall")) {
			userPostService.postToWall(request);
			request.getRequestDispatcher("home.jsp").forward(request, response);
		}else if(action.equals("deletePost")){
			userPostService.deletePost(request, Long.parseLong(request.getParameter("postId")));
			request.getRequestDispatcher("home.jsp").forward(request, response);
		}else if (action.equals("advancedSearch")){
			List<UserProfile> results = userProfileService.advancedSearch(request, request.getParameter("name"), request.getParameter("gender"), request.getParameter("dob"));
			request.setAttribute("results", results);
			request.getRequestDispatcher("results.jsp").forward(request, response);
		}else if (action.equals("updateProfile")){
			userProfileService.updateProfile(request, request.getParameter("firstname"), request.getParameter("lastname"),
					request.getParameter("email"), request.getParameter("gender"), request.getParameter("dob"), request.getParameter("password"));
			
			request.getRequestDispatcher("profile.jsp").forward(request, response);
		}else if (action.equals("uploadImage")){
			userProfileService.uploadImage(request);
			request.getRequestDispatcher("profile.jsp").forward(request, response);
		}else if (action.equals("likePost")){
			UserPost userPost = new UserPost();
			userPost.setId(Long.parseLong(request.getParameter("postId")));
			userPostService.LikePost(request, userPost);
			request.getRequestDispatcher("userpage.jsp").forward(request, response);
		}else if (action.equals("unLikePost")){
			UserPost userPost = new UserPost();
			userPost.setId(Long.parseLong(request.getParameter("postId")));
			userPostService.UnlikePost(request, userPost);
			request.getRequestDispatcher("userpage.jsp").forward(request, response);
		} else if (action.equals("userReport")){ //admin's user activity report page
			System.out.println("Action: API userReport called");
			UserProfile selectedUser = (UserProfile)request.getSession().getAttribute("selectedUser");
			System.out.println("Selected User: " + selectedUser.getFirstname());
			adminService.userActivityReport(request, selectedUser.getId());
			request.getRequestDispatcher("adminResults.jsp").forward(request, response);
		} else if (action.equals("ban")
				&& (request.getAttribute("isBanned") == null || !request.getAttribute("isBanned").equals("done"))){
			UserProfile selectedUser = (UserProfile)request.getSession().getAttribute("selectedUser");
			adminService.banUser(request, selectedUser);

			//request.setAttribute("isBanned", "true");
			//request.getSession().setAttribute("isBanned", "true");
			
			String goToAction = "adminSearchResult"; //request.getParameter("action");
			
			isAdminSearchResult = 1;
			adminSearchResultParams[0] = selectedUser.getFirstname();
			adminSearchResultParams[1] = selectedUser.getGender();
			adminSearchResultParams[2] = selectedUser.getDob();

			System.out.println(" name ||| MAINAPI USER to ban is: " + selectedUser.getFirstname());
			//request.getRequestDispatcher("API?action="+goToAction+"&name="+name+"&gender="+gender+"&dob="+dob).forward(request, response);
			
		}else if (action.equals("unban")
				&& (request.getAttribute("isBanned") == null || !request.getAttribute("isBanned").equals("done"))){ //only process when unban btn is clicked
			UserProfile selectedUser = (UserProfile)request.getSession().getAttribute("selectedUser");
			adminService.unbanUser(request, selectedUser);
			
			//request.getSession().setAttribute("isBanned", "false");
			//boolean isBanned = request.getSession().getAttribute("isBanned");
			
			String goToAction = "adminSearchResult"; //request.getParameter("action");

			System.out.println("MAINAPI USER to unban is: " + selectedUser.getFirstname());
			isAdminSearchResult = 1;
			adminSearchResultParams[0] = selectedUser.getFirstname();
			adminSearchResultParams[1] = selectedUser.getGender();
			adminSearchResultParams[2] = selectedUser.getDob();
			//request.getRequestDispatcher("API?action="+goToAction+"&name="+name+"&gender="+gender+"&dob="+dob).forward(request, response);
			


		//===================================================== LM ===================================================
		}else if (action.equals("adminViewUserResult")){
			userProfileService.adminViewUserProfile(request, request.getParameter("firstname"), request.getParameter("lastname"),
					request.getParameter("email"), request.getParameter("gender"), request.getParameter("dob"), request.getParameter("password"));
			
			request.getRequestDispatcher("adminResults.jsp").forward(request, response);
		}
		
		if (action.equals("adminSearchResult") || isAdminSearchResult == 1){
			List<UserProfile> results = userProfileService.advancedSearch(request, request.getParameter("name"), request.getParameter("gender"), request.getParameter("dob"));
			
			if (isAdminSearchResult == 1) {
				isAdminSearchResult = 0;
				results = userProfileService.advancedSearch(request, adminSearchResultParams[0], adminSearchResultParams[1], adminSearchResultParams[2]);
			} 
			request.setAttribute("results", results);
			request.getRequestDispatcher("adminSearchResults.jsp").forward(request, response);
		}

		//===================================================== LM ===================================================

	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

