package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Workshop;

public interface WorkshopService {
	// 카테고리
	public void insertCategory(Workshop dto, String CategoryName);
	public List<Workshop> listCategory(Map<String, Object> map);
	
	// 프로그램
	public void insertProgram(Workshop dto, Long categoryId, String programTitle, String programContent) throws Exception;
	public List<Workshop> listProgram(Map<String, Object> map);
	public Workshop findProgramById(long num);
	public void updateProgram(Workshop dto) throws Exception;
	public void deleteProgram(long num) throws Exception;
	
	// 담당자
	public void insertManager(Workshop dto) throws Exception;
	public List<Workshop> listManager(Map<String, Object> map);
	public Workshop findManagerById(long num);
	public void updateManager(Workshop dto) throws Exception;
	public void deleteManager(long num) throws Exception;
	
	// 워크샵
	public void insertWorkshop(Workshop dto) throws Exception;
	public List<Workshop> listWorkshop(Map<String, Object> map);
	public Workshop findWorkshopById(long num);
	public void updateWorkshop(Workshop dto) throws Exception;
	public void deleteWorkshop(long num) throws Exception;
	public int workshopDataCount(Map<String, Object> map);
	
	// 워크샵 사진
	public void insertWorkshopPhoto(Workshop dto, String workshopImagePath) throws Exception; // workshopImagePath로 수정
	public List<Workshop> listWorkshopPhoto(Map<String, Object> map);
	public Workshop findWorkshopPhotoById(long photoId);
	public void deleteWorkshopPhotoById(long photoId, String uploadPath) throws Exception;
	public void deleteWorkshopPhotosByWorkshopId(long workshopId, String uploadPath) throws Exception;
	public int workshopPhotoDataCount(Map<String, Object> map);
	
}
