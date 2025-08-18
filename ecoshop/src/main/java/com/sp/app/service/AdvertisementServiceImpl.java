package com.sp.app.service;

import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.mapper.AdvertisementMapper;
import com.sp.app.model.Advertisement;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdvertisementServiceImpl implements AdvertisementService {
	private final AdvertisementMapper mapper;
	private final StorageService storageService;
	
	@Override
	public void insertAdvertisement(Advertisement dto, String uploadPath) throws Exception {
		try {
			long seq = mapper.advertisingSeq();
			dto.setAdvertisingId(seq);
			
			mapper.insertAdvertisement(dto);

			if (! dto.getSelectFile().isEmpty()) {
				advertisementFile(dto, uploadPath);
			}
			
		} catch (Exception e) {
			log.info("insertAdvertisement : ", e);
			
			throw e;
		}
		
	}

	protected void advertisementFile(Advertisement dto, String uploadPath) throws Exception {
		for(MultipartFile mf : dto.getSelectFile()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				
				String originalFilename = mf.getOriginalFilename();
				long fileSize = mf.getSize();
				
				dto.setOriginalFilename(originalFilename);
				dto.setSaveFilename(saveFilename);
				dto.setFileSize(fileSize);
				
				mapper.insertAdvertisementFile(dto);
				
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
		
	}

	
	
}
