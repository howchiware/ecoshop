package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Destination;
import com.sp.app.model.Point;
import com.sp.app.model.ProductLike;
import com.sp.app.model.ProductOrder;

public interface MyShoppingService {
	public void insertCart(ProductOrder dto) throws Exception;
	public List<ProductOrder> listCart(Long memberId);
	public void deleteCart(Map<String, Object> map) throws Exception;
	
	public void insertProductLike(Map<String, Object> map) throws SQLException;
	public List<ProductLike> listProductLike(Map<String, Object> map);
	public ProductLike findByProductLikeId(Map<String, Object> map);
	public void deleteProductLike(Map<String, Object> map) throws Exception;

	public void insertDestination(Destination dto) throws Exception;
	public int destinationCount(Long memberId);
	public List<Destination> listDestination(Long memberId);
	public void updateDestination(Destination dto) throws Exception;
	public void updateDefaultDestination(Map<String, Object> map) throws Exception;
	public void deleteDestination(Map<String, Object> map) throws Exception;
	public Destination defaultDelivery(Long memberId);

	public int productLikeDataCount(Map<String, Object> map);
	public int pointDataCount(Map<String, Object> map);
	public List<Point> listPointHistory(Map<String, Object> map);
}
