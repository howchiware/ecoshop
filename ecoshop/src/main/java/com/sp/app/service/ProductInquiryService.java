package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.ProductInquiry;

public interface ProductInquiryService {
	public void insertInquiry(ProductInquiry dto, String uploadPath) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<ProductInquiry>listInquiry(Map<String, Object> map);
	
	public int dataCountManage(Map<String, Object> map);
	public List<ProductInquiry>listInquiryManage(Map<String, Object> map);
	
	public void updateInquiry(ProductInquiry dto) throws Exception;
	
	public void deleteInquiry(long num, String uploadPath) throws Exception;
}
