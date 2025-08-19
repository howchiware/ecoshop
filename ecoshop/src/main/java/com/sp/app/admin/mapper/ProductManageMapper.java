package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.model.ProductDeliveryRefundInfoManage;
import com.sp.app.admin.model.ProductManage;
import com.sp.app.admin.model.ProductStockManage;

@Mapper
public interface ProductManageMapper {
	public long productSeq();
	public void insertProduct(ProductManage dto) throws SQLException;
	public void insertProductPhoto(ProductManage dto) throws SQLException;
	
	public long optionSeq();
	public void insertProductOption(ProductManage dto) throws SQLException;

	public long detailSeq();
	public void insertOptionDetail(ProductManage dto) throws SQLException;

	public CategoryManage findByCategory(long categoryId);
	public List<CategoryManage> listCategory();
	
	public int dataCount(Map<String, Object> map);
	public List<ProductManage> listProduct(Map<String, Object> map);
	public ProductManage findById(long productId);
	public List<ProductManage> listProductPhoto(long productId);
	public List<ProductManage> listProductOption(long productId);
	public List<ProductManage> listOptionDetail(long optionNum);
	
	public void updateProduct(ProductManage dto) throws SQLException;
	public void deleteProduct(long productId) throws SQLException;
	public void deleteProductPhoto(long productPhotoNum) throws SQLException;
	public void updateProductOption(ProductManage dto) throws SQLException;
	public void deleteProductOption(long optionNum) throws SQLException;
	public void updateOptionDetail(ProductManage dto) throws SQLException;
	public void deleteOptionDetail(long detailNum) throws SQLException;
	public void deleteOptionDetail2(long optionNum) throws SQLException;
	public void updateProductDisplayOrder(Map<String, Object> map) throws SQLException;
	
	// 상품 재고
	public void insertProductStock(ProductStockManage dto) throws SQLException;
	public void updateProductStock(ProductStockManage dto) throws SQLException;
	public List<ProductStockManage> listProductStock(Map<String, Object> map);
	public void deleteProductStock(long productId) throws SQLException;
	
	public ProductDeliveryRefundInfoManage listDeliveryRefundInfo();
	public List<ProductDeliveryRefundInfoManage> listDeliveryFee();
	
	public void insertProductDeliveryRefundInfo(ProductDeliveryRefundInfoManage dto);
	public void updateProductDeliveryRefundInfo(ProductDeliveryRefundInfoManage dto);
	public void insertProductDeliveryFee(Map<String, Object> map);
	public void deleteProductDeliveryFee();
	
	public List<Long> optionFindByCode(long id);
}
