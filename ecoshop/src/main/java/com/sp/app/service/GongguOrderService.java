package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguReview;

public interface GongguOrderService {
	public String gongguproductOrderNumber();
	public void insertGongguOrder(GongguOrder dto, long gongguProductId) throws Exception;
	public GongguOrder findByGongguProduct(long gongguProductId) throws Exception;
	public List<GongguOrder> didIBuyGonggu(Map<String, Object> map);
	public GongguReview myReviewOfGonggu(long gongguOrderDetailId);
	List<GongguOrder> listGongguOrderProduct(List<GongguOrder> list);
}

