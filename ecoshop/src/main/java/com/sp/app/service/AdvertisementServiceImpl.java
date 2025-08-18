package com.sp.app.service;

import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.exception.StorageException;
import com.sp.app.mapper.AdvertisementMapper;
import com.sp.app.model.Advertisement;

import com.sp.app.common.StorageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdvertisementServiceImpl implements AdvertisementService {
	private final AdvertisementMapper mapper;
	
	@Override
	public void insertAdvertisement(Advertisement dto, String uploadPath) throws Exception {
		try {
			
			mapper.insertAdvertisement(dto);

			if (! dto.getSelectFile().isEmpty()) {
				advertisementFile(dto, uploadPath);
			}
			
		} catch (Exception e) {
			log.info("insertAdvertisement : ", e);
			
			throw e;
		}
		
	}

	protected void advertisementFile(Advertisement dto, String uploadPath) {
		// TODO Auto-generated method stub
		
	}

	
	
}
