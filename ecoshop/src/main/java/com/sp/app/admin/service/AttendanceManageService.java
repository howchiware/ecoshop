package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.AttendanceManage;

public interface AttendanceManageService {
	
	public List<AttendanceManage> listAttendanceMember(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public int memberCount(Map<String, Object> map);
	
	public int pointTargetCount(Map<String, Object> map);
	public int totalAttendanceCount(Map<String, Object> map);
	
}
