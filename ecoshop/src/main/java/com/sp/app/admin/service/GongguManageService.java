package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguPackageManage;
import com.sp.app.admin.model.GongguProductDeliveryRefundInfoManage;
import com.sp.app.admin.model.ProductManage;
import com.sp.app.model.GongguProductDeliveryRefundInfo;

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
	
	public List<GongguManage> listGongguProductPhoto(long gongguProductId);
	public void deleteGongguProductPhoto(long gongguProductId, String uploadPath) throws Exception;
	public void insertGongguProductPhoto(GongguManage dto, String uploadPath) throws SQLException;
	public boolean deleteUploadPhoto(String uploadPath, String detailPhoto);
	public void deleteSingleGongguProductPhoto(long gongguProductDetailId, String uploadPath) throws Exception;
	
	// 패키지 상품등록
	public void insertGongguPackage(GongguPackageManage dto) throws Exception;
	public long deleteGongguPackage(long packageNum) throws Exception;
	public List<ProductManage> productSearch(Map<String, Object> map);
	public List<GongguPackageManage> listPackage(Map<String, Object> map) throws Exception;
	public long calculateOriginalPrice(long gongguProductId) throws Exception;
	public void updateOriginalPrice(long gongguProductId) throws Exception;
	public GongguPackageManage findPacById(long packageNum);
	
	// 공동구매 배송정책
	public GongguProductDeliveryRefundInfoManage listGongguDeliveryRefundInfo();
	public List<GongguProductDeliveryRefundInfoManage> listGongguDeliveryFee();
	public void insertGongguDeliveryFee(Map<String, Object> map);
	public void insertGongguDeliveryRefundInfo(GongguProductDeliveryRefundInfoManage dto);
	public void updateGongguDeliveryRefundInfo(GongguProductDeliveryRefundInfoManage dto);
	public void deleteGongguDeliveryFee();
}