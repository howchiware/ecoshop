package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Destination;
import com.sp.app.model.Point;
import com.sp.app.model.ProductLike;
import com.sp.app.model.ProductOrder;

@Mapper
public interface MyShoppingMapper {
	// 장바구니
	public void insertCart(ProductOrder dto) throws SQLException;
	public void updateCart(ProductOrder dto) throws SQLException;
	public ProductOrder findByCartId(Map<String, Object> map);
	public List<ProductOrder> listCart(Long member_id);
	public void deleteCart(Map<String, Object> map) throws SQLException;
	public void deleteCartExpiration() throws SQLException;
	
	// 찜
	public void insertProductLike(Map<String, Object> map) throws SQLException;
	public void deleteOldestProductLikes(Long member_id) throws SQLException;
	public List<ProductLike> listProductLike(Long member_id);
	public ProductLike findByProductLikeId(Map<String, Object> map);
	public void deleteProductLike(Map<String, Object> map) throws SQLException;

	// 배송지
	public void insertDestination(Destination dto) throws SQLException;
	public void deleteOldestDestination(Long member_id) throws SQLException;
	public int destinationCount(Long member_id);
	public List<Destination> listDestination(Long member_id);
	public void updateDestination(Destination dto) throws SQLException;
	public void updateDefaultDestination(Map<String, Object> map) throws SQLException;
	public void deleteDestination(Map<String, Object> map) throws SQLException;
	public Destination defaultDelivery(Long member_id);

	public int pointDataCount(Map<String, Object> map);
	public List<Point> listPointHistory(Map<String, Object> map);
}
