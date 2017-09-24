package dao;

import java.util.List;
import models.*;

public interface UserPostDao {
	
	public List<UserPost> findPostsByUser(Long id);
	
	public Boolean doesLikePostExist(Long userId, Long postId);
	
}
