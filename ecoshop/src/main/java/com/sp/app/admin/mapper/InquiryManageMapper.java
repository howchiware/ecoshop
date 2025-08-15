package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.InquiryManage;

@Mapper
public interface InquiryManageMapper {
	
	public List<InquiryManage> listInquiry(Map<String, Object> map);
	public void updateInquiry(InquiryManage dto) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public InquiryManage findByInquiry(Long inquiryId);

	public void insertCategory(InquiryManage dto) throws SQLException;
	public List<InquiryManage> listCategory(Map<String, Object> map);
	public void updateCategory(InquiryManage dto) throws SQLException;
	public void deleteCategory(long categoryId) throws SQLException;
	
}
