package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.GongguReview;
import com.sp.app.model.GongguReviewHelpful;
import com.sp.app.model.GongguSummary;

public interface GongguProductReviewService {
	public int dataCount(Map<String, Object> map);
	public List<GongguReview> listGongguReview(Map<String, Object> map);
	public GongguSummary findByGongguReviewSummary(Map<String, Object> map);
	public void insertGongguReview(GongguReview dto, String uploadPath) throws Exception;
	public void deleteGongguReview(long gongguOrderDetailId, String uploadPath) throws Exception;
	public GongguReview viewGongguReviewDetail(long gongguOrderDetailId);
	
	public void deleteGongguReviewHelpful(GongguReviewHelpful dto);
	public void insertGongguReviewHelpful(GongguReviewHelpful dto);
	public int countGongguReviewHelpful(long gongguOrderDetailId);
	public Integer userReviewHelpful(Map<String, Object> map);
	
	public int myGongguDataCount(Map<String, Object> map);
	public List<GongguReview> listMyReview(Map<String, Object> map);
	
	public List<GongguReview> imgList(long gongguProductId);
}
