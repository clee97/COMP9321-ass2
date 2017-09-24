package models;

import java.util.ArrayList;
import java.util.Date;

public class UserPost {

	
	//R
	//https://www.tutorialspoint.com/jsp/jsp_file_uploading.htm
	
	private Long id;
	private Long posterId;
	private String content;
	private String date;
	
	private ArrayList<Long> likedBy;
	
	
	//For image with post
	//Form deals with uploading image
	private String imgPath;
	
	
	public UserPost(Long id, Long posterId, String content, String date) {
		this.id = id;
		posterId = posterId;
		this.content = content;
		likedBy = new ArrayList<Long>();
	}
	
	public void SetImgPath(String path) {
		imgPath = path;
	}
	
	public void AddLiker(Long id) {
		if (! likedBy.contains(id))
			likedBy.add(id);
	}
	
	private void RemoveLiker(Long id) {
		likedBy.remove(Long.valueOf(id));
	}
	
	public Boolean isLikedBy(Long id) {
		if (likedBy.contains(id)) {
			return true;
		}
		return false;
	}
	
	public Long getId() {
		return id;
	}
	public int getNumLikes() {
		return likedBy.size();
	}
	public String getContent() {
		return content;
	}
	public String getPosterStr() {
		return posterId.toString();
	}
	public String getDate() {
		return date.toString();
	}
	public String getImgPath() {
		return imgPath;
	}
	
	
	public UserPost(Long uid, Boolean containsImg, String content) {
		posterId = uid;
	}
	public String ToStr() {
		return posterId.toString() + ": " + content;
	}
}
