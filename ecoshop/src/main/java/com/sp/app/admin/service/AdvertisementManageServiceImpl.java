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
	public List<AdvertisementManage> listAdvertisementFile(long advertisingId) {
		List<AdvertisementManage> listFile = null;
		
		try {
			listFile = mapper.listAdvertisementFile(advertisingId) ;
			
		} catch (Exception e) {
			log.info("listAdvertisementFile : " , e);
		}
		return listFile;
	}

	@Override
	public void updateAdvertisement(AdvertisementManage dto) throws Exception {
	    try {
	        AdvertisementManage beforeDto = mapper.findById(dto.getAdvertisingId());

	        mapper.updateAdvertisement(dto);
 
	        AdvertisementManage logDto = new AdvertisementManage();
	        logDto.setAdvertisingId(dto.getAdvertisingId());
	        logDto.setOldStatus(beforeDto.getInquiryType());           
	        logDto.setNewStatus(dto.getInquiryType());                
	        logDto.setOldPosting(beforeDto.getPostingStatus());  
	        logDto.setNewPosting(dto.getPostingStatus());        

	        mapper.insertadvertisingStatus(logDto);

	    } catch (Exception e) {
	        log.info("updateAdvertisement : ", e);
	        throw e;
	    }
	}

	@Override
	public List<AdvertisementManage> listStatus(Map<String, Object> map) {
		List<AdvertisementManage> list = null;
		
		try {
			list = mapper.listStatus(map);
		} catch (Exception e) {
			log.info("listStatus : " , e);
		}
		return list;
	}

	@Override
	public int statusdataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.statusdataCount(map);
		} catch (Exception e) {
			log.info("statusdataCount : " , e);
		}
		return result;
	}

	@Override
	public List<AdvertisementManage> listMainBanner(Map<String, Object> map) {
		return mapper.listMainBanner(map);
	}

}
