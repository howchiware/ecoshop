package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.ProductManage;
import com.sp.app.admin.model.ProductStockManage;

public interface ProductManageService {
	public void insertProduct(ProductManage dto, String uploadPath) throws Exception;
	public void updateProduct(ProductManage dto, String uploadPath) throws Exception;
	public void deleteProduct(long productId, String uploadPath) throws Exception;
	public void deleteProductPhoto(long productPhotoNum, String uploadPath) throws Exception;
	public void deleteOptionDetail(long optionDetailNum) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<ProductManage> listProduct(Map<String, Object> map);
	
	public ProductManage findById(long productId);
	public ProductManage findByPrev(Map<String, Object> map);
	public ProductManage findByNext(Map<String, Object> map);
	
	public List<ProductManage> listProductPhoto(long productId);
	public List<ProductManage> listProductOption(long productId);
	public List<ProductManage> listOptionDetail(long optionNum);

	// 상품 상위 카테고리 목록
	public ProductManage findByCategory(long categoryNum);
	public List<ProductManage> listCategory();
	
	// 상품 재고
	public void updateProductStock(ProductStockManage dto) throws Exception;
	public List<ProductStockManage> listProductStock(Map<String, Object> map);
	
	public boolean deleteUploadPhoto(String uploadPath, String photoName);
	
}
