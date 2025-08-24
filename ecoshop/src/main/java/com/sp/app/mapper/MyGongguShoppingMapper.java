package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.GongguLike;

@Mapper
public interface MyGongguShoppingMapper {
	// 찜
	public void insertGongguLike(Map<String, Object> map) throws SQLException;
	public void deleteOldestGongguLikes(Long memberId) throws SQLException;
	public List<GongguLike> listGongguLike(Long memberId);
	public GongguLike findByGongguLikeId(Map<String, Object> map);
	public void deleteGongguLike(Map<String, Object> map) throws SQLException;
}