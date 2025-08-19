package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.AdvertisementManage;

public interface AdvertisementManageService {
	public int dataCount(Map<String, Object> map);
	public List<AdvertisementManage> listAdvertisement(Map<String, Object> map);
	
	public void updateStatus(Map<String, Object> map) throws Exception;
	public void updateAdvertisement(Map<String, Object> map) throws Exception;
	
	public AdvertisementManage findById(long advertisingId);
	
	public AdvertisementManage findByFileId(long advertisingFileNum);
	
	public List<AdvertisementManage> listAdvertisementFile(long advertisingId);
}
