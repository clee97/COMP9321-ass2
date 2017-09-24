package dao;

import java.util.List;
import models.*;

public interface UserPostDao {
	
	public List<UserPost> findPostsByUser(Long id);
	
	public List<Long> findLikersOfPost(Long postId);
	
	public UserPost findById(Long postId);
	
	public Boolean doesLikePostExist(Long userId, Long postId);
	
}
