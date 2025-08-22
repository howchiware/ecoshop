package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Destination;
import com.sp.app.model.ProductLike;
import com.sp.app.model.ProductOrder;

public interface MyShoppingService {
	public void insertCart(ProductOrder dto) throws Exception;
	public List<ProductOrder> listCart(Long member_id);
	public void deleteCart(Map<String, Object> map) throws Exception;
	
	public void insertProductLike(Map<String, Object> map) throws SQLException;
	public List<ProductLike> listProductLike(Long member_id);
	public ProductLike findByProductLikeId(Map<String, Object> map);
	public void deleteProductLike(Map<String, Object> map) throws Exception;

	public void insertDestination(Destination dto) throws Exception;
	public int destinationCount(Long member_id);
	public List<Destination> listDestination(Long member_id);
	public void updateDestination(Destination dto) throws Exception;
	public void updateDefaultDestination(Map<String, Object> map) throws Exception;
	public void deleteDestination(Map<String, Object> map) throws Exception;
	public Destination defaultDelivery(Long member_id);
}
