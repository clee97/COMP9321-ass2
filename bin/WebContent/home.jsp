<%@page import="impl.UserProfileDaoImpl"%>
<%@page import="dao.UserProfileDao"%>
<%@page import="impl.FriendRequestDaoImpl"%>
<%@page import="dao.FriendRequestDao"%>
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
	
	UserProfileDao userProfileDao = new UserProfileDaoImpl();
	FriendRequestDao friendRequestDao = new FriendRequestDaoImpl();
	List<FriendRequest> acceptedNotifs = friendRequestDao.findByAccepted(loggedInUser.getId());
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
      <form class="navbar-form navbar-left" action="API">
      	<input type="hidden" name="action" value="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search" name="searchString">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Notification (<b><%=acceptedNotifs.size() %></b>)</a>
          <ul class="dropdown-menu notify-drop">
            <div class="notify-drop-title">
            	<div class="row">
            		<div class="col-md-6 col-sm-6 col-xs-6">Notifications (<b><%=acceptedNotifs.size() %></b>)</div>
            		<div class="col-md-6 col-sm-6 col-xs-6 text-right"><a href="" class="rIcon allRead" data-tooltip="tooltip" data-placement="bottom" title="tümü okundu."><i class="fa fa-dot-circle-o"></i></a></div>
            	</div>
            </div>
            <!-- end notify title -->
            <!-- notify content -->
            <%for (FriendRequest fr : acceptedNotifs){ 
            UserProfile friend = userProfileDao.findById(fr.getToUser());
            %>
            <div class="drop-content">
            	<li>
            		<div class="col-md-3 col-sm-3 col-xs-3"><div class="notify-img"><img src="dps/<%=friend.getImgPath()%>" alt="" width ="100%" height="100%"></div></div>
            		<div class="col-md-9 col-sm-9 col-xs-9 pd-l0"><a href="API?action=viewUser&userId=<%=friend.getId()%>"><%=friend.getFirstname()%></a> has <a href="">Accepted your friend request</a> <a href="" class="rIcon"><i class="fa fa-dot-circle-o"></i></a>
            		
            		<hr>
            		<p class="time"><%=friend.getFirstname()%></p>
            		</div>
            	</li>
            </div>
            <%} %>
            <div class="notify-drop-footer text-center">
            	<a href=""><i class="fa fa-eye"></i> Your Notifications</a>
            </div>
          </ul>
        </li>
        <li><a href="API?action=logout">Log Out (<%=loggedInUser.getUser()%>)<span class="sr-only">(current)</span></a></li>
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
                <li><a href="advancedSearch.jsp"><i class="glyphicon glyphicon-search"></i> Advanced Search</a></li>
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
       <a class="panel-close close" data-dismiss="alert">Ã</a> 
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
		<% if (!wp.getImgPath().isEmpty()){ %>
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


  