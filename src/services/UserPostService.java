package services;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.UserPostDao;
import dao.UserProfileDao;
import impl.UserPostDaoImpl;
import impl.UserProfileDaoImpl;
import models.UserPost;
import models.UserProfile;

public class UserPostService extends UNSWBookService {
	private static UserPostDao postDao = new UserPostDaoImpl();
	
	private static UserProfileDao userProfileDao = new UserProfileDaoImpl();
	
	private static ExtractorService extractorService;
	
	private static final String UPLOAD_DIRECTORY = System.getProperty("user.dir").replace("\\", "/") + "/WebContent/pps/";
	
	public UserPostService(){}
	
	public static void main(String[] args) {
		UserPostService s = new UserPostService();
		System.out.println(s.checkForBully("Callow, Campus, Capitulate, Captious, Case, Cautious, Challenge, Charges, Cheat, Childhood, Churlish, Coaches"));
	}
	public boolean postToWall(HttpServletRequest request, UserPost newPost) {
		initConnection();
		UserProfile loggedInUser = (UserProfile) request.getSession().getAttribute("loggedInUser");
		Long uid = loggedInUser.getId();
		
		List<String> bullyWords = checkForBully(newPost.getContent());
		String bullySql = null;
		Long autoId = null;
		try {
			ResultSet results = statement.executeQuery("SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'webappdb' AND TABLE_NAME = 'user_post'");
			results.next();
			autoId = results.getLong("AUTO_INCREMENT");
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		if (!bullyWords.isEmpty()){
			bullySql = "INSERT INTO user_bully_report (user_id, post_id, bully_words) "
					+ "VALUES ('" + uid + "', '" + autoId + "', '" + bullyWords + "')";
			
			EmailService.sendBullyWarning(loggedInUser, bullyWords);
		}
		String sql = "INSERT INTO user_post (id, user_id, post, date, imgpath) "
				+ "VALUES (null, '" + uid + "', '" + newPost.getContent() + "', '" + newPost.getDate() 
				+ "', '" + newPost.getImgPath() + "')";
		
		try {
			statement.executeUpdate(sql);
			if (bullySql != null){
				statement.executeUpdate(bullySql);
			}
			request.setAttribute("postSuccess", "Your message has been posted!");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
	}
	
	private List<String> checkForBully(String content){
		List<String> caught = new ArrayList<String>();
		try {
			List<String> bullyWords = extractorService.bullyWordsDictionary();
			List<String> keyWords = extractorService.extractKeywords(content);
			for (String b : bullyWords){
				if (keyWords.contains(b.trim())){
					caught.add(b);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return caught;
	}
	
	public List<Long> GetLikers(HttpServletRequest request, UserPost post) {
	
		return postDao.findLikersOfPost(post.getId());
	}
	
	public boolean LikePost(HttpServletRequest request, UserPost postToLike) {
		initConnection();
		UserProfile loggedInUser = (UserProfile) request.getSession().getAttribute("loggedInUser");
		request.setAttribute("user", userProfileDao.findById(Long.parseLong(request.getParameter("userId")))); 
		
		Long uid = loggedInUser.getId();
		Long postId = postToLike.getId();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentDate = format.format(new Date());
		
		String sql = "INSERT INTO user_like (user_id, like_post, date) "
				+ "VALUES (" + uid + ", '" + postId + "', '" + currentDate + "')";
		try {
			statement.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
	}
	public boolean UnlikePost(HttpServletRequest request, UserPost postToUnlike) {
		initConnection();
		UserProfile loggedInUser = (UserProfile) request.getSession().getAttribute("loggedInUser");
		request.setAttribute("user", userProfileDao.findById(Long.parseLong(request.getParameter("userId"))));
		
		Long uid = loggedInUser.getId();
		Long postId = postToUnlike.getId();
		
		if (! postDao.doesLikePostExist(uid, postId)) {
			return true;
		}
		
		String sql = "DELETE FROM user_like WHERE "
				+ "user_id = " + uid + " AND like_post = " + postId;
		try {
			statement.executeUpdate(sql);			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
	}
	
	public boolean deletePost(HttpServletRequest request, Long postId){
		initConnection();
		String sql = "DELETE FROM user_post WHERE id = " + postId;
		
		UserPost post = postDao.findById(postId);
		File file = new File("WebContent/pps/" + post.getImgPath());
		file.delete();
		try {
			statement.executeUpdate(sql);
			statement.execute("DELETE FROM user_like WHERE like_post = " + postId );
			statement.execute("DELETE FROM user_bully_report WHERE post_id = " + postId );
			request.setAttribute("postSuccess", "Your post has been deleted!");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return true;
	}
	
	public List<UserPost> getUserPosts(Long id){
		return postDao.findPostsByUser(id);
	}
	
	public UserPost findById(Long postId){
		return postDao.findById(postId);
	}
	
	public void postToWall(HttpServletRequest request){
		UserProfile loggedInUser = (UserProfile)request.getSession().getAttribute("loggedInUser");
		
		Long uid = loggedInUser.getId();

		Random rand = new Random();
		Integer imgId = rand.nextInt(999999999);
		UserPost newPost = new UserPost();
		
		
		if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
              
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                    	if (!item.getString().isEmpty()){
	                    	String location = UPLOAD_DIRECTORY + imgId + ".jpg";
	                    	newPost.setImgPath(imgId + ".jpg");
	                        item.write( new File(location));
                    	}else{
                    		newPost.setImgPath("");
                    	}
                    }else{
                    	String fieldName = item.getFieldName();
                    	String fieldValue = item.getString();
                    	if (fieldName.equals("wallPostContent")){
                    		newPost.setContent(fieldValue);
                    	}
                    }
                }
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        		newPost.setDate(format.format(new Date()));
        		newPost.setPosterId(uid);
        		postToWall(request, newPost);
                
            } catch (Exception ex) {
              ex.printStackTrace();
            }          
         
        }else{
            request.setAttribute("updateError", "Sorry this form only handles file upload request");
        }
	}

}
