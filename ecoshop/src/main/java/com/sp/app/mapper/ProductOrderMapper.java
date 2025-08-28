package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.ProductOrder;
import com.sp.app.model.ProductReview;
import com.sp.app.model.Payment;
import com.sp.app.model.Point;

@Mapper
public interface ProductOrderMapper {
	public String findByMaxOrderNumber();
	
	public void insertOrder(ProductOrder dto) throws SQLException;
	public void insertPayDetail(ProductOrder dto) throws SQLException;
	public void insertOrderDetail(ProductOrder dto) throws SQLException; 
	public void insertUserPoint(Point dto) throws SQLException;
	public void insertOrderDelivery(ProductOrder dto) throws SQLException;

	public void updateProductStockDec(ProductOrder dto) throws SQLException;
	
	public List<ProductOrder> listOrderProduct(List<Map<String, Long>> list);
	public List<ProductOrder> listOptionDetail(List<Long> detailNums);
	public ProductOrder findOrderByOrderDetail(long orderDetailNum);
	public ProductOrder findByProduct(long productNum);
	public ProductOrder findByOptionDetail(long detailNum);
	public Point findByUserPoint(Long member_id);
	public List<ProductOrder> didIBuyThis(Map<String, Object> map);
	public ProductReview myReviewOfThis(long orderDetailId);
	
	public void insertPoint(ProductOrder dto) throws Exception;
	
	public int countPayment(Map<String, Object> map);
	public List<Payment> listPayment(Map<String, Object> map);
	public List<Payment> listPurchase(Map<String, Object> map);
	
	public Payment findPaymentByOrderDetail(Map<String, Object> map);
	public ProductOrder findByOrderDelivery(Map<String, Object> map);
	public void updateOrderDetailState(Map<String, Object> map) throws Exception;
	public void updateOrderHistory(long orderDetailNum) throws Exception;
	
	// 주문상세 상태 등록
	public void insertDetailStateInfo(Map<String, Object> map) throws SQLException;
	public Payment stateView(Map<String, Object> map);

}
