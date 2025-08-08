package com.sp.app.service;

import java.sql.SQLException;

import com.sp.app.model.Attendance;
import com.sp.app.model.Member;

public interface EventService {
	
	public void insertAttendance(Member dto, Attendance aDto) throws SQLException;
	
}
