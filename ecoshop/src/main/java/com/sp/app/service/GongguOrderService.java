package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguPayment;
import com.sp.app.model.GongguReview;

public interface GongguOrderService {
	public String gongguproductOrderNumber();
	public void insertGongguOrder(GongguOrder dto, long gongguProductId) throws Exception;
	public GongguOrder findByGongguProduct(long gongguProductId) throws Exception;
	public List<GongguOrder> didIBuyGonggu(Map<String, Object> map);
	public GongguReview myReviewOfGonggu(long gongguOrderDetailId);
	List<GongguOrder> listGongguOrderProduct(List<GongguOrder> list);
	
	// 마이페이지 주문내역
	public int countGongguPayment(Map<String, Object> map);
    public List<GongguPayment> listGongguPayment(Map<String, Object> map);
    public List<GongguPayment> listGongguPurchase(Map<String, Object> map);
    
    public GongguPayment findByGongguOrderDetail(Map<String, Object> map);
    public GongguOrder findByGongguOrderDelivery(Map<String, Object> map);
    public void updateGongguOrderDetailState(Map<String, Object> map) throws Exception;
    public void updateGongguOrderHistory(long gongguOrderDetailId) throws Exception;
    public void updateDetailState(long gongguOrderDetailId, int detailState) throws Exception;
    public void updateOrderState(long orderId, int orderState) throws Exception;
}

