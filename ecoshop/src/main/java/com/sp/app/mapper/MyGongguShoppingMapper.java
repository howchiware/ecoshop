package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Destination;
import com.sp.app.model.GongguLike;

@Mapper
public interface MyGongguShoppingMapper {
	// 찜
	public void insertGongguLike(Map<String, Object> map) throws SQLException;
	public void deleteOldestGongguLikes(Long memberId) throws SQLException;
	public List<GongguLike> listGongguLike(Map<String, Object> map);
	public GongguLike findByGongguLikeId(Map<String, Object> map);
	public void deleteGongguLike(Map<String, Object> map) throws SQLException;
	public int gongguLikeDataCount(Map<String, Object> map);
	
	// 배송지
	public void insertDestination(Destination dto) throws SQLException;
	public void deleteOldestDestination(Long member_id) throws SQLException;
	public int destinationCount(Long member_id);
	public List<Destination> listDestination(Long member_id);
	public void updateDestination(Destination dto) throws SQLException;
	public void updateDefaultDestination(Map<String, Object> map) throws SQLException;
	public void deleteDestination(Map<String, Object> map) throws SQLException;
	public Destination defaultDelivery(Long member_id);
	
}