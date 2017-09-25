<!DOCTYPE html>
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

%>
<!-- Header -->
<div id="top-nav" class="navbar navbar-inverse navbar-static-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="icon-toggle"></span>
      </button>
      <a class="navbar-brand" href="#">UNSW Book</a>
    </div>
    <div class="navbar-collapse collapse">
	    <div class="col-sm-3 col-md-3">
	     	<form class="navbar-form" role="search" action="API">
	        <input type="hidden" name="action" value="search">
	        <div class="input-group">
	            <input type="text" class="form-control" placeholder="Search" name="searchString">
	            <div class="input-group-btn">
	                <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></i></button>
	            </div>
	        </div>
	        </form>
	    </div>
      <ul class="nav navbar-nav navbar-right">
        
        <li class="dropdown">
          <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-user"></i> <%=userLoggedIn.getUser()%> <span class="caret"></span></a>
          <ul id="g-account-menu" class="dropdown-menu" role="menu">
            <li><a href="#">My Profile</a></li>
          </ul>
        </li>
        <li><a href="API?action=logout"><i class="glyphicon glyphicon-lock"></i> Logout</a></li>
      </ul>
    </div>
  </div><!-- /container -->
</div>
<!-- /Header -->

<!-- Main -->
<div class="container">
<div class="row">
    <div class="col-md-3">
      <!-- Left column -->
      <a href="#"><strong><i class="glyphicon glyphicon-wrench"></i> Navigation	</strong></a>  
      <ul class="list-unstyled">
        <li class="nav-header"> <a href="#" data-toggle="collapse" data-target="#userMenu">
          <h5>Settings <i class="glyphicon glyphicon-chevron-down"></i></h5>
          </a>
            <ul class="list-unstyled collapse in" id="userMenu">
                <li> <a href="home.jsp"><i class="glyphicon glyphicon-home"></i> Home</a></li>
                <li><a href="profile.jsp"><i class="glyphicon glyphicon-user"></i> Profile <span class="badge badge-info">4</span></a></li>
                <li><a href="friendslist.jsp"><i class="glyphicon glyphicon-user"></i> Friends</a></li>
                <li><a href="advancedSearch.jsp"><i class="glyphicon glyphicon-search"></i> Advanced Search</a></li>
            </ul>
        </li>
     </ul>
  	</div><!-- /col-3 -->
    <div class="col-md-9">
      	
      <!-- column 2 -->	
      <a href="#"><strong><i class="glyphicon glyphicon-dashboard"></i> My Wall</strong></a>  
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
					<%for (UserProfile p : profiles){ %>
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
                                     <div id='center' class='material-switch pull-right'>
                                         <input id='someSwitchOptionPrimary' name='someSwitchOption001i' type='checkbox' checked="true"/>
                                         <label for='someSwitchOptionPrimary' class='label-primary'></label>
                                     </div>
                                 </div>
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


  