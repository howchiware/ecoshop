package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.InquiryManage;
import com.sp.app.model.Inquiry;

@Mapper
public interface InqMapper {
	
	public void insertInq(Inquiry dto) throws SQLException;
	public void updateInq(Inquiry dto) throws SQLException;
	public void deleteInq(Inquiry dto) throws SQLException;
	public List<InquiryManage> listCategory(Map<String, Object> map); 
	public Inquiry findByInq(Long inquiryId);
	
	public List<Inquiry> listInqByMember(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
}
