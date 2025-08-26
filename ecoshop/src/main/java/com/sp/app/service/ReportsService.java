package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Reports;

public interface ReportsService {
	public void insertReports(Reports dto) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Reports> listReports(Map<String, Object> map);

	public int dataGroupCount(Map<String, Object> map);
	public List<Reports> listGroupReports(Map<String, Object> map);
	
	public Reports findById(Long reportId);
	
	public int dataRelatedCount(Map<String, Object> map);
	public List<Reports> listRelatedReports(Map<String, Object> map);

	public void updateReports(Reports dto) throws Exception;
	public void updateBlockPosts(Map<String, Object> map) throws Exception;
	public void deletePosts(Map<String, Object> map) throws Exception;
	
	public Reports findByPostsId(Map<String, Object> map);
	
	public Reports getReportStats();
	public int todayReportCount();
}

