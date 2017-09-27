package models;

public class UserLike {
	
	private Long userId;
	
	private Long likesPostId;
	
	private String date;
	
	public UserLike(){}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getLikesPostId() {
		return likesPostId;
	}

	public void setLikesPostId(Long likesPostId) {
		this.likesPostId = likesPostId;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}
