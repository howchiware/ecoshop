package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.model.GongguDeliveryRefundInfo;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguPackage;
import com.sp.app.admin.model.ProductStockManage;

@Mapper
public interface GongguManageMapper {
	// 상품등록
	public long gongguProductSeq();
	public void insertGongguPackage(GongguPackage dto) throws SQLException;
	public void insertProduct(GongguManage dto) throws SQLException;
	public void insertProductPhoto(GongguManage dto) throws SQLException;
	public List<GongguManage> listProduct(Map<String, Object> map);
	public GongguManage findById(long productId);
	public List<GongguManage> listProductPhoto(long productId);
	public void updateProduct(GongguManage dto) throws SQLException;
	public void deleteProduct(long gongguProductId) throws SQLException;
	public void deleteProductPhoto(long gongguProductDetailId) throws SQLException;
	public void updateProductDisplayOrder(Map<String, Object> map) throws SQLException;
	public int dataCount(Map<String, Object> map);
	
	public List<ProductStockManage> listProductStock(Map<String, Object> map);
	
	public CategoryManage findByCategory(long categoryId);
	public List<CategoryManage> listCategory();
	
	// 배송정책
	public GongguDeliveryRefundInfo listDeliveryRefundInfo();
	public List<GongguDeliveryRefundInfo> listDeliveryFee();
	public void insertProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void updateProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void insertProductDeliveryFee(Map<String, Object> map);
	public void deleteProductDeliveryFee();
}
