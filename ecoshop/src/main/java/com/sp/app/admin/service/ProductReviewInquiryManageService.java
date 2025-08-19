package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.ProductInquiryManage;
import com.sp.app.admin.model.ProductReviewManage;

public interface ProductReviewInquiryManageService {
	public List<ProductReviewManage> getReviewList();
	public List<ProductInquiryManage> getInquiryList();
	public List<ProductReviewManage> searchReviews(Map<String, Object> map);
	public List<ProductInquiryManage> searchInquirys(Map<String, Object> map);
	
	public void updateAnswer(ProductInquiryManage dto);
	public String answerNameFindById(long answerId);
	
	public void deleteAnswer(long inquiryId);
	public void deleteInquiry(long inquiryId);
}
