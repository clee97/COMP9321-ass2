package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.UserProfile;
import services.AdminService;
import services.UserProfileService;

/**
 * Servlet implementation class AdminAPI
 */
@WebServlet("/AdminAPI")
public class AdminAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private static AdminService adminService = new AdminService();
	
    public AdminAPI() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String adminAction = request.getParameter("adminAction");
		if (adminAction.equals("adminSearch")) {
			List<UserProfile> adminResults = adminService.searchByName(request.getParameter("searchString"));
			request.setAttribute("adminResults", adminResults);
			request.getRequestDispatcher("adminSearchResults.jsp").forward(request, response);
		}else if(adminAction.equals("adminBan")) {
			adminService.banUser(request, Long.parseLong(request.getParameter("userId")));
			request.getRequestDispatcher("adminSearchResults.jsp").forward(request, response);
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}