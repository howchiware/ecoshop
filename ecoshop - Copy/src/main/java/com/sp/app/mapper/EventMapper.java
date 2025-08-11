package com.sp.app.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Attendance;
import com.sp.app.model.Member;

@Mapper
public interface EventMapper {
	
	public void insertAttendance(Member dto, Attendance aDto) throws SQLException;

}
