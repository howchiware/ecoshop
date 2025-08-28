package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.ProductReview;
import com.sp.app.model.ReviewHelpful;
import com.sp.app.model.Summary;

public interface ProductReviewService {
	public int dataCount(Map<String, Object> map);
	public List<ProductReview> listReview(Map<String, Object> map);
	public List<ProductReview> listReviewOnlyPhoto(Map<String, Object> map);
	public Summary findByReviewSummary(Map<String, Object> map);
	public void insertReview(ProductReview dto, String uploadPath) throws Exception;
	public void deleteReview(long reviewId, String uploadPath) throws Exception;
	public ProductReview viewReviewDetail(long reviewId);
	
	public void deleteReviewHelpful(ReviewHelpful dto);
	public void insertReviewHelpful(ReviewHelpful dto);
	public int countReviewHelpful(long reviewId);
	public Integer userReviewHelpful(Map<String, Object> map);
	
	public int myDataCount(Map<String, Object> map);
	public List<ProductReview> listMyReview(Map<String, Object> map);
	
	public List<ProductReview> imgList(long productCode);
}
