package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguReview;

@Mapper
public interface GongguOrderMapper {
	public String findByMaxOrderNumber();
	
	public void insertGongguOrder(GongguOrder dto) throws SQLException;
	public void insertGongguPayDetail(GongguOrder dto) throws SQLException;
	public void insertGongguOrderDetail(GongguOrder dto) throws SQLException; 
	public void insertGongguOrderDelivery(GongguOrder dto) throws SQLException;

	public List<GongguOrder> listGongguOrderProduct(List<GongguOrder> list);
	public GongguReview myReviewOfGonggu(long gongguOrderDetailId);
	public GongguOrder findByGongguProduct(long gongguProductId);
	public int countBuyGonggu(Map<String, Object> map);
}
