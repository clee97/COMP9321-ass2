<!DOCTYPE html>
<%@page import="models.UserProfile"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/results.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="js/login.js"></script>
</head>
<body>
<%
	List<UserProfile> profiles = (List<UserProfile>)request.getAttribute("results");
%>
<div class="container">
	<hgroup class="mb20">
		<h1>Search Results</h1>
		<h2 class="lead"><strong class="text-danger"><%=profiles.size() %></strong> results were found for the search for <strong class="text-danger">Lorem</strong></h2>								
	</hgroup>
	<br>
    <div class="row">
        <div class="panel panel-default widget">
            <div class="panel-heading">
                <span class="glyphicon glyphicon-user"></span>
                <h3 class="panel-title">
                    Users</h3>
                <span class="label label-info">
                    <%=profiles.size() %></span>
            </div>
            <%for (UserProfile p : profiles){ %>
            <div class="panel-body">
                <ul class="list-group">
                    <li class="list-group-item">
                        <div class="row">
                            <div class="col-xs-2 col-md-1">
                                <img src="dps/<%=p.getImgPath()%>" class="img-circle img-responsive" alt="" /></div>
                            <div class="col-xs-10 col-md-11">
                                <div>
                                    <a href="http://www.jquery2dotnet.com/2013/10/google-style-login-page-desing-usign.html">
                                        <%=p.getFirstname() %> <%=p.getLastname()%></a>
                                    <div class="mic-info">
                                        DOB: <%=p.getDob() %>
                                    </div>
                                    <div class="mic-info">
                                        Gender: <%=p.getGender() %>
                                    </div>
                                </div>	
                                <div class="action">
                                    <button type="button" class="btn btn-primary btn-xs" title="Edit">
                                        <span class="glyphicon glyphicon-plus"></span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
                <a href="#" class="btn btn-primary btn-sm btn-block" role="button"><span class="glyphicon glyphicon-refresh"></span> More</a>
            </div>
            <%} %>
        </div>
    </div>
</div>

</body>