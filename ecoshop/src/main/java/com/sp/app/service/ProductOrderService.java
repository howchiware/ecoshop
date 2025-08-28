package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Payment;
import com.sp.app.model.Point;
import com.sp.app.model.ProductOrder;
import com.sp.app.model.ProductReview;

public interface ProductOrderService {
	public String productOrderNumber();
	public void insertOrder(ProductOrder dto) throws Exception;
	
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
	
	public Payment stateView(Map<String, Object> map);
}
