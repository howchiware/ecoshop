package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Workshop;

public interface WorkshopService {
	public void insertCategory(Workshop dto, String CategoryName);
	public List<Workshop> listCategory(Map<String, Object> map);
	
	public void insertProgram(Workshop dto, Long categoryId, String programTitle, String programContent) throws Exception;
	public List<Workshop> listProgram(Map<String, Object> map);
	public Workshop findProgramById(long num);
	public void updateProgram(Workshop dto) throws Exception;
	public void deleteProgram(long num) throws Exception;
}
