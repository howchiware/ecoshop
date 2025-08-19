package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.ProductReview;

@Mapper
public interface ProductReviewMapper {
	int dataCount(Map<String, Object> map);
	public List<ProductReview> listReview(Map<String, Object> map);
}
