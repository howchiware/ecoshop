package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.GongguManageMapper;
import com.sp.app.admin.model.GongguDeliveryRefundInfo;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.common.StorageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GongguManageServiceImpl implements GongguManageService {
	private final GongguManageMapper gongguManageMapper;
	private final StorageService storageService;
	
	@Override
	public int dataCountGongguProduct(Map<String, Object> map) {
		int result = 0;
		try {
			result = gongguManageMapper.dataCountGongguProduct(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String removeHtmlTags(String content) {
	    return content.replaceAll("<[^>]*>", ""); 
	}

	@Override
	public void insertGongguProduct(GongguManage dto, String uploadPath) throws Exception {
		try {
			dto.setStartDate(dto.getSday() + " " + dto.getStime() + ":00");
			dto.setEndDate(dto.getEday() + " " + dto.getEtime() + ":00");
			dto.setCategoryId(dto.getCategoryId());
			dto.setLimitCount(dto.getLimitCount());
			String filename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
			dto.setGongguThumbnail(filename);
			String cleanedContent = removeHtmlTags(dto.getContent());
		    dto.setContent(cleanedContent);

			
			gongguManageMapper.insertProduct(dto);
		} catch (Exception e) {
			log.info("insertProduct : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateGongguProduct(GongguManage dto, String uploadPath) throws Exception {
	    try {
	        dto.setStartDate(dto.getSday() + " " + dto.getStime() + ":00");
	        dto.setEndDate(dto.getEday() + " " + dto.getEtime() + ":00");
	        dto.setCategoryId(dto.getCategoryId());
	        dto.setLimitCount(dto.getLimitCount());
	        String cleanedContent = removeHtmlTags(dto.getContent());
	        dto.setContent(cleanedContent);

	        String filename = null;
	        if (dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) {
	            filename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
	            if (filename != null) {
	                if (dto.getGongguThumbnail().length() != 0) {
	                    deleteUploadFile(uploadPath, dto.getGongguThumbnail());
	                }
	                dto.setGongguThumbnail(filename); 
	            }
	        }

	        gongguManageMapper.updateProduct(dto);

	    } catch (Exception e) {
	    	log.info("updateProduct : ", e);
	    	
	        throw e;
	    }
	}

	
	@Override
	public void deleteGongguProduct(long gongguProductId, String pathString) throws Exception {
		try {
			if (pathString != null && ! pathString.isBlank()) {
				storageService.deleteFile(pathString);
			}

			gongguManageMapper.deleteProduct(gongguProductId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public List<GongguManage> listProduct(Map<String, Object> map) {
		List<GongguManage> list = null;
		 
		 try {
			list = gongguManageMapper.listGongguProduct(map);	
		} catch (Exception e) {
			log.info("listProduct : ", e);
		}
		 
		return list;
	}
	
	@Override
	public GongguManage findById(long gongguProductId) {
		GongguManage dto = null;
		try {
			dto = Objects.requireNonNull(gongguManageMapper.findById(gongguProductId));

			dto.setSday(dto.getStartDate().substring(0, 10));
			dto.setStime(dto.getStartDate().substring(11));
				
			dto.setEday(dto.getEndDate().substring(0, 10));
			dto.setEtime(dto.getEndDate().substring(11));

		} catch (NullPointerException e) {
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}


	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		return storageService.deleteFile(uploadPath, filename);
	}

	
	@Override
	public GongguDeliveryRefundInfo listDeliveryRefundInfo() {
		try {
			GongguDeliveryRefundInfo dto = gongguManageMapper.listDeliveryRefundInfo();
			return dto;
		} catch (Exception e) {
			log.info("listDeliveryRefundInfo : ", e);
			throw e;

		}
	}

	@Override
	public List<GongguDeliveryRefundInfo> listDeliveryFee() {
		try {
			List<GongguDeliveryRefundInfo> list = gongguManageMapper.listDeliveryFee();
			return list;
		} catch (Exception e) {
			log.info("listDeliveryRefundInfo : ", e);
			throw e;
		}
	}

	@Override
	public void insertProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto) {
		try {
			gongguManageMapper.insertProductDeliveryRefundInfo(dto);
		} catch (Exception e) {
			log.info("insertProductDeliveryRefundInfo : ", e);
			throw e;
		}	
	}
	
	@Override
	public void insertProductDeliveryFee(Map<String, Object> map) {
		try {
			gongguManageMapper.insertProductDeliveryFee(map);
		} catch (Exception e) {
			log.info("insertProductDeliveryFee : ", e);
			throw e;
		}

	}

	@Override
	public void updateProductDeliveryRefundInfo(GongguDeliveryRefundInfo dto) {
		try {
			gongguManageMapper.updateProductDeliveryRefundInfo(dto);
		} catch (Exception e) {
			log.info("updateProductDeliveryRefundInfo : ", e);
		}
	}

	@Override
	public void deleteProductDeliveryFee() {
		try {
			gongguManageMapper.deleteProductDeliveryFee();
		} catch (Exception e) {
			log.info("deleteProductDeliveryFee : ", e);
			throw e;
		}
	}


	@Override
	public List<GongguManage> listCategory() {
		List<GongguManage> list = null;
		
		try {
			list = gongguManageMapper.listCategory();
		} catch (Exception e) {
			log.info("listCategory : ", e);
		}
		return list;
	}

	@Override
	public GongguManage findByCategory(long categoryId) {
		GongguManage dto = null;
		
		try {
			dto = gongguManageMapper.findByCategory(categoryId);
		} catch (Exception e) {
			log.info("findByCategory : ", e);
		}
		
		return dto;
	}
}
