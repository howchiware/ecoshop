package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguDeliveryRefundInfo;

public interface GongguManageService {
	// 공동구매 상품등록
	public void insertGongguProduct(GongguManage dto, String uploadPath) throws Exception;
	public void updateGongguProduct(GongguManage dto, String uploadPath) throws Exception;
	public void deleteGongguProduct(List<Long> productId, String uploadPath) throws Exception;
	public boolean deleteUploadFile(String uploadPath, String filename);
	
	public int dataCountGongguProduct(Map<String, Object> map);
	public GongguManage findById(long gongguProductId);
	
	public List<GongguManage> listProduct(Map<String, Object> map);
	
	public GongguManage findByCategory(long categoryId);
	public List<GongguManage> listCategory();
	
	public List<GongguManage> listProductPhoto(long gongguProductId);
	public void deleteProductPhoto(long gongguProductId, String uploadPath) throws Exception;
	public void insertProductPhoto(GongguManage dto, String uploadPath) throws SQLException;
	public boolean deleteUploadPhoto(String uploadPath, String detailPhoto);
	
	
	// 배송정책
	public GongguDeliveryRefundInfo listDeliveryRefundInfo();
	public List<GongguDeliveryRefundInfo> listDeliveryFee();
	public void insertProductDeliveryFee(Map<String, Object> map);
	public void insertProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void updateProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void deleteProductDeliveryFee();
}
