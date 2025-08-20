package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.PromotionManage;

@Mapper
public interface PromotionManageMapper {
	public void insertPromotionManage(PromotionManage dto) throws SQLException;
	public void updatePromotionManage(PromotionManage dto) throws SQLException;
	public void deletePromotionManage(long promotionId) throws SQLException;
	
	public void updateHitCount(long promotionId) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<PromotionManage> listPromotionManage(Map<String, Object> map);
	
	public PromotionManage findById(Long promotionId);
	public PromotionManage findByPrev(Map<String, Object> map);
	public PromotionManage findByNext(Map<String, Object> map);
}
