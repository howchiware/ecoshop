package com.sp.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TotalManageMapper {
	public Map<String, Object> todayProduct();
	public Map<String, Object> thisMonthProduct();
	public Map<String, Object> previousMonthProduct();
	public Map<String, Object> memberCount();
	public Map<String, Object> staffCount();
	
	public List<Map<String, Object>> dayTotalAmount(String date);
	public List<Map<String, Object>> dayTotalAmount2(String date);
	public List<Map<String, Object>> monthTotalAmount(String month);
	public List<Map<String, Object>> monthTotalAmount2(String month);
	public Map<String, Object> dayOfWeekTotalCount(String month);
}
