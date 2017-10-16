<%@page import="com.mysql.jdbc.UpdatableResultSet"%>
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
	UserProfileDao userDao = new UserProfileDaoImpl();
	UserPostDao userPostDao = new UserPostDaoImpl();
	UserProfile loggedInUser = (UserProfile)session.getAttribute("loggedInUser");
	UserProfile user = (UserProfile)request.getAttribute("user");
	List<UserPost> userPosts = (List<UserPost>)request.getAttribute("userPosts");
	List<UserLike> userLikes = (List<UserLike>)request.getAttribute("userLikes");
	List<UserFriend> userFriends = (List<UserFriend>)request.getAttribute("userFriends");
	List<UserBullyRecord> userBullyReport = (List<UserBullyRecord>)request.getAttribute("userBullyReport");
	
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
      <ul class="nav navbar-nav navbar-right">
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
	                <li class="active"> <a href="adminHome.jsp"><i class="glyphicon glyphicon-home"></i>Admin Home</a></li>
	             </ul>
	        </li>
	       </ul>
	  	</div><!-- /col-3 -->
	    <div class="col-md-9">
			<!-- column 2 -->	
			<a href="#"><strong><i class="glyphicon glyphicon-dashboard"></i>User report for</strong></a>
			<br><br><br>
			<div class="row">
		        <div class="col-lg-15">
		            <h3>User overview</h3>
		        </div>
		    </div>
		    <div class="row">
		        <div class="col-lg-15">
		            <table class="table" id="table">
		                <thead>
		                    <tr>
		                        <th>User ID</th>
		                        <th>Username</th>
		                        <th>Firstname</th>
		                        <th>Lastname</th>
		                        <th>Email</th>
		                        <th>Account status</th>
		                        <th>Date joined</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr>
		                        <td><%=user.getId() %></td>
		                        <td><%=user.getUser() %></td>
		                        <td><%=user.getFirstname() %></td>
		                        <td><%=user.getLastname() %></td>
		                        <td><%=user.getEmail() %></td>
		                        <td><%=user.getStatus() %></td>
		                        <td><%=user.getDateJoined() %></td>
		                    </tr>
		                </tbody>
		            </table>
		            <hr>
		        </div>
		    </div>
		    
		    <div class="row">
		        <div class="col-lg-15">
		            <h3>Post activities</h3>
		        </div>
		    </div>
		    <div class="row">
		        <div class="col-lg-15">
		            <table class="table" id="table">
		                <thead>
		                    <tr>
		                        <th>Post ID</th>
		                        <th>Content</th>
		                        <th>Date posted</th>
		                    </tr>
		                </thead>
		                <tbody>
            		    <%if (userPosts.isEmpty()) {%>
		                <strong><i class="glyphicon glyphicon-dashboard"></i>No activities yet</strong>
		                <%} %>
		                <%for (UserPost up : userPosts){ %>
		                    <tr>
		                        <td><%=up.getId() %></td>
		                        <td><%=up.getContent() %></td>
		                        <td><%=up.getDate()%></td>
		                    </tr>
	                    <%} %>
		                </tbody>
		            </table>
		            <hr>
		        </div>
		    </div>
		    
   		    <div class="row">
		        <div class="col-lg-15">
		            <h3>Like activities</h3>
		        </div>
		    </div>
		    <div class="row">
		        <div class="col-lg-15">
		            <table class="table" id="table">
		                <thead>
		                    <tr>
		                        <th>Post ID</th>
		                        <th>Post owner</th>
		                        <th>Date liked</th>
		                    </tr>
		                </thead>
		                <tbody>
            		    <%if (userLikes.isEmpty()) {%>
		                <strong><i class="glyphicon glyphicon-dashboard"></i>No activities yet</strong>
		                <%} %>
		                <%for (UserLike ul : userLikes){ %>
		                    <tr>
		                        <td><%=ul.getLikesPostId() %></td>
		                        <td><%=userPostDao.findById(ul.getLikesPostId()).getPosterId()%></td>
		                        <td><%=ul.getDate()%></td>
		                    </tr>
	                    <%} %>
		                </tbody>
		            </table>
		            <hr>
		        </div>
		    </div>
		    
   		    <div class="row">
		        <div class="col-lg-15">
		            <h3>Friend activities</h3>
		        </div>
		    </div>
		    <div class="row">
		        <div class="col-lg-15">
		            <table class="table" id="table">
		                <thead>
		                    <tr>
		                        <th>Description</th>
		                        <th>Date</th>
		                    </tr>
		                </thead>
		                <tbody>
		                <%if (userFriends.isEmpty()) {%>
		                <strong><i class="glyphicon glyphicon-dashboard"></i>No activities yet</strong>
		                <%} %>
		                <%for (UserFriend uf : userFriends){ %>
		                    <tr>
		                    	<td>Made friends with <%=userDao.findById(uf.getUserId2()).getFirstname() %></td>
		                        <td><%=uf.getDate() %></td>
		                    </tr>
	                    <%} %>
		                </tbody>
		            </table>
		            <hr>
		        </div>
		    </div>
		    
    		<div class="row">
		        <div class="col-lg-15">
		            <h3>Bully Report</h3>
		        </div>
		    </div>
		    <div class="row">
		        <div class="col-lg-15">
		            <table class="table" id="table">
		                <thead>
		                    <tr>
		                        <th>Post ID</th>
		                        <th>Bully words used</th>
		                    </tr>
		                </thead>
		                <tbody>
		                <%if (userBullyReport.isEmpty()) {%>
		                <strong><i class="glyphicon glyphicon-dashboard"></i>This account is clean</strong>
		                <%} %>
		                <%for (UserBullyRecord ubr : userBullyReport){ %>
		                    <tr>
		                    	<td><%=ubr.getPostId() %></td>
		                        <td><%=ubr.getBullyWordsUsed()%></td>
		                        <td>
		                    </tr>
	                    <%} %>
		                </tbody>
		            </table>
		            <hr>
		        </div>
		    </div>
	    </div><!--/row-->
      
 	</div><!--/col-span-9-->
</div>
<!-- /Main -->

</body>


  