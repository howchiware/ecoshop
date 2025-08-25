package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.GongguOrder;

public interface MyPageGongguService {
    
	public int countGongguOrder(Map<String, Object> map);
    public List<GongguOrder> listGongguOrder(Map<String, Object> map);
    public GongguOrder findByGongguOrderDetail(Map<String, Object> map);
    public GongguOrder findByGongguOrderDelivery(Map<String, Object> map);
    public void updateGongguOrderDetailState(Map<String, Object> map) throws Exception;
    public void updateGongguOrderHistory(long gongguOrderDetailId) throws Exception;
}