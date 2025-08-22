package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.GongguDeliveryRefundInfo;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguPackageManage;
import com.sp.app.admin.model.ProductManage;

@Mapper
public interface GongguManageMapper {
	// 상품등록
	public long gongguProductSeq();
	public void insertProduct(GongguManage dto) throws SQLException;
	public void updateProduct(GongguManage dto) throws SQLException;
	public void deleteProduct(long gongguProductId) throws SQLException;
	
	public int dataCountGongguProduct(Map<String, Object> map);
	public List<GongguManage> listGongguProduct(Map<String, Object> map);
	public GongguManage findById(long productId);
	
	// 패키지 구성 넣기 
	public void insertGongguPackage(GongguPackageManage dto) throws SQLException;
	public void deleteGongguPackage(long packageNum) throws SQLException;
	public List<ProductManage> productSearch(Map<String, Object> map);
	public List<GongguPackageManage> listPackage(Map<String, Object> map);
	
	// 카테고리
	public GongguManage findByCategory(long categoryId);
	public List<GongguManage> listCategory();
	
	// 사진
	public List<GongguManage> listProductPhoto(long gongguProductId);
	public void insertProductPhoto(GongguManage dto) throws SQLException;
	public void deleteProductPhoto(long gongguProductDetailId) throws SQLException;
	
	// 배송정책
	public GongguDeliveryRefundInfo listDeliveryRefundInfo();
	public List<GongguDeliveryRefundInfo> listDeliveryFee();
	public void insertProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void updateProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto);
	public void insertProductDeliveryFee(Map<String, Object> map);
	public void deleteProductDeliveryFee();
	
}
