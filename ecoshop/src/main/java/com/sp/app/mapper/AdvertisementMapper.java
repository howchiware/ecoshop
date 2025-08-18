package com.sp.app.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Advertisement;

@Mapper
public interface AdvertisementMapper {
	public void insertAdvertisement(Advertisement dto) throws SQLException;
	public void insertAdvertisementFile(Advertisement dto) throws SQLException;
		
}
