package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.GongguProductInquiry;

@Mapper
public interface GongguProductInquiryMapper {
	public void insertInquiry(GongguProductInquiry dto) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<GongguProductInquiry> listInquiry(Map<String, Object> map);
	
	public int myDataCount(Map<String, Object> map);
	public List<GongguProductInquiry> listMyInquiry(Map<String, Object> map);
	
	public void updateInquiry(GongguProductInquiry dto) throws SQLException;

	public void deleteInquiry(long gongguInquiryId) throws SQLException;
}
