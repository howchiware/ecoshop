package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.ProductReview;
import com.sp.app.model.Summary;

public interface ProductReviewService {
	public int dataCount(Map<String, Object> map);
	public List<ProductReview> listReview(Map<String, Object> map);
	public Summary findByReviewSummary(Map<String, Object> map);
	public void insertReview(ProductReview dto, String uploadPath) throws Exception;
}
