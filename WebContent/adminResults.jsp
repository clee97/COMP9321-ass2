<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="impl.UserProfileDaoImpl"%>
<%@page import="dao.UserProfileDao"%>
<%@page import="models.FriendRequest"%>
<%@page import="impl.FriendRequestDaoImpl"%>
<%@page import="dao.FriendRequestDao"%>
<%@page import="services.FriendRequestService"%>
<%@page import="models.UserProfile"%>
<%@page import="java.util.List"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Report Activity</title>
</head>
<body>
	<h2>THIS IS THE END, come a again and count again</h2>
	<%
	if (session.getAttribute("loggedInUser") == null){
		response.sendRedirect("denied.jsp");
	}
	//List<UserProfile> profiles = (List<UserProfile>)request.getAttribute("results");
	UserProfile userLoggedIn = (UserProfile)request.getSession().getAttribute("loggedInUser");
	UserProfile userSelected = (UserProfile)request.getSession().getAttribute("selectedUser");
	
	UserProfileDao userProfileDao = new UserProfileDaoImpl();
	FriendRequestDao friendRequestDao = new FriendRequestDaoImpl();
	
	System.out.println("userLoggedIn: "+userLoggedIn.getFirstname());
	System.out.println("userSelected: "+userSelected.getFirstname());
	%>
	<!-- ===================================== LM ======================================== -->
				        <form class="form-horizontal" role="form" action="API">
			        	<input type="hidden" name="action" value="adminViewUserResult">
			          <div class="form-group">
			            <div class="col-lg-8">
			              First Name: <%=userSelected.getFirstname()%>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-lg-3 control-label">Last name:</label>
			            <div class="col-lg-8">
			              <input name="lastname" class="form-control" type="text" value="<%=userSelected.getLastname()%>"required>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-lg-3 control-label">Email:</label>
			            <div class="col-lg-8">
			              <input name="email"  class="form-control" type="text" value="<%=userSelected.getEmail()%>" required>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-lg-3 control-label">Gender:</label>
			            <div class="col-lg-8">
			              <div class="ui-select">
			                <select name="gender"  id="gender" class="form-control" required>
			                  <option value="MALE" <%if (userSelected.getGender().equals("MALE")){ %>selected="selected"<%}%>>MALE</option>
			                  <option value="FEMALE"<%if (userSelected.getGender().equals("FEMALE")){ %>selected="selected"<%}%>>FEMALE</option>
			                </select>
			              </div>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-md-3 control-label">DOB:</label>
			            <div class="col-md-8">
			              <input name="dob" class="form-control" type="date" value="<%=userSelected.getDob()%>" required>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-md-3 control-label">Password:</label>
			            <div class="col-md-8">
			              <input name="password" class="form-control" type="password" value="<%=userSelected.getPass()%>" required>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-md-3 control-label"></label>
			            <div class="col-md-8">
			              <input type="submit" class="btn btn-primary" value="Save Changes">
			              <span></span>
			              <input type="reset" class="btn btn-default" value="Cancel">
			            </div>
			          </div>
			        </form>
	<!-- ===================================== LM ======================================== -->
</body>
</html>