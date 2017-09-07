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
		dao.findByUserAndPass("systemadmin", "admin");
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
				profile = new UserProfile();
				profile.setId(results.getLong("id"));
				profile.setUser(results.getString("username"));
				profile.setPass(results.getString("password"));
				profile.setUserType(results.getString("userType"));
				profile.setFirstname(results.getString("firstname"));
				profile.setLastname(results.getString("lastname"));
				profile.setEmail(results.getString("email"));
				profile.setGender(results.getString("gender"));
				profile.setStatus(results.getString("status"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			 try{
				if(statement != null){
					statement.close();
				}
			}catch(SQLException se2){}
		}
		return profile;
	}
	
	/**
	 * For initialising mysql database connection
	 */
	private void initConnection(){
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost/webappdb", "root", "password");
			statement = connection.createStatement();
		}
		catch(ClassNotFoundException ex) {
			ex.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try{
				if (connection != null){
					connection.close();
				}
			}catch(SQLException se){
				se.printStackTrace();
			}
		}
	}

}
