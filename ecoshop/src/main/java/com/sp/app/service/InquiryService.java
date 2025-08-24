package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.InquiryManage;
import com.sp.app.model.Inquiry;

public interface InquiryService {
	
	public List<Inquiry> listInqByMember(Map<String, Object> map);
	public Inquiry findByInq(long inquiryId);
	public void insertInq(Inquiry dto) throws Exception;
	public void updateInq(Inquiry dto) throws Exception;
	public void deleteInq(Inquiry dto) throws Exception;
	public Inquiry findByInq(Long inquiryId);
	public List<InquiryManage> listCategory(Map<String, Object> map); 
	public int dataCount(Map<String, Object> map);
	
}
