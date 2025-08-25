package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.GongguOrder;
import com.sp.app.model.GongguReview;

public interface GongguOrderService {
	public String gongguproductOrderNumber();
	public void insertGongguOrder(GongguOrder dto) throws Exception;
	public List<GongguOrder> listGongguOrderProduct(List<Map<String, Long>> list);
	public GongguOrder findByGongguProduct(long gongguProductNum);
	public List<GongguOrder> didIBuyGonggu(Map<String, Object> map);
	public GongguReview myReviewOfGonggu(long gongguOrderDetailId);
}

