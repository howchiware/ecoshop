package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.GongguInquiryManage;
import com.sp.app.admin.model.GongguReviewManage;

@Mapper
public interface GongguReviewInquiryManageMapper {
	public List<GongguReviewManage> findAllReviews() throws SQLException;
	public List<GongguInquiryManage> findAllInquirys() throws SQLException;
	public List<GongguReviewManage> findReviewsBySearch(Map<String, Object> map);
	public List<GongguInquiryManage> findInquirysBySearch(Map<String, Object> map);
	
	// 문의
	public void updateAnswer(GongguInquiryManage dto);
	public String answerNameFindById(long answerId);
	public void deleteAnswer(long gongguInquiryId);
	public void deleteInquiry(long gongguInquiryId);
		
	// 리뷰
	public void updateReviewAnswer(GongguReviewManage dto);
	public String reviewAnswerNameFindById(long answerId);
	public void deleteReviewAnswer(long gongguOrderDetailId);
	public void deleteReview(long gongguOrderDetailId);
		
	public int dataCountReview(Map<String, Object> map);
	public int dataCountInquiry(Map<String, Object> map);
	
}
