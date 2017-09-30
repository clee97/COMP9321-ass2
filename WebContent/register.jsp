<!DOCTYPE html>
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
<div class="container">
	<div class="row main">
		<div class="panel-heading">
              <div class="panel-title text-center">
              		<h1 class="title">UNSW Book</h1>
              		<hr />
              	</div>
           </div> 
		<div class="main-login main-center">
			<%if (request.getAttribute("registerError") != null){ %>
				<div class="alert alert-danger">
					<strong>Register Failed</strong> <%=(String)request.getAttribute("registerError") %>
				</div>
			<%} %>
			<form class="form-horizontal" method="post" action="API" name="register-form">
				<input type="hidden" name="action" value="register">
				<div class="form-group">
					<label for="email" class="cols-sm-2 control-label">Your Email</label>
					<div class="cols-sm-10">
						<div class="input-group">
							<span class="input-group-addon glyphicon glyphicon-envelope"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
							<input type="text" class="form-control" name="email" id="email"  placeholder="Enter your Email"/>
						</div>
					</div>
				</div>

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

				<div class="form-group">
					<label for="confirm" class="cols-sm-2 control-label">First Name</label>
					<div class="cols-sm-10">
						<div class="input-group">
							<span class="input-group-addon glyphicon glyphicon-user"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
							<input type="text" class="form-control" name="firstname" id="firstname"  placeholder="Enter your First Name"/>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="confirm" class="cols-sm-2 control-label">Last Name</label>
					<div class="cols-sm-10">
						<div class="input-group">
							<span class="input-group-addon glyphicon glyphicon-user"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
							<input type="text" class="form-control" name="lastname" id="lastname"  placeholder="Enter your Last Name"/>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="confirm" class="cols-sm-2 control-label">Gender</label>
					<div class="cols-sm-10">
						<div class="input-group">
							<span class="input-group-addon glyphicon glyphicon-user"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
							<select class="form-control" name="gender" id="lastname"  placeholder="Enter your Last Name">
								<option value="MALE">MALE</option>
								<option value="FEMALE">FEMALE</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="confirm" class="cols-sm-2 control-label">DOB</label>
					<div class="cols-sm-10">
						<div class="input-group">
							<span class="input-group-addon glyphicon glyphicon-calendar"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
							<input type="date" placeholder="YYYY-MM-DD" class="form-control" name="dob" id="dob">
						</div>
					</div>
				</div>
				<div class="form-group ">
					<input class="btn btn-primary btn-lg btn-block login-button" type="submit" value="Register">
				</div>
				<div class="login-register">
		            <a href="login.jsp">Login</a>
		         </div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
</body>

