<%@page import="models.UserProfile"%>
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
	UserProfile userLoggedIn = (UserProfile)session.getAttribute("loggedInUser");
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
          <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-user"></i> <%=userLoggedIn.getUser()%>  <span class="caret"></span></a>
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
                <li class="active"> <a href="home.jsp"><i class="glyphicon glyphicon-home"></i> Home</a></li>
                <li><a href="profile.jsp"><i class="glyphicon glyphicon-user"></i> Profile <span class="badge badge-info">4</span></a></li>
                <li><a href="friendslist.jsp"><i class="glyphicon glyphicon-user"></i> Friends</a></li>
            </ul>
        </li>
  	</div><!-- /col-3 -->
    <div class="col-md-9">
      	
      <!-- column 2 -->	
      <a href="#"><strong><i class="glyphicon glyphicon-search"></i> Advanced Search</strong></a>  
      	<hr>
		<div class="row">
			<form method="GET" action="API">
				<input type="hidden" name="action" value="advancedSearch">
				<div class="form-group">
				  <label for="usr">Name:</label>
				  <input name="name" type="text" class="form-control" id="usr">
				</div>
				<div class="form-group">
				  <label for="gender">Gender:</label>
				  <select name="gender" class="form-control" name="gender" id="gender">
					<option value="MALE">MALE</option>
					<option value="FEMALE">FEMALE</option>
				  </select>
				</div>
				<div class="form-group">
				  <label for="dob">DOB:</label>
				  <input name="dob" type="date" class="form-control" id="dob">
				</div>
				<input class="btn btn-primary" type="submit" value="Search">
			</form>
	 	 </div>
     </div><!--/row-->
      
  	</div><!--/col-span-9-->
</div>
<!-- /Main -->
</body>


  