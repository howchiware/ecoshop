package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.GongguManage;

public interface GongguManageService {
	public void insertGongguProduct(GongguManage dto, String uploadPath) throws Exception;
	public void updateGongguProduct(GongguManage dto, String uploadPath) throws Exception;
	public void deleteGongguProduct(long gongguProductId, String uploadPath) throws Exception;
	public void deleteGongguDetailPhotoFile(long fileNum, String pathString) throws Exception;
	public boolean deleteUploadFile(String uploadPath, String filename);
	public int dataCount(Map<String, Object> map);
	public List<GongguManage> listProduct(Map<String, Object> map);
	public GongguManage findById(long gongguProductId);
}
