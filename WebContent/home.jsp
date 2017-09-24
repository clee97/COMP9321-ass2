<%@page import="dao.UserPostDao"%>
<%@page import="impl.UserPostDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="services.UserPostService"%>
<%@page import="models.*"%>
<%@page import="java.util.ArrayList"%>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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
	UserProfile loggedInUser = (UserProfile)session.getAttribute("loggedInUser");
	UserPostService userPostService = new UserPostService();
	UserPostDao userPostDao = new UserPostDaoImpl();
	List<UserPost> posts = userPostService.getUserPosts(loggedInUser.getId());
	
	//We need this for debugging maybe...
	//userLoggedIn = new UserProfile(true);
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
          <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-user"></i> <%=loggedInUser.getUser()%>  <span class="caret"></span></a>
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
    <div class="col-md-2">
      <!-- Left column -->
      <a href="#"><strong><i class="glyphicon glyphicon-wrench"></i> Navigation	</strong></a>  
      <ul class="list-unstyled">
        <li class="nav-header"> <a href="#" data-toggle="collapse" data-target="#userMenu">
          <h5>Settings <i class="glyphicon glyphicon-chevron-down"></i></h5>
          </a>
            <ul class="list-unstyled collapse in" id="userMenu">
                <li class="active"> <a href="home.jsp"><i class="glyphicon glyphicon-home"></i> Home</a></li>
                <li><a href="profile.jsp"><i class="glyphicon glyphicon-user"></i> Profile <span class="badge badge-info">4</span></a></li>
                <li><a href="friendslist.jsp"><i class="glyphicon glyphicon-user"></i> Friends</a></li>
             </ul>
        </li>
       </ul>
  	</div><!-- /col-3 -->
    <div class="col-md-9">
      	
	<!-- column 2 -->	
	<a href="#"><strong><i class="glyphicon glyphicon-dashboard"></i> My Wall</strong></a>
	<br><br><br>
	<!--  Post here -->
	<%if(request.getAttribute("postSuccess") != null){ %>
	<div class="alert alert-success alert-dismissable">
       <a class="panel-close close" data-dismiss="alert">×</a> 
       <i class="fa fa-coffee"></i>
       <%=request.getAttribute("postSuccess") %>
     </div>
     <%} %>
	<form action="API?action=postToWall" enctype="multipart/form-data" method="POST">
	<input type="hidden" name="action" value="postToWall" >
		<div class="panel panel-default">
		
		<div class="panel-body">
		<div class="form-horizontal">
		<div class="form-group">
		     <div class="col-md-9">
		         <textarea class="form-control" rows="3" placeholder="Post to your wall!" id="wallPostContent" name="wallPostContent"></textarea>
		         <input type="file" class="form-control" name="file">
		     </div>
		</div>
		</div>
		<button class="btn btn-primary" type="submit">
		Post to wall
		</button>

		</div>
		</div>
	</form>
      
	<!-- End Post here -->
	
	<% for (UserPost wp : posts) { 
		List<Long> likers = userPostDao.findLikersOfPost(wp.getId());
	%>
		
		<div class="panel panel-default">
		<div class="panel-body">
		 
		<h4 class="media-heading"><img src="dps/<%=loggedInUser.getImgPath()%>" class="img-thumbnail" alt="Cinque Terre" width="7%" height="7%"> You posted</h4>
		<p><%=wp.getContent() %></p>
		<% if (wp.getImgPath() != null){ %>
			<img src="pps/<%=wp.getImgPath()%>" class="img-thumbnail" width="30%" height="30%">
		<%} %>
		<hr />
		<i class="glyphicon glyphicon-calendar"></i> <%=wp.getDate() %><br>
		<i class="glyphicon glyphicon-thumbs-up"></i> <%=likers.size()%> likes
		 <a href="API?action=deletePost&postId=<%=wp.getId()%>" class="btn btn-primary a-btn-slide-text">
	       <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
           <span><strong>Delete</strong></span>            
   		 </a>
		</div>
		</div>
		
	<%} %>
      </div><!--/row-->
      
  	</div><!--/col-span-9-->
</div>
<!-- /Main -->

</body>


  