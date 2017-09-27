package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserProfileDao;
import impl.UserProfileDaoImpl;
import models.UserProfile;
import services.UNSWBookService;

/**
 * Servlet implementation class AdminResults
 * Shows table of maximum 10 headline links at a time. Users are able to view more if available by pressing next or previous link.
 * Clicking link goes to RecordDetail servlet.
 */
@WebServlet("/AdminResults")
public class AdminResults extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<UserProfile> records = null;	//stores all records parsed from XML
	private List<UserProfile> filteredRecords = null; //stores all records that matches user's filters
	private int currIndex = 0; //keeps track of current set of 10 records to show
	//private UNSWBookService unswBookService = new UNSWBookService();
	//private static UserProfileDao userDao = new UserProfileDaoImpl();
	
	/** Returns response for GET requests.
	 * 	Generates HTML that shows max of 10 headline links
	 * 
	 * @param req			//this is the request given to Results servlet
	 * @throws ServletException
	 * @throws IOException
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		resp.setContentType("text/html");

		PrintWriter out = resp.getWriter();
	
		
		String docType =
				"<!doctype html public \"-//w3c//dtd html 4.0 " + "transitional//en\">\n";

		out.println(docType +
				"<html>\n" +
				"<head><title>Home</title>" +				
				"<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>" +
				"<link rel='stylesheet' href='css/home.css'>" +
				"<body bgcolor = '#f0f0f0'>\n" +
				"<div class='menu'>" +
				"<a href='Admin' class='active'>Back to search</a>" +	//not /Admin or Admin.java
				"</div>");


		if(false){ //filteredRecords == null || filteredRecords.size() == 0){
			out.println("<h2>No matching users found!</h2>");
		}else { 
			//Print out head info
			out.print("<form id=\"hdLinkForm\" action=\"record_detail\" method=\"post\">" +
					"</table> " +
					"<table width = \"100%\" border = \"1\" align = \"center\">\n" +
					"<tr class=\"header\" bgcolor = \"#949494\">\n" +
					//Table header names
					"<th>Headline</th>\n"+
					"</tr>\n"
					);
		}
	}

	/** Returns response for POST requests.
	 * 	Either retrieves values from Search servlet's search fields or retrieve value fom next or previous link
	 * 
	 * @param req			//this is the request given to Results servlet
	 * @param resp			//this is the response returned to caller
	 * @throws ServletException
	 * @throws IOException
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int nextVal = 0, prevVal = 0;
		//Try to see is this post request is from clicking next or prev. 
		try {
			nextVal = Integer.parseInt(req.getParameter("nextVal"));
			prevVal = Integer.parseInt(req.getParameter("prevVal"));
		} catch (Exception e) {
		}
		//Saves values and updates currIndex if it is
		if(nextVal == 1) {
			currIndex +=10;
		} else if (prevVal == 1) {
			currIndex -=10;			
		}
		
		//retrieve search field info 
		String username= req.getParameter("usernameField").toString(); 
		
		String fNameField= req.getParameter("fNameField").toString(); 
		System.out.println("This is firsname: " + fNameField);
		String lNameField= req.getParameter("lNameField").toString(); 
		System.out.println("This is firsname: " + lNameField);
		
		

		//unswBookService.initConnection();
		//UserProfile taken = userDao.findByUser(taken.getUser());
		/*
		//this post request isnt from clicking next or prev. Its from search -> results (this page)
		if ((nextVal != 1 )) {
			if(prevVal != 1){
				currIndex = 0;
				String agency= req.getParameter("agencyField").toString(); 
				String headline= req.getParameter("headlineField").toString();

				filteredRecords = new ArrayList<UserProfile>();

				if(agency.isEmpty() && headline.isEmpty() && publishDate.isEmpty() && publishYear.isEmpty() && city.isEmpty()
						&& state.isEmpty() && content.isEmpty() && footerContent.isEmpty() && contact1.isEmpty() 
						&& contact2.isEmpty() && dateEntered.isEmpty() && enteredBy.isEmpty() && dateLastMod.isEmpty()
						&& lastModBy.isEmpty() && namedEntities.isEmpty() && keywords.isEmpty()) { //if all search fields are empty, then return full records
					filteredRecords = records;
				} 
		}*/
		doGet(req, resp);
	}

}
