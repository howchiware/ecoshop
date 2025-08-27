package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

public interface TotalManageService {
	public Map<String, Object> todayProduct();
	public Map<String, Object> thisMonthProduct();
	public Map<String, Object> previousMonthProduct();
	public Map<String, Object> memberCount();
	public Map<String, Object> staffCount();
	
	
	public List<Map<String, Object>> dayTotalAmount(String date);
	public List<Map<String, Object>> monthTotalAmount(String month);
	public Map<String, Object> dayOfWeekTotalCount(String month);
}
