package models;

import java.util.ArrayList;
import java.util.Date;

public class WallPost {

	
	//R
	//https://www.tutorialspoint.com/jsp/jsp_file_uploading.htm
	
	private Long posterId;
	private String content;
	private Date date;
	
	private ArrayList<Integer> likedBy;
	
	
	//For image with post
	//Form deals with uploading image
	//private File image; // TODO: figure out which java file to use...
	private String imageURL;
	
	
	public WallPost(Long userId, String content) {
		posterId = userId;
		this.content = content;
		likedBy = new ArrayList<Integer>();
		date = new Date();
	}
	
	//Currently private methods.
	// Use: IsLikedBy() to determine what to show.
	// In both cases, run ToggleLike.
	// Shouldn't need to public-fy this, unless specific reasons.
	private void likePost(int liker) {
		likedBy.add(liker);
	}
	private void unlikePost(int liker) {
		likedBy.remove(Integer.valueOf(liker));
	}
	
	public Boolean isLikedBy(int liker) {
		if (likedBy.contains(liker)) {
			return true;
		}
		return false;
	}
	
	public void toggleLike (int liker) {
		if (isLikedBy(liker)) {
			unlikePost(liker);
		} else {
			likePost(liker);
		}
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
	
	public WallPost(Long uid, Boolean containsImg, String content) {
		posterId = uid;
	}
	public String ToStr() {
		return posterId.toString() + ": " + content;
	}
}
