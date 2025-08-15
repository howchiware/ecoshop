package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.AttendanceManageMapper;
import com.sp.app.admin.model.AttendanceManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AttendanceManageServiceImpl implements AttendanceManageService {

	private final AttendanceManageMapper mapper;
	
	@Override
	public List<AttendanceManage> listAttendanceMember(Map<String, Object> map) {
		
		List<AttendanceManage> list = null;
		
		try {
			list = mapper.listAttendanceMember(map);
			
		} catch (Exception e) {
			log.info("listAttendanceMember", e);
		}
		
		return list;
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount: ", e);
		}
		
		return result;
	}

	@Override
	public int memberCount(Map<String, Object> map) {
		
		int result = 0;
		
		try {
			result = mapper.memberCount(map);
		} catch (Exception e) {
			log.info("dataCount: ", e);
		}
		
		return result;
	}

	@Override
	public int pointTargetCount(Map<String, Object> map) {
		
		int result = 0;
		
		try {
			result = mapper.pointTargetCount(map);
		} catch (Exception e) {
			log.info("pointTargetCount: ", e);
		}
		
		return result;
	}

	@Override
	public int totalAttendanceCount(Map<String, Object> map) {
		
		int result = 0;
		
		try {
			result = mapper.totalAttendanceCount(map);
		} catch (Exception e) {
			log.info("totalAttendanceCount: ", e);
		}
		
		return result;
	}
	
	

}
