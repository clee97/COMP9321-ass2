<!DOCTYPE html>
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
	List<UserProfile> profiles = (List<UserProfile>)request.getAttribute("results");
	UserProfile userLoggedIn = (UserProfile)request.getSession().getAttribute("loggedInUser");

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
	        <form class="navbar-form" role="search">
	        <div class="input-group">
	            <input type="text" class="form-control" placeholder="Search" name="q">
	            <div class="input-group-btn">
	                <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></i></button>
	            </div>
	        </div>
	        </form>
	    </div>
      <ul class="nav navbar-nav navbar-right">
        
        <li class="dropdown">
          <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-user"></i> Admin <span class="caret"></span></a>
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
                <li class="active"> <a href="#"><i class="glyphicon glyphicon-home"></i> Home</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-user"></i> Profile <span class="badge badge-info">4</span></a></li>
                <li><a href="#"><i class="glyphicon glyphicon-user"></i> Friends</a></li>
        </li>
  	</div><!-- /col-3 -->
    <div class="col-md-9">
      	
      <!-- column 2 -->	
      <a href="#"><strong><i class="glyphicon glyphicon-dashboard"></i> My Wall</strong></a>  
      	<hr>
		<div class="row">
			<hgroup class="mb20">
				<h1>Search Results</h1>
				<h2 class="lead"><strong class="text-danger">3</strong> results were found for the search for <strong class="text-danger">Lorem</strong></h2>								
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

                     <li class="list-group-item">
                         <div class='row'>
                             <div class='col-md-12'>
                                 <div class='media-left media-middle'>
                                     <a href='#'>
                                         <img class='media-object img-circle' src='http://placehold.it/40x40'>
                                     </a>
                                 </div>
                                 <div id='center'>
                                     Favorite Person #1
                                     <div id='center' class='material-switch pull-right'>
                                         <input id='someSwitchOptionPrimary' name='someSwitchOption001i' type='checkbox' checked="true"/>
                                         <label for='someSwitchOptionPrimary' class='label-primary'></label>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </li>
                  </ul>
		</div>
      </div><!--/row-->
      
  	</div><!--/col-span-9-->
</div>
<!-- /Main -->

<footer class="text-center">This Bootstrap 3 dashboard layout is compliments of <a href="http://www.bootply.com/85850"><strong>Bootply.com</strong></a></footer>

<div class="modal" id="addWidgetModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">Add Widget</h4>
      </div>
      <div class="modal-body">
        <p>Add a widget stuff here..</p>
      </div>
      <div class="modal-footer">
        <a href="#" data-dismiss="modal" class="btn">Close</a>
        <a href="#" class="btn btn-primary">Save changes</a>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dalog -->
</div><!-- /.modal -->
</body>


  