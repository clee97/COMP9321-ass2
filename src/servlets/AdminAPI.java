package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.UserBullyRecord;
import models.UserFriend;
import models.UserLike;
import models.UserPost;
import models.UserProfile;
import services.AdminService;

/**
 * Servlet implementation class AdminAPI
 */
@WebServlet("/APIAdmin")
public class AdminAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private static AdminService adminService = new AdminService();
	
    public AdminAPI() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String adminAction = request.getParameter("adminAction");
		if (adminAction.equals("adminSearch")) {
			List<UserProfile> adminResults = adminService.adminSearch(request.getParameter("name"), request.getParameter("gender"), request.getParameter("dob"));
			request.setAttribute("adminResults", adminResults);
			request.getRequestDispatcher("adminSearchResults.jsp").forward(request, response);
		}else if(adminAction.equals("adminBan")) {
			adminService.banUser(request, Long.parseLong(request.getParameter("userId")));
			List<UserProfile> adminResults = adminService.adminSearch(request.getParameter("name"), request.getParameter("gender"), request.getParameter("dob"));
			request.setAttribute("adminResults", adminResults);
			request.getRequestDispatcher("adminSearchResults.jsp").forward(request, response);
		}else if(adminAction.equals("adminUnban")) {
			adminService.unBanUser(request, Long.parseLong(request.getParameter("userId")));
			List<UserProfile> adminResults = adminService.adminSearch(request.getParameter("name"), request.getParameter("gender"), request.getParameter("dob"));
			request.setAttribute("adminResults", adminResults);
			request.getRequestDispatcher("adminSearchResults.jsp").forward(request, response);
		}else if(adminAction.equals("userReport")){
			List<UserPost> userPosts = adminService.getAllUserPosts(Long.parseLong(request.getParameter("userId")));
			List<UserLike> userLikes = adminService.getUserLikes(Long.parseLong(request.getParameter("userId")));
			List<UserFriend> userFriends = adminService.getAllUserFriends(Long.parseLong(request.getParameter("userId")));
			List<UserBullyRecord> userBullyReport = adminService.getUserBullyReport(Long.parseLong(request.getParameter("userId")));
			UserProfile user = adminService.getUserById(Long.parseLong(request.getParameter("userId")));
			request.setAttribute("user", user);
			request.setAttribute("userLikes", userLikes);
			request.setAttribute("userPosts", userPosts);
			request.setAttribute("userFriends", userFriends);
			request.setAttribute("userBullyReport", userBullyReport);
			request.getRequestDispatcher("userReport.jsp").forward(request, response);
		}else if(adminAction.equals("logout")) {
			adminService.logout(request);
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
