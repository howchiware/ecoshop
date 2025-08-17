package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.AdvertisementManage;

@Mapper
public interface AdvertisementManageMapper {
	
	public void insertAdvertisement(AdvertisementManage dto) throws SQLException;
	
	public void updateAdvertisement(Map<String, Object> map) throws SQLException;
	
	public void updateStatus(Map<String, Object> map) throws Exception;
	
	public void deleteAdvertisement(long advertisingId) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<AdvertisementManage> listAdvertisement(Map<String, Object>map);
	
	public AdvertisementManage findById(long advertisingId);
	public AdvertisementManage findByFileId(long advertisingFileNum);
}
