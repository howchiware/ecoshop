package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Attendance;

@Mapper
public interface EventMapper {
	
	/* 출석 체크*/
	public void insertAttendance(Attendance dto) throws SQLException;
	public List<Attendance> listAttendance(Map<String, Object> map) throws SQLException;
	public int countAttendance(Map<String, Object> map) throws SQLException;
	public int countWeeklyAttendance(long memberId) throws SQLException;
	public void addPoints(Attendance dto) throws SQLException;
	
	
	
	/* 퀴즈 */
}
