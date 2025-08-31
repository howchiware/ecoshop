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
	
	// 문의
	public void updateAnswer(GongguInquiryManage dto);
	public String answerNameFindById(long answerId);
	public void deleteAnswer(long gongguInquiryId);
	public void deleteInquiry(long gongguInquiryId);
	
	// 리뷰
	public String reviewAnswerNameFindById(long answerId);
	public void deleteReviewAnswer(long gongguOrderDetailId);
	public void deleteReview(long gongguOrderDetailId);
	public void updateReviewAnswer(GongguReviewManage dto);
	
	public int dataCountReview(Map<String, Object> map);
	public int dataCountInquiry(Map<String, Object> map);

}
