package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.FaqManage;

public interface FaqService {
	
	public List<FaqManage> listFaq(Map<String, Object> map);
	public FaqManage findByFaq(long faqId);
	public List<FaqManage> listCategory(Map<String, Object> map);
	
}
