package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.TimeZone;
import java.sql.Date;

/**
 * Servlet implementation class Admin
 * Is linked from WelcomePage servlet. 
 * Allows users to enter words to filter records. Brings users to Results servlet when submit button is clicked
 */
@WebServlet("/Admin")
public class AdminSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/** Returns response for GET requests.
	 * 	Generates HTML that allows users to enter words to filter records in text fields. 
	 *  Brings users to Results servlet when submit button is clicked
     * 
     * @param req			//this is the request given to Search servlet
     * @throws ServletException
     * @throws IOException
     */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		//java.util.Date utilDate = new java.util.Date();
	    //java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	    
	   // sqlDate = new java.sql.Date(row.getCell(23).getDateCellValue().getTime());
	    //Get current time:
	    /*Timestamp stamp = new Timestamp(System.currentTimeMillis());
        Date date = new Date(stamp.getTime());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-d");   //dd/MM/yyyy 
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+10"));
        String currDate = sdf.format(date);
        java.sql.Date curDate = java.sql.Date.valueOf(currDate);*/
	    
	   /* long timeInMillis = System.currentTimeMillis();
	    Calendar cal1 = Calendar.getInstance();
	    cal1.setTimeInMillis(timeInMillis);
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	    dateFormat.setTimeZone(TimeZone.getTimeZone("GMT+10"));
	    String a = dateFormat.format(cal1.getTime());
	    //java.sql.Timestamp curDate = java.sql.Timestamp.valueOf(a);
	        
	    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	    OffsetDateTime curDate = OffsetDateTime.parse(a, fmt);*/
	    
	    //java.sql.Date curDate = new java.sql.Date(System.currentTimeMillis());
		
		
		java.util.Date date = new java.util.Date();
        java.sql.Timestamp sqlTimeStamp = new java.sql.Timestamp(date.getTime());
        System.out.println("util-date:" + date);
        System.out.println("sql-timestamp:" + sqlTimeStamp );

        //System.out.println(curDate);
	    
/*		    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
	    LocalDateTime now = LocalDateTime.now();
	    Date currentDate = (Date)now;
	    java.sql.Date sqlDate = new java.sql.Date(dtf.format(now)); */
		
		
		resp.setContentType("text/html");

		PrintWriter out = resp.getWriter();

		String docType =
				"<!doctype html public \"-//w3c//dtd html 4.0 " + "transitional//en\">\n";

		out.println(docType +
				"<html>\n" +
				"<head><title>Search</title>" +
				"<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>" +
				"<link rel='stylesheet' href='css/home.css'>" +
				"<body bgcolor = \"#f0f0f0\">\n" +
				"<h1>Admin Portal</h1>" +	
				"<form id=\"searchForm\" action=\"AdminResults\" method=\"post\">" +
					"<hgroup>" +
						"<fieldset>" +
			   			 "<legend>User search:</legend>" +
		   			 	"<table>" +
			   			 	"<tr><td>First Name</td><td><input id=\"fNameField\" name=\"fNameField\" type=\"text\" style=\"display:block;\"/></td><td>Last Name</td><td><input id=\"lNameField\" name=\"lNameField\" type=\"text\" style=\"display:block;\"/></td></tr>" +
			   			 	"<tr><td>Username</td><td><input id=\"usernameField\" name=\"usernameField\" type=\"text\" style=\"display:block;\"/></td><td>Last Name</td><td><input id=\"lNameField\" name=\"lNameField\" type=\"text\" style=\"display:block;\"/></td></tr>" +
		   			 		"</table>" +			
		 			 	"<br>" +	
						"</fieldset>" +
				"</hgroup>" +		
					"<input id=\"clearBtn\" type=\"reset\" value=\"Clear\" />" +
					"<input id=\"searchBtn\" type=\"submit\" value=\"Search\" />" +
				"</form>"
				);
	}

	/** Returns response for POST requests.
	 * 	Passes POST request and response to doGet method
     * 
     * @param req			//this is the request given to Search servlet
     * @param resp			//this is the response returned to caller
     * @throws ServletException
     * @throws IOException
     */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
