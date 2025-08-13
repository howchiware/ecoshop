package com.sp.app.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Attendance;

public interface EventService {
	
	public void insertAttendance(long memberId, int dayIndex) throws SQLException;
	
	public List<Attendance> listAttendance(Map<String, Object> map);

	public boolean isAlreadyChecked(long memberId, LocalDate today);

	public int getWeeklyCount(long memberId);

	public void addPoints(long memberId, int i);
	
}
