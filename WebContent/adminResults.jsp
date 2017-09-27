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
</body>
</html>