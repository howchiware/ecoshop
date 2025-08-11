package com.sp.app.service;

import java.sql.SQLException;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.EventMapper;
import com.sp.app.model.Attendance;
import com.sp.app.model.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class EventServiceImpl implements EventService {

	private final EventMapper mapper;

	@Override
	public void insertAttendance(Member dto, Attendance aDto) throws SQLException {
		
		try {
			mapper.insertAttendance(dto, aDto);
		} catch (Exception e) {
			log.info("insertAttendance : ", e);
			throw e;
		}
		
	}
	

}
