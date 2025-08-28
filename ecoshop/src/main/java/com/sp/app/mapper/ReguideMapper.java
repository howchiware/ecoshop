package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Reguide;
import com.sp.app.model.ReguideCategory;

@Mapper
public interface ReguideMapper {
	public long reguideSeq();
	public void insertReguide(Reguide dto) throws SQLException;
	public void updateReguide(Reguide dto) throws SQLException;
	public void deleteReguide(long guideId) throws SQLException;
	
	public void updateHitCount(long guideId) throws SQLException;
		
	public int dataCount(Map<String, Object> map);
	public List<Reguide> listReguide(Map<String, Object> map);
	
	public Reguide findById(long guideId);
	public Reguide findByPrev(Map<String, Object> map);
	public Reguide findByNext(Map<String, Object> map);
	
	List<ReguideCategory> listCategory();
    public void insertCategory(ReguideCategory dto) throws SQLException;
    public void deleteCategory(long categoryCode) throws SQLException;
}
