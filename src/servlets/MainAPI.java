package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import services.UserProfileService;


/**
 * Main Servlet which controls what the system does
 */
@WebServlet("/API")
public class MainAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MainAPI() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action.equals("login")){
			boolean successful = UserProfileService.login(request, request.getParameter("username"), request.getParameter("password"));
			if (successful){
				request.getRequestDispatcher("home.jsp").forward(request, response);
			}else{
				request.setAttribute("loginError", true);
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}else if (action.equals("register")){
			
		}else if (action.equals("activateAccount")){
			
		}else if (action.equals("logout")){
			
		}

	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

