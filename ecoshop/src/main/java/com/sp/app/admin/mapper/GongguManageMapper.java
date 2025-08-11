package com.sp.app.admin.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.GongguManage;

@Mapper
public interface GongguManageMapper {
	public long gongguSeq();
	public void insertGongguProduct(GongguManage dto) throws SQLException;
	public void insertGongguDetail(GongguManage dto) throws SQLException;
}
