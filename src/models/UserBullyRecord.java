package models;

import java.util.List;

public class UserBullyRecord {

	private Long userId;
	
	private Long postId;
	
	private List<String> bullyWordsUsed;

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

	public List<String> getBullyWordsUsed() {
		return bullyWordsUsed;
	}

	public void setBullyWordsUsed(List<String> bullyWordsUsed) {
		this.bullyWordsUsed = bullyWordsUsed;
	}
}
