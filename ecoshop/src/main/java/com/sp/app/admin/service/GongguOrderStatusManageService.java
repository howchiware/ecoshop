package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.GongguOrderDetailManage;
import com.sp.app.admin.model.GongguOrderManage;

public interface GongguOrderStatusManageService {
	public int orderCount(Map<String, Object> map);
	public List<GongguOrderManage> listOrder(Map<String, Object> map);
	public GongguOrderManage findByOrderId(String orderId);
	public List<GongguOrderDetailManage> listOrderDetails(String orderId);
	
	public GongguOrderManage findPrevByOrderId(String orderId);
	public GongguOrderManage findNextByOrderId(String orderId);
	
	public int detailCount(Map<String, Object> map);
	public List<GongguOrderDetailManage> listDetails(Map<String, Object> map);
	public GongguOrderDetailManage findByDetailId(Long gongguOrderDetailId);
	
	public void updateOrder(String mode, Map<String, Object> map) throws Exception;
	public void updateOrderDetailState(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> listDeliveryCompany();
	public List<Map<String, Object>> listDetailStateInfo(long gongguOrderDetailId);
	
	public GongguOrderManage findByDeliveryId(String orderId);
	public Map<String, Object> findByPayDetail(String orderId);
}
