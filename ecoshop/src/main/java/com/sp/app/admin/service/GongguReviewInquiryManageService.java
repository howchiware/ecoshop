package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.GongguInquiryManage;
import com.sp.app.admin.model.GongguReviewManage;

public interface GongguReviewInquiryManageService {
	public List<GongguReviewManage> getReviewList();
	public List<GongguInquiryManage> getInquiryList();
	public List<GongguReviewManage> searchReviews(Map<String, Object> map);
	public List<GongguInquiryManage> searchInquirys(Map<String, Object> map);
	
	public void updateAnswer(GongguReviewManage dto);
	public String answerNameFindById(long answerId);
	
	public void deleteAnswer(long gongguOrderDetailId);
	public void deleteReview(long gongguOrderDetailId);

}
