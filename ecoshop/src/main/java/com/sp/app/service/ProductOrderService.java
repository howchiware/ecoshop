package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.ProductOrder;
import com.sp.app.model.ProductReview;
import com.sp.app.model.Point;

public interface ProductOrderService {
	public String productOrderNumber();
	public void insertOrder(ProductOrder dto) throws Exception;
	
	public List<ProductOrder> listOrderProduct(List<Map<String, Long>> list);
	public List<ProductOrder> listOptionDetail(List<Long> detailNums);
	public ProductOrder findByOrderDetail(long orderDetailNum);
	public ProductOrder findByProduct(long productNum);
	public ProductOrder findByOptionDetail(long detailNum);
	public Point findByUserPoint(Long member_id);
	
	public List<ProductOrder> didIBuyThis(Map<String, Object> map);
	public ProductReview myReviewOfThis(long orderDetailId);
	
	public void insertPoint(ProductOrder dto) throws Exception;
}
