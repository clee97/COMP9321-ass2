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
                <li><a href="#"><i class="glyphicon glyphicon-user"></i> Profile <span class="badge badge-info">4</span></a></li>
                <li><a href="friendslist.jsp"><i class="glyphicon glyphicon-user"></i> Friends</a></li>
            </ul>
        </li>
  	</div><!-- /col-3 -->
    <div class="col-md-9">
      	
      <!-- column 2 -->	
      <a href="#"><strong><i class="glyphicon glyphicon-user"></i> My Profile</strong></a>  
      	<hr>
		<div class="row">
			<div class="col-md-12">
			    <h1>Edit Profile</h1>
			  	<hr>
				<div class="row">
			      <!-- left column -->
			      <div class="col-md-3">
			        <div class="text-center">
			          <img src="dps/<%=userLoggedIn.getImgPath()%>" class="avatar img-circle" alt="avatar">
			          <h6>Upload a different photo...</h6>
			          <form action="API?action=uploadImage" enctype="multipart/form-data" method="POST">
			          	<input type="file" class="form-control" name="file">
			          	<br>
			          	<input type="submit" class="btn btn-primary" value="Upload">
			          </form>
			        </div>
			      </div>
			      
			      <!-- edit form column -->
			      <div class="col-md-9 personal-info">
			        <div class="alert alert-info alert-dismissable">
			          <a class="panel-close close" data-dismiss="alert">×</a> 
			          <i class="fa fa-coffee"></i>
			          Please do not leave any fields <strong>BLANK</strong>.
			        </div>
			        <%if (request.getAttribute("updateError") != null){ %>
			        <div class="alert alert-danger alert-dismissable">
			          <a class="panel-close close" data-dismiss="alert">×</a> 
			          <i class="fa fa-coffee"></i>
			          <%=request.getAttribute("updateError") %>
			        </div>
			        <%}else if (request.getAttribute("updateSuccess") != null){%>
    			    <div class="alert alert-success alert-dismissable">
			          <a class="panel-close close" data-dismiss="alert">×</a> 
			          <i class="fa fa-coffee"></i>
			          <%=request.getAttribute("updateSuccess") %>
			        </div>
			        <%} %>
			        <h3>Personal info</h3>
			        
			        <form class="form-horizontal" role="form" action="API">
			        	<input type="hidden" name="action" value="updateProfile">
			          <div class="form-group">
			            <label class="col-lg-3 control-label">First name:</label>
			            <div class="col-lg-8">
			              <input name="firstname" class="form-control" type="text" value="<%=userLoggedIn.getFirstname()%>" required>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-lg-3 control-label">Last name:</label>
			            <div class="col-lg-8">
			              <input name="lastname" class="form-control" type="text" value="<%=userLoggedIn.getLastname()%>"required>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-lg-3 control-label">Email:</label>
			            <div class="col-lg-8">
			              <input name="email"  class="form-control" type="text" value="<%=userLoggedIn.getEmail()%>" required>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-lg-3 control-label">Gender:</label>
			            <div class="col-lg-8">
			              <div class="ui-select">
			                <select name="gender"  id="gender" class="form-control" required>
			                  <option value="MALE" <%if (userLoggedIn.getGender().equals("MALE")){ %>selected="selected"<%}%>>MALE</option>
			                  <option value="FEMALE"<%if (userLoggedIn.getGender().equals("FEMALE")){ %>selected="selected"<%}%>>FEMALE</option>
			                </select>
			              </div>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-md-3 control-label">DOB:</label>
			            <div class="col-md-8">
			              <input name="dob" class="form-control" type="date" value="<%=userLoggedIn.getDob()%>" required>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-md-3 control-label">Password:</label>
			            <div class="col-md-8">
			              <input name="password" class="form-control" type="password" value="<%=userLoggedIn.getPass()%>" required>
			            </div>
			          </div>
			          <div class="form-group">
			            <label class="col-md-3 control-label"></label>
			            <div class="col-md-8">
			              <input type="submit" class="btn btn-primary" value="Save Changes">
			              <span></span>
			              <input type="reset" class="btn btn-default" value="Cancel">
			            </div>
			          </div>
			        </form>
			      </div>
			  </div>
			</div>
			<hr>
	 	 </div>
     </div><!--/row-->
      
  	</div><!--/col-span-9-->
</div>
<!-- /Main -->
</body>

