package dao;

import java.util.List;

import models.UserBullyRecord;

public interface UserBullyReportDao {
	
	public List<UserBullyRecord> findUserBullyReports(Long userId);
}
