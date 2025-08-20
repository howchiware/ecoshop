package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.ProductReview;
import com.sp.app.model.Summary;

@Mapper
public interface ProductReviewMapper {
	int dataCount(Map<String, Object> map);
	public List<ProductReview> listReview(Map<String, Object> map);
	public Summary findByReviewSummary(Map<String, Object> map);

	public void insertReview(ProductReview dto) throws Exception;
	public void insertReviewPhoto(ProductReview dto) throws Exception;
}
