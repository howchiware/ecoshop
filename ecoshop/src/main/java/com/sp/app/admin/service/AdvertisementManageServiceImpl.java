package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.AdvertisementManageMapper;
import com.sp.app.admin.model.AdvertisementManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdvertisementManageServiceImpl implements AdvertisementManageService {
	
	private final AdvertisementManageMapper mapper;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : " , e);
		}
		return result;
	}

	// 리스트
	@Override
	public List<AdvertisementManage> listAdvertisement(Map<String, Object> map) {
		List<AdvertisementManage> list = null;
		
		try {
			list = mapper.listAdvertisement(map);
		} catch (Exception e) {
			log.info("listAdvertisement : " , e);
		}
		return list;
	}

	@Override
	public void updateStatus(Map<String, Object> map) throws Exception {
		try {
			mapper.updateStatus(map);
		} catch (Exception e) {
			log.info("updateStatus : ", e);
			
			throw e;
		}
		
	}

	@Override
	public AdvertisementManage findById(long advertisingId) {
		AdvertisementManage dto = null;
		
		try {
			dto = mapper.findById(advertisingId);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}

	@Override
	public AdvertisementManage findByFileId(long advertisingFileNum) {
		AdvertisementManage dto = null;
		
		try {
			dto = mapper.findByFileId(advertisingFileNum);
		} catch (Exception e) {
			log.info("findByFileId : ", e);
		}
		
		return dto;
	}

	@Override
	public void updateAdvertisement(Map<String, Object> map) throws Exception {
		try {
			mapper.updateAdvertisement(map);
		} catch (Exception e) {
			log.info("updateAdvertisement : ", e);
			
			throw e;
		}
	}

}
