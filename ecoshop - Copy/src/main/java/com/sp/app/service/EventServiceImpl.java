package com.sp.app.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.EventMapper;
import com.sp.app.model.Attendance;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class EventServiceImpl implements EventService {

	private final EventMapper mapper;

	@Override
	public void insertAttendance(long memberId, int dayIndex) throws SQLException {
		
		try {
			Attendance dto = new Attendance();
			dto.setMemberId(memberId);
			dto.setDayIndex(dayIndex);
			mapper.insertAttendance(dto);
			
		} catch (Exception e) {
			log.info("insertAttendance : ", e);
			throw e;
		}
	}

	@Override
	public List<Attendance> listAttendance(Map<String, Object> map) {
		
		List<Attendance> list = null;
		
		try {
			list = mapper.listAttendance(map);
			
			if(list == null) {
				list = new ArrayList<>();
			}
			
		} catch (Exception e) {
			log.info("listAttendance : ", e);
		}
		
		return list;
		
	}

	@Override
	public boolean isAlreadyChecked(long memberId, LocalDate today) {
		
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", memberId);
			map.put("today", today);
			
			int count = mapper.countAttendance(map);
			
			return count > 0;
			
		} catch (Exception e) {
			log.info("isAlreadyChecked : ", e);
			return false;
		}
		
	}

	@Override
	public int getWeeklyCount(long memberId) {
		
		int result = 0;
		
		try {
			result = mapper.countWeeklyAttendance(memberId);
		} catch (Exception e) {
			log.info("getWeeklyCount : ", e);
		}
		
		return result;
		
	}

	@Override
	public void addPoints(long memberId, int i) {
		
		try {
		
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	
	

}
