<!DOCTYPE html>
<%@page import="models.UserProfile"%>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/login.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="js/login.js"></script>
</head>
<body>
<%
	//if session active then log us in automatically
	if (session.getAttribute("loggedInUser") != null){
		System.out.println("Logged in as: " + session.getAttribute("loggedInUser").toString() + ". Redirecting to home");
		UserProfile loggedInUser = (UserProfile)session.getAttribute("loggedInUser");
		if (loggedInUser.getUserType().equals("ADMIN")){
			response.sendRedirect("adminHome.jsp");
		}else{
			response.sendRedirect("home.jsp");
		}

	} else {
		System.out.println("Not logged in - display login page");
	}
%> 
<div class="container">
	<div class="row main">
		<div class="panel-heading">
              <div class="panel-title text-center">
              		<h1 class="title">UNSW Book</h1>
              		<hr />
              	</div>
           </div> 
		<div class="main-login main-center">
			<%if (request.getAttribute("loginError") != null){ %>
			<div class="alert alert-danger">
				<strong>Login Failed</strong> <%=(String)request.getAttribute("loginError") %>
			</div>
			<%} %>
			<form class="form-horizontal" method="post" action="API" id="login-form">
				<input type="hidden" name="action" value="login">
				<div class="form-group">
					<label for="username" class="cols-sm-2 control-label">Username</label>
					<div class="cols-sm-10">
						<div class="input-group">
							<span class="input-group-addon glyphicon glyphicon-user"><i class="fa fa-users fa" aria-hidden="true"></i></span>
							<input type="text" class="form-control" name="username" id="username"  placeholder="Enter your Username"/>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label for="password" class="cols-sm-2 control-label">Password</label>
					<div class="cols-sm-10">
						<div class="input-group">
							<span class="input-group-addon glyphicon glyphicon-lock"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
							<input type="password" class="form-control" name="password" id="password"  placeholder="Enter your Password"/>
						</div>
					</div>
				</div>
				
				<div class="form-group ">
					<input class="btn btn-primary btn-lg btn-block login-button" type="submit" value="Login">
				</div>
				<div class="login-register">
		            <a href="register.jsp">Register</a>
		         </div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
</body>

