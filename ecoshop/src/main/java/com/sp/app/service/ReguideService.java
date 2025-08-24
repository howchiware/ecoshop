package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Reguide;
import com.sp.app.model.ReguideCategory;

public interface ReguideService {
	public void insertReguide(Reguide dto, String uploadPath, String mode) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Reguide> listReguide(Map<String, Object> map);
	
	public void updateHitCount(long guidId) throws Exception;
	
	public Reguide findById(long guidId);
	public Reguide findByPrev(Map<String, Object> map);
	public Reguide findByNext(Map<String, Object> map);
	
	public void updateReguide(Reguide dto, String uploadPath) throws Exception;
	public void deleteReguide(long guidId, Long memberId, int userLevel, String uploadPath, String filename) throws Exception;
	
	public boolean deleteUploadFile(String uploadPath, String filename);

	public List<ReguideCategory> listCategory();
	public void insertCategory(ReguideCategory dto) throws Exception;

}
