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
	UserProfile loggedInUser = (UserProfile)session.getAttribute("loggedInUser");
	List<UserProfile> adminResults = (List<UserProfile>)request.getAttribute("adminResults");
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
			<a href="#"><strong><i class="glyphicon glyphicon-dashboard"></i>Admin search</strong></a>
			<br><br><br>
			<div class="row">
		        <div class="col-lg-15">
		            <h3>Search results</h3>
		        </div>
		    </div>
		    <%if (request.getAttribute("error") != null){ %>
	        <div class="alert alert-danger alert-dismissable">
	          <a class="panel-close close" data-dismiss="alert">×</a> 
	          <i class="fa fa-coffee"></i>
	          <%=request.getAttribute("error") %>
	        </div>
	        <%} %>
    		<%if (request.getAttribute("success") != null){ %>
	        <div class="alert alert-success alert-dismissable">
	          <a class="panel-close close" data-dismiss="alert">×</a> 
	          <i class="fa fa-coffee"></i>
	          <%=request.getAttribute("success") %>
	        </div>
	        <%} %>
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
		                        <th>User report</th>
		                    </tr>
		                </thead>
		                <tbody>
		                	<%for (UserProfile profile : adminResults){ %>
		                    <tr>
		                    	<form action="APIAdmin" method="GET">
		                    		<input type="hidden" name="userId" value="<%=profile.getId() %>">
		                    		<input type="hidden" name="searchString" value="<%=request.getParameter("searchString") %>">
			                        <td><%=profile.getId() %></td>
			                        <td><%=profile.getUser() %></td>
			                        <td><%=profile.getFirstname() %></td>
			                        <td><%=profile.getLastname() %></td>
			                        <td><%=profile.getEmail() %></td>
			                        <td><%=profile.getStatus() %></td>
			                        <%if (!userDao.findById(profile.getId()).getStatus().equals("BANNED")){%>
			                        <input type="hidden" name="adminAction" value="adminBan">
			                        <td><input class="btn btn-primary" type="submit" value="Ban user"></td>
			                        <%}else{ %>
			                        <input type="hidden" name="adminAction" value="adminUnban">
			                        <td><input class="btn btn-primary" type="submit" value="Unban user"></td>
			                        <%} %>
			                        <td><a href="APIAdmin?adminAction=userReport&userId=<%=profile.getId() %>">View user activities</a>
		                        </form>
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


  