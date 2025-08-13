package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.ProductInquiry;

@Mapper
public interface ProductInquiryMapper {
	public void insertInquiry(ProductInquiry dto) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<ProductInquiry>listQuestion(Map<String, Object> map);
	
	public int dataCountManage(Map<String, Object> map);
	public List<ProductInquiry>listQuestionManage(Map<String, Object> map);
	
	public void updateQuestion(ProductInquiry dto) throws SQLException;

	public void deleteQuestion(long num) throws SQLException;
}
