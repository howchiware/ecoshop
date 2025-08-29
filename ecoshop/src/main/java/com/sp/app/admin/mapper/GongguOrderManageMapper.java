package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.GongguOrderDetailManage;
import com.sp.app.admin.model.GongguOrderManage;

@Mapper
public interface GongguOrderManageMapper {
	public int orderCount(Map<String, Object> map);
	public List<GongguOrderManage> listOrder(Map<String, Object> map);
	public GongguOrderManage findByOrderId(String orderId);
	public List<GongguOrderDetailManage> listOrderDetails(String orderId);
	
	public int detailCount(Map<String, Object> map);
	public List<GongguOrderDetailManage> listDetails(Map<String, Object> map);
	public GongguOrderDetailManage findByDetailId(Long gongguOrderDetailId);
	
	public void updateProductStockInc(Map<String, Object> map) throws SQLException;
	
	public void updateOrderState(Map<String, Object> map) throws SQLException;
	public int findByTotalCancelAmount(String orderId);
	public int totalOrderCount(String orderId);

	public void updateCancelAmount(Map<String, Object> map) throws SQLException;
	public void updateOrderInvoiceNumber(Map<String, Object> map) throws SQLException;
	public void updateOrderDetailState(Map<String, Object> map) throws SQLException;
	
	public List<Map<String, Object>> listDeliveryCompany();
	public void insertDetailStateInfo(Map<String, Object> map) throws SQLException;
	public List<Map<String, Object>> listDetailStateInfo(long gongguOrderDetailId);
	
	public List<Long> listExpiredPeriodOrder();
	public void updateAutoPurchaseconfirmation(Map<String, Object> map) throws SQLException;
	public void updateAutoPurchaseconfirmation2() throws SQLException;
	
	public GongguOrderManage findByDeliveryId(String orderId);
	public Map<String, Object> findByPayDetail(String orderId);
	
	public GongguOrderManage findPrevByOrderId(String orderId);
	public GongguOrderManage findNextByOrderId(String orderId);
}
