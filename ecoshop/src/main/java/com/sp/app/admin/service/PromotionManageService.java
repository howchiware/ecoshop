package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.PromotionManage;

public interface PromotionManageService {
	
	public void insertPromotionManage(PromotionManage dto, String uploadPath) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<PromotionManage> listPromotionManage(Map<String, Object> map);

	public PromotionManage findById(long promotionId);
	public PromotionManage findByPrev(Map<String, Object> map);
	public PromotionManage findByNext(Map<String, Object> map);
	
	
	public void updatePromotionManage (PromotionManage dto, String uploadPath) throws Exception;
	public void deletePromotionManage (long promotionId, String uploadPath, String filename) throws Exception;
	
	public boolean deleteUploadFile(String uploadPath, String filename);
	
	
}
