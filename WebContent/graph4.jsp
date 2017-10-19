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
      </ul>

      
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>




<div style="text-align: center;">
Actual data set is large. This is a subset of our data.

</div>
<div class="col-xs-12" style="text-align: center;"><h2><u>Search for friends of user 'clee'</u></h2></div>


<div id="mynetwork" style="margin: auto;width: 80%; height:80%"></div>

<script type="text/javascript">
    // create an array with nodes
    var nodes = new vis.DataSet([
        {id: 1, label: 'userId: 1\nusername: clee', group:'important'},
        {id: 2, label: 'userId: 2\nusername: ttruong', group:'userGroup'},
        {id: 3, label: 'userId: 3\nusername: lmak', group:'userGroup'}
   
    ]);

    // create an array with edges
    var edges = new vis.DataSet([
        {from: 1, 
	       	to: 2, 
	       	label:"friendOf", 
	       	arrows: {
	       		to: true,
	       		from: true
	       	},
	       	length: 12
        	
        },
        {from: 2, 
	       	to: 3, 
	       	label:"friendOf", 
	       	arrows: {
	       		to: true,
	       		from: true
	       	},
	       	length: 12
        	
        },
        {from: 1, 
	       	to: 3, 
	       	label:"friendOf", 
	       	arrows: {
	       		to: true,
	       		from: true
	       	},
	       	length: 12
	       	
        	
        },
        {from: 1, 
	       	to: 4, 
	       	label:"posted", 
	       	arrows: {
	       		to: true,
	       		from: false
	       	},
	    },
        {from: 1, 
	       	to: 5, 
	       	label:"posted", 
	       	arrows: {
	       		to: true,
	       		from: false
	       	},
	    },
        {from: 2, 
	       	to: 6, 
	       	label:"posted", 
	       	arrows: {
	       		to: true,
	       		from: false
	       	},
        },
        {from: 3, 
	       	to: 7, 
	       	label:"posted", 
	       	arrows: {
	       		to: true,
	       		from: false
	       	},
        },
        {from: 3, 
	       	to: 8, 
	       	label:"posted", 
	       	arrows: {
	       		to: true,
	       		from: false
	       	},
        },
        {from: 3, 
	       	to: 9, 
	       	label:"posted", 
	       	arrows: {
	       		to: true,
	       		from: false
	       	},
        },
        {from: 1, 
	       	to: 6, 
	       	label:"likes", 
	       	arrows: {
	       		to: true,
	       		from: false
	       	},
        },
        {from: 3, 
	       	to: 6, 
	       	label:"likes", 
	       	arrows: {
	       		to: true,
	       		from: false
	       	},
        },
        {from: 2, 
	       	to: 4, 
	       	label:"likes", 
	       	arrows: {
	       		to: true,
	       		from: false
	       	},
        },
        {from: 2, 
	       	to: 5, 
	       	label:"likes", 
	       	arrows: {
	       		to: true,
	       		from: false
	       	},
        },
        
    ]);

    // create a network
    var container = document.getElementById('mynetwork');

    // provide the data in the vis format
    var data = {
        nodes: nodes,
        edges: edges
    };
    var options = {
    	manipulation:{
    		enabled: true,
    		addNode: true,
			deleteNode: true
    	},
    	edges:{
    		smooth:{
        		enabled: false	
        	},
        	length: 100
    	},
    	physics: false,
   		groups:{
   			important: {
   				color:{
   		    		background:'#662266', 
   		    		border: '#000000',
   		    		highlight: {
   		    			background: '#774477',
   		    			border: '#000000'
   		    		}
    			}, 
   		    	font:{color: '#ffffff'},
   		    	borderWidth: 1
   			},
   		    userGroup: {
   		    	color:{
   		    		background:'#777777', 
   		    		border: '#000000',
   		    		highlight: {
   		    			background: '#999999',
   		    			border: '#000000'
   		    		}
    			}, 
   		    	font:{color: '#ffffff'},
   		    	borderWidth: 1
  		    },
  		  postGroup: {
  			color:{
	    		background:'#007700', 
	    		border: '#000000',
	    		highlight: {
	    			background: '#449944',
	    			border: '#000000'
	    		}
			}, 
	    	font:{color: '#ffffff'},
	    	borderWidth: 1
  		  }
 		}
	 };

    // initialize your network!
    var network = new vis.Network(container, data, options);
</script>


</body>


  