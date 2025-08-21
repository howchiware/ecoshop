package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.GongguDeliveryRefundInfo;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguPackage;

@Mapper
public interface GongguManageMapper {
	// 상품등록
	public void insertProduct(GongguManage dto) throws SQLException;
	public void updateProduct(GongguManage dto) throws SQLException;
	public void deleteProduct(long gongguProductId) throws SQLException;
	
	public int dataCountGongguProduct(Map<String, Object> map);
	public List<GongguManage> listGongguProduct(Map<String, Object> map);
	public GongguManage findById(long productId);
	
	public void insertGongguPackage(GongguPackage dto) throws SQLException;
	public GongguManage findByCategory(long categoryId);
	public List<GongguManage> listCategory();
	
	// 배송정책
	public GongguDeliveryRefundInfo listDeliveryRefundInfo();
	public List<GongguDeliveryRefundInfo> listDeliveryFee();
	public void insertProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void updateProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void insertProductDeliveryFee(Map<String, Object> map);
	public void deleteProductDeliveryFee();
}
