package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.ReguideMapper;
import com.sp.app.model.Reguide;
import com.sp.app.model.ReguideCategory;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReguideServiceImpl implements ReguideService {
	private final ReguideMapper mapper;
	private final StorageService storageService;

	@Override
	public void insertReguide(Reguide dto, String uploadPath, String mode) throws Exception {
		try {
			String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
			if (saveFilename != null) {
				dto.setImageFilename(saveFilename);

				mapper.insertReguide(dto);
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
	public List<Reguide> listReguide(Map<String, Object> map) {
		List<Reguide> list = null;

		try {
			list = mapper.listReguide(map);
		} catch (Exception e) {
			log.info("listReguide : ", e);
		}

		return list;
	}

	@Override
	public void updateHitCount(long guidId) throws Exception {
		try {
			mapper.updateHitCount(guidId);
		} catch (Exception e) {
			log.info("updateHitCount : ", e);
			
			throw e;
		}
		
	}

	@Override
	public Reguide findById(long guidId) {
		Reguide dto = null;
		try {
			dto = mapper.findById(guidId);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		return dto;
	}

	@Override
	public Reguide findByPrev(Map<String, Object> map) {
		Reguide dto = null;
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}
		return dto;
	}

	@Override
	public Reguide findByNext(Map<String, Object> map) {
		Reguide dto = null;
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext : ", e);
		}
		return dto;
	}

	@Override
	public void updateReguide(Reguide dto, String uploadPath) throws Exception {
		try {
			if(dto.getSelectFile() != null && ! dto.getSelectFile().isEmpty()) {
				if(! dto.getImageFilename().isBlank()) {
					deleteUploadFile(uploadPath, dto.getImageFilename());
				}
				
				String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
				dto.setImageFilename(saveFilename);
			}
			mapper.updateReguide(dto);
		} catch (Exception e) {
			log.info("updateReguide : ", e);
			
			throw e;
		}
		
	}
	

	@Override
	public void deleteReguide(long guidId, Long memberId, int userLevel, String uploadPath, String filename)
			throws Exception {
		try {
			if (filename != null) {
				deleteUploadFile(uploadPath, filename);
			}

			 mapper.deleteReguide(guidId);
		} catch (Exception e) {
			log.info("deleteReguide : ", e);
			
			throw e;
		}
		
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		// TODO Auto-generated method stub
		return false;
	}


	@Override
	public void insertCategory(ReguideCategory dto) throws Exception {
		 try {
		        mapper.insertCategory(dto);
		    } catch (Exception e) {
		        log.info("insertCategory : ", e);
		        throw e;
		    }
	}

	@Override
	public List<ReguideCategory> listCategory() {
	    List<ReguideCategory> list = null;
	    try {
	        list = mapper.listCategory();
	    } catch (Exception e) {
	        log.info("listCategory : ", e);
	    }
	    return list;
	}

}
