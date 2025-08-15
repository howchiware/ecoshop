package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.FaqManage;

public interface FaqManageService {
	
	public List<FaqManage> listFaq(Map<String, Object> map);
	public void insertFaq(FaqManage dto) throws Exception;
	public void updateFaq(FaqManage dto) throws Exception;
	public void deleteFaq(Map<String, Object> map) throws Exception;

	public int dataCount(Map<String, Object> map);	
	public FaqManage findByFaq(long faqId);
	
	public List<FaqManage> listCategory(Map<String, Object> map);
	public void insertCategory(FaqManage dto) throws Exception;
	public void updateCategory(FaqManage dto) throws Exception;
	public void deleteCategory(long categoryId) throws Exception;
	
	
	
}
