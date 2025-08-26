package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.GongguOrder;    
import com.sp.app.model.GongguPayment;

@Mapper
public interface MyPageGongguMapper {
	
	public int countGongguPayment(Map<String, Object> map);
	public List<GongguPayment> listGongguPayment(Map<String, Object> map);
	public List<GongguPayment> listGongguPurchase(Map<String, Object> map);
	public GongguPayment findByGongguOrderDetail(Map<String, Object> map);
	public GongguOrder findByGongguOrderDelivery(Map<String, Object> map);
	public void updateGongguOrderDetailState(Map<String, Object> map) throws SQLException;
	public void updateGongguOrderHistory(long gongguOrderDetailId) throws SQLException;
	public void insertGongguDetailStateInfo(Map<String, Object> map) throws SQLException;
	public void updateGongguReviewWrite(long gongguOrderDetailId) throws SQLException;
	public GongguPayment findGongguOrderDetailForReview(long gongguOrderDetailId);
}
