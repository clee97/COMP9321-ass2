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
		if (action.equals("login")){
			boolean successful = userProfileService.login(request, request.getParameter("username"), request.getParameter("password"), isAdminLoginPage, isBanned);
			if (successful){
				request.getRequestDispatcher("home.jsp").forward(request, response);
			}else{
				if (isAdminLoginPage != null && isAdminLoginPage.equals("true")) {
					request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
				} else {
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
			}
		} else if (action.equals("register")){
			//getting current date for admin reporting
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
		} else if (action.equals("userReport")){			
			request.getRequestDispatcher("adminResults.jsp").forward(request, response);
		} else if (action.equals("ban")){
			UserProfile selectedUser = (UserProfile)request.getSession().getAttribute("selectedUser");
			System.out.println("USER to ban is: " + selectedUser.getFirstname());
			adminService.banUser(request, selectedUser);
			request.getRequestDispatcher("advancedSearch.jsp").forward(request, response);
			
		}else if (action.equals("unban")){
			UserProfile selectedUser = (UserProfile)request.getSession().getAttribute("selectedUser");
			System.out.println("USER to unban is: " + selectedUser.getFirstname());
			adminService.banUser(request, selectedUser);
			request.getRequestDispatcher("results.jsp").forward(request, response);

		//===================================================== LM ===================================================
		}else if (action.equals("adminViewUserResult")){
			userProfileService.adminViewUserProfile(request, request.getParameter("firstname"), request.getParameter("lastname"),
					request.getParameter("email"), request.getParameter("gender"), request.getParameter("dob"), request.getParameter("password"));
			
			request.getRequestDispatcher("adminResults.jsp").forward(request, response);
		}

		//===================================================== LM ===================================================

	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

