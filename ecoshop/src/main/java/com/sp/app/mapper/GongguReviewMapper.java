package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.GongguReview;
import com.sp.app.model.GongguReviewHelpful;
import com.sp.app.model.GongguSummary;
@Mapper
public interface GongguReviewMapper {
	int dataCount(Map<String, Object> map);
	public List<GongguReview> listReview(Map<String, Object> map);
	public GongguSummary findByReviewSummary(Map<String, Object> map);

	public void insertReview(GongguReview dto) throws Exception;
	public void insertReviewPhoto(GongguReview dto) throws Exception;
	public GongguReview viewReviewDetail(long reviewId);
	
	public void deleteReviewHelpful(GongguReviewHelpful dto);
	public void insertReviewHelpful(GongguReviewHelpful dto);
	public int countReviewHelpful(long reviewId);
	public Integer userReviewHelpful(Map<String, Object> map);
	
	public int myDataCount(Map<String, Object> map);
	public List<GongguReview> listMyReview(Map<String, Object> map);
	
	public List<GongguReview>listReviewFile(long num);
	public void deleteReview(long num) throws SQLException;
}
