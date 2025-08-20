package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.model.GongguDeliveryRefundInfo;

public interface GongguManageService {
	// 공동구매 상품등록
	public void insertGongguProduct(GongguManage dto, String uploadPath) throws Exception;
	public void updateGongguProduct(GongguManage dto, String uploadPath) throws Exception;
	public void deleteGongguProduct(long gongguProductId, String pathString) throws Exception;
	public boolean deleteUploadFile(String uploadPath, String filename);
	
	public int dataCountGongguProduct(Map<String, Object> map);
	public GongguManage findById(long gongguProductId);
	
	public List<GongguManage> listProduct(Map<String, Object> map);
	public CategoryManage findByCategory(long categoryId);
	
	// 배송정책
	public GongguDeliveryRefundInfo listDeliveryRefundInfo();
	public List<GongguDeliveryRefundInfo> listDeliveryFee();
	public void insertProductDeliveryFee(Map<String, Object> map);
	public void insertProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void updateProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void deleteProductDeliveryFee();
}
