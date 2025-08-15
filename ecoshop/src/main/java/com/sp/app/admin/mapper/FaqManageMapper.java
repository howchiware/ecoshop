package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.FaqManage;

@Mapper
public interface FaqManageMapper {
	
	public List<FaqManage> listFaq(Map<String, Object> map);
	public void insertFaq(FaqManage dto) throws SQLException;
	public void updateFaq(FaqManage dto) throws SQLException;
	public void deleteFaq(Map<String, Object> map) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public FaqManage findByFaq(Long faqId);

	public void insertCategory(FaqManage dto) throws SQLException;
	public List<FaqManage> listCategory(Map<String, Object> map);
	public void updateCategory(FaqManage dto) throws SQLException;
	public void deleteCategory(long categoryId) throws SQLException;
	
}
