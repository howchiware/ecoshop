package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.GongguProductInquiry;

public interface GongguProductInquiryService {
	public void insertGongguInquiry(GongguProductInquiry dto, String uploadPath) throws Exception;
	
	public int dataCountGonggu(Map<String, Object> map);
	public List<GongguProductInquiry> listGongguInquiry(Map<String, Object> map);
	
	public int myGongguDataCount(Map<String, Object> map);
	public List<GongguProductInquiry> listMyGongguInquiry(Map<String, Object> map);
	
	public void updateGongguInquiry(GongguProductInquiry dto) throws Exception;
	
	public void deleteGongguInquiry(long gongguInquiryId) throws Exception;
}
