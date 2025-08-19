package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.ProductReview;
import com.sp.app.model.Summary;

public interface ProductReviewService {
	int dataCount(Map<String, Object> map);
	List<ProductReview> listReview(Map<String, Object> map);
	Summary findByReviewSummary(Map<String, Object> map);
}
