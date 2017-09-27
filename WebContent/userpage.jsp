<%@page import="java.util.stream.Collectors"%>
<%@page import="impl.UserFriendDaoImpl"%>
<%@page import="dao.UserFriendDao"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserPostDao"%>
<%@page import="impl.UserPostDaoImpl"%>
<%@page import="models.UserPost"%>
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
	UserFriendDao userFriendDao = new UserFriendDaoImpl();
	FriendRequestDao friendRequestDao = new FriendRequestDaoImpl();
	UserPostDao userPostDao = new UserPostDaoImpl();
	
	UserProfile profile = (UserProfile)request.getAttribute("user");
	UserProfile loggedInUser = (UserProfile)session.getAttribute("loggedInUser");
	List<UserPost> userPosts = userPostDao.findPostsByUser(profile.getId());

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
            <div class="drop-content">
	           	<%for (FriendRequest fr : acceptedNotifs){ 
	            UserProfile friend = userDao.findById(fr.getToUser());
	            %>
            	<li>
            		<div class="col-md-3 col-sm-3 col-xs-3"><div class="notify-img"><img src="dps/<%=friend.getImgPath()%>" alt="" width ="100%" height="100%"></div></div>
            		<div class="col-md-9 col-sm-9 col-xs-9 pd-l0"><a href="API?action=viewUser&userId=<%=friend.getId()%>"><%=friend.getFirstname()%></a> has <a href="">Accepted your friend request</a> <a href="" class="rIcon"><i class="fa fa-dot-circle-o"></i></a>
            		
            		<hr>
            		<p class="time"><%=friend.getFirstname()%></p>
            		</div>
            	</li>
            	<%} %>
            </div>
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
						if (fr == null){ 
							List<Long> friends = userFriendDao.findUserFriendsIds(loggedInUser.getId());
							if (friends.contains(profile.getId())){
						%>
							<button type="button" class="btn btn-success btn-sm">You are friends</button>
							<%}else{ %>
							<input type="submit" class="btn btn-success btn-sm" value="Send friend request">
							<%} %>
						<%}else if (fr.getStatus().equals("PENDING")){ %>
						<button type="button" class="btn btn-success btn-sm">Pending friend request</button>
						<%}else{%>
						<button type="button" class="btn btn-success btn-sm">You are friends</button>
						<%} %>
					</div>
				</form>
			</div>
		</div>
      	<%
      	List<Long> friendIds = userFriendDao.findUserFriendsIds(loggedInUser.getId());
      	if (friendIds.contains(profile.getId())) {%>
      		<% if (userPosts.isEmpty()) {%>
      		<div class="jumbotron">
		      <div class="container">
		      <br>
		        <h2><%=profile.getFirstname() %><small> currently has no posts</small></h2>
		        <p>Try again later!</p>
		      </div>
		    </div>
		    <%} %>
			<% for (UserPost wp : userPosts) {
				List<Long> likers = userPostDao.findLikersOfPost(wp.getId());	
			%>
			
				<div class="panel panel-default">
					<div class="panel-body">
					 
					<h4 class="media-heading"><img src="dps/<%=profile.getImgPath()%>" class="img-thumbnail" alt="Cinque Terre" width="7%" height="7%"> You posted</h4>
					<%=wp.getContent() %>
					
					<hr />
					<i class="glyphicon glyphicon-calendar"></i> <%=wp.getDate() %><br>
					<i class="glyphicon glyphicon-thumbs-up"></i> <%=likers.size()%> likes
					<%if (!likers.contains(loggedInUser.getId())){ %>
					 <a href="API?action=likePost&postId=<%=wp.getId()%>&userId=<%=profile.getId()%>" class="btn btn-primary a-btn-slide-text">
			           <span><strong>Like</strong></span>
			   		 </a>
			   		 <%}else{ %>
			   		<a>You like this post</a>
			   		<a href="API?action=unLikePost&postId=<%=wp.getId()%>&userId=<%=profile.getId()%>" class="btn btn-primary a-btn-slide-text">
			           <span><strong>UnLike</strong></span>
			   		 </a>
			   		<%} %>
					</div>
				</div>
			
			<%} %>
		<%} else {%>
			<div class="jumbotron">
		      <div class="container">
		      <br>
		        <h2>You are not Friends<small> with this user</small></h2>
		        <p>You do not have access to view this user's posts</p>
		      </div>
		    </div>
	    <%} %>
			
			
      </div><!--/row-->
      
  	</div><!--/col-span-9-->
</div>
<!-- /Main -->
</body>


  