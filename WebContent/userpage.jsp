<%@page import="dao.FriendRequestDao"%>
<%@page import="impl.FriendRequestDaoImpl"%>
<%@page import="impl.UserProfileDaoImpl"%>
<%@page import="models.UserProfile"%>
<%@page import="models.FriendRequest"%>
<%@page import="dao.UserProfileDao"%>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/home.css">
  <link rel="stylesheet" href="css/userpage.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="js/home.js"></script>
</head>
<body>
<% 
	if (session.getAttribute("loggedInUser") == null){
		response.sendRedirect("denied.jsp");
	}
	UserProfileDao userDao = new UserProfileDaoImpl();
	FriendRequestDao friendRequestDao = new FriendRequestDaoImpl();
	UserProfile profile = (UserProfile)request.getAttribute("user");
	UserProfile loggedInUser = (UserProfile)session.getAttribute("loggedInUser");
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
          <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-user"></i> <%=loggedInUser.getUser()%> <span class="caret"></span></a>
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
                <li><a href="#"><i class="glyphicon glyphicon-user"></i> Profile <span class="badge badge-info">4</span></a></li>
                <li><a href="friendslist.jsp"><i class="glyphicon glyphicon-user"></i> Friends</a></li>
        </li>
  	</div><!-- /col-3 -->
    <div class="col-md-9">
      	
      <!-- column 2 -->	
      <a href="#"><strong><i class="glyphicon glyphicon-dashboard"></i><%=profile.getFirstname() + " " + profile.getLastname()%>'s Wall</strong></a>  
      	<hr>
      	<div class="row" style="background:transparent center">
	      	<div class="col-md-10">
				<div class="profile-userpic">
					<img src="dps/<%=profile.getImgPath() %>" class="img-responsive" alt="">
				</div>
				<!-- END SIDEBAR USERPIC -->
				<!-- SIDEBAR USER TITLE -->
				<div class="profile-usertitle">
					<div class="profile-usertitle-name">
						<%=profile.getFirstname() + " " + profile.getLastname()%>
					</div>
					<div class="profile-usertitle-job">
						Developer
					</div>
				</div>
				<form action="API">
					<input type="hidden" name="action" value="sendFriendRequest">
					<input type="hidden" name="userId" value="<%=profile.getId()%>">
					<div class="profile-userbuttons">
						<%
						FriendRequest fr = friendRequestDao.findByFromTo(loggedInUser.getId(), profile.getId());
						if (fr == null){ %>
						<input type="submit" class="btn btn-success btn-sm" value="Send friend request">
						<%}else if (fr.getStatus().equals("PENDING")){ %>
						<button type="button" class="btn btn-success btn-sm">Pending friend request</button>
						<%}else{%>
						<button type="button" class="btn btn-success btn-sm">You are friends</button>
						<%} %>
					</div>
				</form>
			</div>
		</div>
      	
		<div class="row">
			<div class="media">
		  		<div class="media-body">
		    		<h4 class="media-heading"><img src="dps/default.jpg" class="img-thumbnail" alt="Cinque Terre" width="7%" height="7%"> <%=profile.getFirstname() + " " + profile.getLastname() %> Posted: </h4>
		          <p>Just a template for posts</p>
		          <ul class="list-inline list-unstyled">
		  			<li><span><i class="glyphicon glyphicon-calendar"></i> 1 days, 8 hours </span></li>
		            <li>|</li>
		            <span><i class="glyphicon glyphicon-comment"></i> 2 comments</span>
		            <li>|</li>
		            <li>
		            <!-- Use Font Awesome http://fortawesome.github.io/Font-Awesome/ -->
		              <span><i class="fa fa-facebook-square"></i></span>
		              <span><i class="fa fa-twitter-square"></i></span>
		              <span><i class="fa fa-google-plus-square"></i></span>
		            </li>
				</ul>
	       `	</div>
	    	</div>
	    	<div class="media">
		  		<div class="media-body">
		    		<h4 class="media-heading"><img src="dps/default.jpg" class="img-thumbnail" alt="Cinque Terre" width="7%" height="7%"> User posted</h4>
		          <p>Just a template for posts</p>
		          <ul class="list-inline list-unstyled">
		  			<li><span><i class="glyphicon glyphicon-calendar"></i> 1 days, 8 hours </span></li>
		            <li>|</li>
		            <span><i class="glyphicon glyphicon-comment"></i> 2 comments</span>
		            <li>|</li>
		            <li>
		            <!-- Use Font Awesome http://fortawesome.github.io/Font-Awesome/ -->
		              <span><i class="fa fa-facebook-square"></i></span>
		              <span><i class="fa fa-twitter-square"></i></span>
		              <span><i class="fa fa-google-plus-square"></i></span>
		            </li>
				</ul>
	       `	</div>
	    	</div>
		  </div>
      </div><!--/row-->
      
  	</div><!--/col-span-9-->
</div>
<!-- /Main -->
</body>


  