package impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.UserBullyReportDao;
import models.UserBullyRecord;

public class UserBullyReportDaoImpl extends UNSWDaoImpl implements UserBullyReportDao{

	@Override
	public List<UserBullyRecord> findUserBullyReports(Long userId) {
		initConnection();
		String sql = "SELECT * FROM user_bully_report WHERE user_id = " + userId;
		
		List<UserBullyRecord> report = new ArrayList<UserBullyRecord>();
		try {
			ResultSet results = statement.executeQuery(sql);
			while(results.next()){
				UserBullyRecord record = toBullyRecord(results.getLong("user_id"), results.getLong("post_id"), results.getString("bully_words"));
				report.add(record);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(statement);
		}
		return report;
	}
	
	private UserBullyRecord toBullyRecord(Long userId, Long postId, String bullyWords){
		UserBullyRecord record = new UserBullyRecord();
		record.setUserId(userId);
		record.setPostId(postId);
		record.setBullyWordsUsed(bullyWords);
		
		return record;
	}

}
