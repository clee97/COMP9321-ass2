<!DOCTYPE html>
<%@page import="impl.UserProfileDaoImpl"%>
<%@page import="dao.UserProfileDao"%>
<%@page import="models.FriendRequest"%>
<%@page import="impl.FriendRequestDaoImpl"%>
<%@page import="dao.FriendRequestDao"%>
<%@page import="services.FriendRequestService"%>
<%@page import="models.UserProfile"%>
<%@page import="java.util.List"%>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/results.css">
  <link rel="stylesheet" href="css/home.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="js/home.js"></script>
</head>
<body>
<%
	if (session.getAttribute("loggedInUser") == null){
		response.sendRedirect("denied.jsp");
	}
	List<UserProfile> profiles = (List<UserProfile>)request.getAttribute("results");
	UserProfile userLoggedIn = (UserProfile)request.getSession().getAttribute("loggedInUser");
	
	UserProfileDao userProfileDao = new UserProfileDaoImpl();
	FriendRequestDao friendRequestDao = new FriendRequestDaoImpl();
	List<FriendRequest> acceptedNotifs = friendRequestDao.findByAccepted(userLoggedIn.getId());

%>
<!-- Header -->
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
      	<li><a href="#"><b>UNSW Book</b> <span class="sr-only">(current)</span></a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<script>
    $(function () {
  $('[data-tooltip="tooltip"]').tooltip()
	});
</script>
<!-- /Header -->

<!-- Main -->
<div class="container">
<div class="row">
    <div class="col-md-9">
      	
      <!-- column 2 -->	
      <!-- <a href="#"><strong><i class="glyphicon glyphicon-dashboard"></i> My Wall</strong></a>   -->
      	<hr>
		<div class="row">
			<hgroup class="mb20">
				<h1>Search Results</h1>
				<h2 class="lead"><strong class="text-danger"><%=profiles.size() %></strong> results were found for the search for <strong class="text-danger">Lorem</strong></h2>								
			</hgroup>
			<br>
			<ul id="autolist" class="list-group">
                     <li id="fav" class="list-group-item">
                         <div class="row">
                             <div id="favorites" class="">
                                 <div class="container">
                                     <span class="glyphicon glyphicon-user"> </span><b>Users</b>
                                 </div>
                             </div>
                         </div>
                     </li>
					<%for (UserProfile p : profiles){ 
						request.getSession().setAttribute("selectedUser", p);
						long userID = p.getId();
					%>					
                     <li class="list-group-item">
                         <div class='row'>
                             <div class='col-md-12'>
                                 <div class='media-left media-middle'>
                                     <a href='API?action=viewUser&userId=<%=p.getId()%>'>
                                         <img class='media-object img-circle' src='http://placehold.it/40x40'>
                                     </a>
                                 </div>
                                 <div id='center'>
                                     <%=p.getFirstname()%> <%=p.getLastname()%>
                                 </div>
                                 <%
									if (request.getSession().getAttribute("isAdmin").equals("true")){ %>
									<form method="post" class="navbar-form navbar-left" action="API">
      									<input type="hidden" name="action" value="userReport">							
										<div id='User Activity'>
	                                     	<input class="btn btn-primary btn-lg btn-block login-button" type="submit" value="userReport">
	                                	 </div>
                                	 </form>
	                               	 <form method="post" class="navbar-form navbar-left" action="API">	
		                                 <div id='User Activity'>
<!-- 		                                     <input type="hidden" name="action" value="ban">	
		                                     <input class="btn btn-primary btn-lg btn-block login-button" type="submit" value="Ban"> -->
		                                     <%
		                                     if(p.getStatus().equals("BANNED")) { %>
		                                     	<% System.out.println("In adminSearchResults page user is now BANNED, show unban"); %>
		                                     	<!-- if user has been banned set the button back to ban -->
                                   	    		<input type="hidden" name="action" value="unban">	
		                                     	<input class="btn btn-primary btn-lg btn-block login-button" type="submit" value="Unban">
		                                     <%	} else {%>
		                                    	 <% System.out.println("In adminSearchResults page user is now NOT banned, show ban"); %>
<%-- 		                                    	 <%if(!request.getSession().getAttribute("isBanned").equals(null)){ %>
		                                    	<% Boolean isThisPersonBanned = request.getSession().getAttribute("isBanned").equals("true");%>
		                                     	<% System.out.println("isThisPersonBanned: " + isThisPersonBanned); }%> --%>
		                                    	<input type="hidden" name="action" value="ban">	
		                                     	<input class="btn btn-primary btn-lg btn-block login-button" type="submit" value="Ban">		                                   
		                                      <%}%>
		                                 </div>
									</form>
								 <%	}%>

                             </div>
                         </div>
                     </li>
                     <%} %>
                  </ul>
		</div>
      </div><!--/row-->
      
  	</div><!--/col-span-9-->
</div>
<!-- /Main -->
</body>


  