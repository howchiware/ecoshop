package com.sp.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.AttendanceManage;

@Mapper
public interface AttendanceManageMapper {

	public List<AttendanceManage> listAttendanceMember(Map<String, Object> map	);
	public int dataCount(Map<String, Object> map);
	public int memberCount(Map<String, Object> map);
	
	public int pointTargetCount(Map<String, Object> map);
	public int totalAttendanceCount(Map<String, Object> map);

}
