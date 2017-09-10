package impl;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import dao.UserProfileDao;
import models.UserProfile;

public class UserProfileDaoImpl implements UserProfileDao{
	
	private Statement statement;
	
	
	public UserProfileDaoImpl(){
		initConnection();
	}
	
	public static void main(String[] args) {
		UserProfileDaoImpl dao = new UserProfileDaoImpl();
		System.out.println(dao.findByUserAndPass("systemadmin", "admin").getFirstname());
	}
	
	/**
	 * Retrieves a user based on their username and password
	 */
	@Override
	public UserProfile findByUserAndPass(String user, String pass) {
		UserProfile profile = null;
		try {
			ResultSet results = statement.executeQuery("SELECT * FROM user_profile WHERE username = '" + user + "' AND password = '" + pass + "'");
			
			while(results.next()){
				profile = toUserProfile(results.getLong("id"), results.getString("usertype"), results.getString("username"), results.getString("password"), 
						results.getString("firstname"), results.getString("lastname"), results.getString("email"), results.getString("gender"), 
						results.getString("dob"), results.getString("status"), results.getString("imgpath"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return profile;
	}
	
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
	private void initConnection(){
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://sql12.freemysqlhosting.net/sql12193600", "sql12193600", "1HIwhLqCuh");
			statement = connection.createStatement();
		}
		catch(ClassNotFoundException ex) {
			ex.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	/**
	 * Closes connection and statement object after database use
	 * @param statement
	 */
	private void close(Statement statement){
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

	@Override
	public UserProfile findById(Long id) {
		UserProfile profile = null;
		try {
			ResultSet results = statement.executeQuery("SELECT * FROM user_profile WHERE id = " + id);
			
			while(results.next()){
				profile = toUserProfile(results.getLong("id"), results.getString("usertype"), results.getString("username"), results.getString("password"), 
						results.getString("firstname"), results.getString("lastname"), results.getString("email"), results.getString("gender"), 
						results.getString("dob"), results.getString("status"), results.getString("imgpath"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return profile;
	}

	@Override
	public UserProfile findByUser(String user) {
		UserProfile profile = null;
		try {
			ResultSet results = statement.executeQuery("SELECT * FROM user_profile WHERE user = '" + user + "'");
			
			while(results.next()){
				profile = toUserProfile(results.getLong("id"), results.getString("usertype"), results.getString("username"), results.getString("password"), 
						results.getString("firstname"), results.getString("lastname"), results.getString("email"), results.getString("gender"), 
						results.getString("dob"), results.getString("status"), results.getString("imgpath"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return profile;
	}
	
	private UserProfile toUserProfile(Long id, String userType, String user, String pass, String fname, String lname, String email, String gender, String dob, String status, String imgPath){
		UserProfile profile = new UserProfile();
		profile.setId(id);
		profile.setUserType(userType);
		profile.setUser(user);
		profile.setPass(pass);
		profile.setFirstname(fname);
		profile.setLastname(lname);
		profile.setEmail(email);
		profile.setGender(gender);
		profile.setDob(dob);
		profile.setStatus(status);
		profile.setImgPath(imgPath);
		return profile;
		
	}

}
