package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.ProductReview;

public interface ProductReviewService {
	int dataCount(Map<String, Object> map);
	List<ProductReview> listReview(Map<String, Object> map);
}
