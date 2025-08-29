package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.ProductReview;
import com.sp.app.model.ReviewHelpful;
import com.sp.app.model.Summary;

@Mapper
public interface ProductReviewMapper {
	int dataCount(Map<String, Object> map);
	public List<ProductReview> listReview(Map<String, Object> map);
	public List<ProductReview> listReviewOnlyPhoto(Map<String, Object> map);
	public Summary findByReviewSummary(Map<String, Object> map);

	public void insertReview(ProductReview dto) throws Exception;
	public void insertReviewPhoto(ProductReview dto) throws Exception;
	public ProductReview viewReviewDetail(long reviewId);
	public ProductReview findReviewById(long reviewId);
	
	public void deleteReviewHelpful(ReviewHelpful dto);
	public void insertReviewHelpful(ReviewHelpful dto);
	public int countReviewHelpful(long reviewId);
	public Integer userReviewHelpful(Map<String, Object> map);
	
	public int myDataCount(Map<String, Object> map);
	public List<ProductReview> listMyReview(Map<String, Object> map);
	
	public List<ProductReview>listReviewFile(long num);
	public void deleteReview(long num) throws SQLException;
	
	public List<ProductReview> imgList(long productCode);
}
