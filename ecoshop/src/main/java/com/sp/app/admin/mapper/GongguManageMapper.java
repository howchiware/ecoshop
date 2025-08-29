package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguPackageManage;
import com.sp.app.admin.model.GongguProductDeliveryRefundInfoManage;
import com.sp.app.admin.model.ProductManage;

@Mapper
public interface GongguManageMapper {
	public long gongguProductSeq();
	public void insertProduct(GongguManage dto) throws SQLException;
	public void updateProduct(GongguManage dto) throws SQLException;
	public void deleteProduct(long gongguProductId) throws SQLException;
	
	public int dataCountGongguProduct(Map<String, Object> map);
	public GongguManage findById(long gongguProductId);
	
	public List<GongguManage> listGongguProduct(Map<String, Object> map);
	
	public GongguManage findByCategory(long categoryId);
	public List<GongguManage> listCategory();
	
	// 공동구매 사진
	public void insertGongguProductPhoto(GongguManage dto) throws SQLException;
	public List<GongguManage> listGongguProductPhoto(long gongguProductId);
	public void deleteGongguProductPhoto(long gongguProductId) throws SQLException;
	public void deleteSingleGongguProductPhoto(long gongguProductDetailId);
	public GongguManage findByProductDetailId(long gongguProductDetailId);
	
	// 패키지 상품등록
	public void insertGongguPackage(GongguPackageManage dto) throws SQLException;
	public void deleteGongguPackage(long packageNum);
	public List<ProductManage> productSearch(Map<String, Object> map);
	public List<GongguPackageManage> listPackage(Map<String, Object> map);
	public long sumPackagePrices(long gongguProductId);
	public void updateOnlyOriginalPrice(Map<String, Object> map);
	public GongguPackageManage findPacById(long packageNum);
	
	// 공동구매 배송정책 
	public GongguProductDeliveryRefundInfoManage listGongguDeliveryRefundInfo();
	public List<GongguProductDeliveryRefundInfoManage> listGongguDeliveryFee();
	public void insertGongguDeliveryFee(Map<String, Object> map);
	public void insertGongguDeliveryRefundInfo(GongguProductDeliveryRefundInfoManage dto);
	public void updateGongguDeliveryRefundInfo(GongguProductDeliveryRefundInfoManage dto);
	public void deleteGongguDeliveryFee();
}