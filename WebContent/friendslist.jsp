<!DOCTYPE html>
<%@page import="impl.UserProfileDaoImpl"%>
<%@page import="dao.UserProfileDao"%>
<%@page import="impl.UserFriendDaoImpl"%>
<%@page import="dao.UserFriendDao"%>
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
	UserFriendDao friendDao = new UserFriendDaoImpl();
	UserProfile loggedInUser = (UserProfile)session.getAttribute("loggedInUser");
	List<UserProfile> friends = friendDao.findUserFriends(loggedInUser.getId());
	
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
				<h1>Your Friends</h1>
				<h2 class="lead">You currently have <strong class="text-danger"><%=friends.size() %></strong> friends</h2>								
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
					<%for (UserProfile f : friends){ %>
                     <li class="list-group-item">
                         <div class='row'>
                             <div class='col-md-12'>
                                 <div class='media-left media-middle'>
                                     <a href='API?action=viewUser&userId=<%=f.getId()%>'>
                                         <img class='media-object img-circle' src='http://placehold.it/40x40'>
                                     </a>
                                 </div>
                                 <div id='center'>
                                     <%=f.getFirstname()%> <%=f.getLastname()%>
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


  