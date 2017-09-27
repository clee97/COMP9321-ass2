<%@page import="models.FriendRequest"%>
<%@page import="java.util.List"%>
<%@page import="impl.FriendRequestDaoImpl"%>
<%@page import="dao.FriendRequestDao"%>
<%@page import="impl.UserProfileDaoImpl"%>
<%@page import="dao.UserProfileDao"%>
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
            UserProfile friend = userProfileDao.findById(fr.getToUser());
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
        <li><a href="API?action=logout">Log Out (<%=userLoggedIn.getUser()%>)<span class="sr-only">(current)</span></a></li>
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
                <li class="active"> <a href="home.jsp"><i class="glyphicon glyphicon-home"></i> Home</a></li>
                <li><a href="profile.jsp"><i class="glyphicon glyphicon-user"></i> Profile <span class="badge badge-info">4</span></a></li>
                <li><a href="friendslist.jsp"><i class="glyphicon glyphicon-user"></i> Friends</a></li>
                <li><a href="advancedSearch.jsp"><i class="glyphicon glyphicon-search"></i> Advanced Search</a></li>
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
			          <img src="dps/<%=userLoggedIn.getImgPath()%>" class="avatar img-circle" alt="avatar" width="45%" height="10%">
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

