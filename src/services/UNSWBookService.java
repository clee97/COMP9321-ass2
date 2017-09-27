package services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class UNSWBookService {

	protected static Statement statement;
	
	public UNSWBookService(){}
	
	/**
	 * Initialises mysql database connection
	 * 
	 * Go to freemysqlhosting.net and login with details
	 * User: unswbook@gmail.com
	 * Pass: unswbookpassword
	 * 
	 * To login admin console go to http://www.phpmyadmin.co and enter the following details 
	 * to view our database
	 * 
	 * Server: sql12.freemysqlhosting.net
	 * Name: sql12193600
	 * Username: sql12193600
	 * Password: 1HIwhLqCuh
	 * Port number: 3306
	 * 
	 */
	protected void initConnection(){
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://sql12.freemysqlhosting.net/sql12193600", "sql12193600", "1HIwhLqCuh");
			//connection = DriverManager.getConnection("jdbc:mysql://localhost/webappdb", "root", "password");
			statement = connection.createStatement();
		}
		catch(ClassNotFoundException ex) {
			ex.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * closes connection and statement after use
	 * @param statement
	 */
	protected void close(Statement statement){
		try{
			if (statement.getConnection() != null){
				statement.getConnection().close();
			}
		}catch(SQLException se){
			se.printStackTrace();
		}
		try{
			if(statement != null){
				statement.close();
			}
		}catch(SQLException se2){}
	}
}
