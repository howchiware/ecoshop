package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.TotalManageMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TotalManageServiceImpl implements TotalManageService {
	private final TotalManageMapper mapper;
	
	@Override
	public Map<String, Object> todayProduct() {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = mapper.todayProduct();
		} catch (Exception e) {
			log.info("todayProduct : ", e);
		}
		
		return resultMap;
	}

	@Override
	public Map<String, Object> thisMonthProduct() {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = mapper.thisMonthProduct();
		} catch (Exception e) {
			log.info("thisMonthProduct : ", e);
		}
		
		return resultMap;
	}

	@Override
	public Map<String, Object> previousMonthProduct() {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = mapper.previousMonthProduct();
		} catch (Exception e) {
			log.info("previousMonthProduct : ", e);
		}
		
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> dayTotalAmount(String date) {
		List<Map<String, Object>> list = null;
		
		try {
			list = mapper.dayTotalAmount(date);
		} catch (Exception e) {
			log.info("dayTotalMoney : ", e);
		}
		
		return list;
	}

	@Override
	public List<Map<String, Object>> monthTotalAmount(String month) {
		List<Map<String, Object>> list = null;
		
		try {
			list = mapper.monthTotalAmount(month);
		} catch (Exception e) {
			log.info("monthTotalMoney : ", e);
		}
		
		return list;
	}

	@Override
	public Map<String, Object> dayOfWeekTotalCount(String month) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = mapper.dayOfWeekTotalCount(month);
		} catch (Exception e) {
			log.info("dayOfWeekTotalCount : ", e);
		}
		
		return resultMap;
	}

}
