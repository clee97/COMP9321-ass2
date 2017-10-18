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
  <link rel="stylesheet" href="css/graph.js">
  <link rel="stylesheet" href="css/vis.min.js">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="js/home.js"></script>
  <script src="js/vis.min.js"></script>
</head>
<body>

<!-- Header -->
<nav class="navbar navbar-default">
  <div class="container-fluid">


    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
      	<li><a href="login.jsp"><b> <i class="glyphicon glyphicon-chevron-left">  </i>Go back to login</b><span class="sr-only"></span></a></li>
      	<li><a href="graph2.jsp"><b> <i class="glyphicon glyphicon-chevron-right">  </i>Graph visualisations</b><span class="sr-only"></span></a></li>
      </ul>

      
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>




<div style="text-align: center;">
Actual data set is large. This is a subset of our data.

</div>
<div class="col-xs-12" style="text-align: center;"><h2><u>Triplestore tables</u></h2>
<img src="${pageContext.request.contextPath}/tables.png" />
</div>





</body>


  