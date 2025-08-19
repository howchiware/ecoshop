package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.ProductStockManage;
import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.model.GongguDeliveryRefundInfo;

public interface GongguManageService {
	public void insertGongguProduct(GongguManage dto, String uploadPath) throws Exception;
	public void updateGongguProduct(GongguManage dto, String uploadPath) throws Exception;
	public void deleteGongguProduct(List<Long> gongguProductId, String uploadPath) throws Exception;
	public void deleteProductPhoto(long gongguProductDetailId, String uploadPath) throws Exception;
	public boolean deleteUploadPhoto(String uploadPath, String gongguPhotoName);
	
	public int dataCount(Map<String, Object> map);
	public List<GongguManage> listProduct(Map<String, Object> map);
	
	public GongguManage findById(long gongguProductId);
	public List<GongguManage> listProductPhoto(long gongguProductId);
	
	public CategoryManage findByCategory(long categoryId);
	public List<CategoryManage> listCategory();
	
	public GongguDeliveryRefundInfo listDeliveryRefundInfo();
	public List<GongguDeliveryRefundInfo> listDeliveryFee();
	public void insertProductDeliveryFee(Map<String, Object> map);
	public void insertProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void updateProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void deleteProductDeliveryFee();
	
	public List<ProductStockManage> listProductStock(Map<String, Object> map);
}
