package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguReviewManage;

@Mapper
public interface GongguManageMapper {
	public void insertGongguProduct(GongguManage dto) throws SQLException;
	public void insertGongguDetail(GongguManage dto) throws SQLException;
	
	public List<GongguReviewManage> findAllReviews() throws SQLException;
}
