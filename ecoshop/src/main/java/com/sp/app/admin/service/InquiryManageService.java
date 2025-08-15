package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.InquiryManage;

public interface InquiryManageService {
	
	public List<InquiryManage> listInquiry(Map<String, Object> map);
	public void updateInquiry(InquiryManage dto) throws Exception;

	public int dataCount(Map<String, Object> map);	
	public InquiryManage findByInquiry(long faqId);
	
	public List<InquiryManage> listCategory(Map<String, Object> map);
	public void insertCategory(InquiryManage dto) throws Exception;
	public void updateCategory(InquiryManage dto) throws Exception;
	public void deleteCategory(long categoryId) throws Exception;
	
	
	
}
