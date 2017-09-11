package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserProfileDao;
import impl.UserProfileDaoImpl;
import models.UserProfile;
import services.FriendRequestService;
import services.UserProfileService;


/**
 * Main Servlet which controls what the system does
 */
@WebServlet("/API")
public class MainAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static UserProfileService userProfileService = new UserProfileService();
	
	private static FriendRequestService friendRequestService = new FriendRequestService();
	
	private UserProfileDao userProfileDao = new UserProfileDaoImpl();
	
    public MainAPI() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action.equals("login")){
			boolean successful = userProfileService.login(request, request.getParameter("username"), request.getParameter("password"));
			if (successful){
				request.getRequestDispatcher("home.jsp").forward(request, response);
			}else{
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}else if (action.equals("register")){
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
			userProfileService.logout(request);
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}else if (action.equals("sendFriendRequest")){
			boolean sent = friendRequestService.sendFriendRequest(request, Long.parseLong(request.getParameter("userId")));
			if (sent){
				System.out.println("yay sent");
			}else{
				System.out.println("wow not sent");
			}

		}else if (action.equals("acceptFriendRequest")){
			boolean accepted = friendRequestService.acceptFriendRequest(request, Long.parseLong(request.getParameter("toUser")));
			if (accepted){
				System.out.println("yay accepted");
			}else{
				System.out.println("wow not accepted");
			}
		}

	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

