package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.ProductInquiryManage;
import com.sp.app.admin.model.ProductReviewManage;

@Mapper
public interface ProductReviewInquiryManageMapper {
	public List<ProductReviewManage> findAllReviews() throws SQLException;
	public List<ProductInquiryManage> findAllInquirys() throws SQLException;
	public List<ProductReviewManage> findReviewsBySearch(Map<String, Object> map);
	public List<ProductInquiryManage> findInquirysBySearch(Map<String, Object> map);
	
	// 문의
	public void updateAnswer(ProductInquiryManage dto);
	public String answerNameFindById(long answerId);
	public void deleteAnswer(long inquiryId);
	public void deleteInquiry(long inquiryId);
	
	// 리뷰
	public void updateReviewAnswer(ProductReviewManage dto);
	public String reviewAnswerNameFindById(long answerId);
	public void deleteReviewAnswer(long reviewId);
	public void deleteReview(long reviewId);
	
	
	public int dataCountReview(Map<String, Object> map);
	public int dataCountInquiry(Map<String, Object> map);
}
