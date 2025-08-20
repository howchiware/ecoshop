package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.StorageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import com.sp.app.admin.mapper.PromotionManageMapper;
import com.sp.app.admin.model.PromotionManage;

@Service
@RequiredArgsConstructor
@Slf4j
public class PromotionManageServiceImpl implements PromotionManageService{
	private final StorageService storageService;
	private final PromotionManageMapper mapper;

	@Override
	public void insertPromotionManage(PromotionManage dto, String uploadPath) throws Exception {
		try {
			String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
			if (saveFilename != null) {
				dto.setImageFilename(saveFilename);

				mapper.insertPromotionManage(dto);
			}
		} catch (Exception e) {
			log.info("insertPromotionManage : ", e);
			
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}

		return result;
	}

	@Override
	public List<PromotionManage> listPromotionManage(Map<String, Object> map) {
		List<PromotionManage> list = null;

		try {
			list = mapper.listPromotionManage(map);
		} catch (Exception e) {
			log.info("listPromotionManage : ", e);
		}

		return list;
	}

	@Override
	public PromotionManage findById(long promotionId) {
		PromotionManage dto = null;

		try {
			dto = mapper.findById(promotionId);
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Override
	public PromotionManage findByPrev(Map<String, Object> map) {
		PromotionManage dto = null;
		
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}

		return dto;
	}

	@Override
	public PromotionManage findByNext(Map<String, Object> map) {
		PromotionManage dto = null;
		
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}

		return dto;
	}

	@Override
	public void updatePromotionManage(PromotionManage dto, String uploadPath) throws Exception {
		try {
			if(dto.getSelectFile() != null && ! dto.getSelectFile().isEmpty()) {
				if(! dto.getImageFilename().isBlank()) {
					deleteUploadFile(uploadPath, dto.getImageFilename());
				}
				
				String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
				dto.setImageFilename(saveFilename);
			}

			 mapper.updatePromotionManage(dto);
		} catch (Exception e) {
			log.info("updatePromotionManage : ", e);
			
			throw e;
		}
	}

	@Override
	public void deletePromotionManage(long promotionId, String uploadPath, String filename) throws Exception {
		try {
			if (filename != null) {
				deleteUploadFile(uploadPath, filename);
			}

			 mapper.deletePromotionManage(promotionId);
		} catch (Exception e) {
			log.info("deletePromotionManage : ", e);
			
			throw e;
		}
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		// TODO Auto-generated method stub
		return false;
	}

}
