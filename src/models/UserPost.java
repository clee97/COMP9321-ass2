package models;

public class UserPost {

	private Long id;
	private Long posterId;
	private String content;
	private String date;
	private String imgPath;
	
	public UserPost() {}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}


	public Long getPosterId() {
		return posterId;
	}


	public void setPosterId(Long posterId) {
		this.posterId = posterId;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getImgPath() {
		return imgPath;
	}


	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}


	public String ToStr() {
		return posterId.toString() + ": " + content;
	}
}
