package models;

import java.util.List;

public class UserBullyRecord {

	private Long userId;
	
	private Long postId;
	
	private String bullyWordsUsed;

	public UserBullyRecord(){}
	
	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getPostId() {
		return postId;
	}

	public void setPostId(Long postId) {
		this.postId = postId;
	}

	public String getBullyWordsUsed() {
		return bullyWordsUsed;
	}

	public void setBullyWordsUsed(String bullyWordsUsed) {
		this.bullyWordsUsed = bullyWordsUsed;
	}
}
