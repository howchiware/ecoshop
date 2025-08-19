package com.sp.app.admin.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.mapper.GongguManageMapper;
import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.model.GongguDeliveryRefundInfo;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.ProductStockManage;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GongguManageServiceImpl implements GongguManageService {

	private final GongguManageMapper gongguManageMapper;
	private final StorageService storageService;

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = gongguManageMapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<GongguManage> listProduct(Map<String, Object> map) {
		List<GongguManage> list = null;
		 
		 try {
			
			list = gongguManageMapper.listProduct(map);
			
		} catch (Exception e) {
			log.info("listProduct : ", e);
		}
		 
		return list;
	}
	
	@Override
	public GongguManage findById(long gongguProductId) {
		GongguManage dto = null;
		try {
			dto = gongguManageMapper.findById(gongguProductId);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		return dto;
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
	public boolean deleteUploadPhoto(String uploadPath, String photoName) {
		return storageService.deleteFile(uploadPath, photoName);
	}

	@Override
	public List<GongguManage> listProductPhoto(long gongguProductId) {
		List<GongguManage> list = null;
		
		try {
			list = gongguManageMapper.listProductPhoto(gongguProductId);
		} catch (Exception e) {
			log.info("listProductPhoto : ", e);
		}
		
		return list;
	}

	@Override
	public List<ProductStockManage> listProductStock(Map<String, Object> map) {
		List<ProductStockManage> list = null;
		
		try {
			list = gongguManageMapper.listProductStock(map);
		} catch (Exception e) {
			log.info("listProductStock : ", e);
		}
		
		return list;
	}

	@Override
	public void deleteProductPhoto(long gongguProductDetailId, String uploadPath) throws Exception {
		 try {
		        GongguManage dto = gongguManageMapper.findPhotoById(gongguProductDetailId); 
		        if (dto != null && !dto.getGongguPhotoName().isBlank()) {
		            storageService.deleteFile(uploadPath, dto.getGongguPhotoName());
		        }
		        gongguManageMapper.deleteProductPhoto(gongguProductDetailId);
		    } catch (Exception e) {
		        log.info("deleteGongguProductPhoto : ", e);
		        throw e;
		    }
	}

	@Override
	public CategoryManage findByCategory(long categoryId) {
		CategoryManage dto = null;
		
		try {
			dto = gongguManageMapper.findByCategory(categoryId);
		} catch (Exception e) {
			log.info("findByCategory : ", e);
		}
		
		return dto;
	}

	@Override
	public List<CategoryManage> listCategory() {
		try {
			List<CategoryManage> listCategory = gongguManageMapper.listCategory();
			
			return listCategory;
		} catch (Exception e) {
			log.info("listCategory : ", e);
			
			throw e;
		}
	}

	@Override
	public void insertGongguProduct(GongguManage dto, String uploadPath) throws Exception {
		try {
			// 썸네일 이미지
			String filename = storageService.uploadFileToServer(dto.getGongguThumbnailFile(), uploadPath);
			dto.setGongguThumbnail(filename);
			
			long gongguProductId = gongguManageMapper.gongguProductSeq();
			
			dto.setGongguProductId(gongguProductId);
			
			// 상품 저장
			gongguManageMapper.insertProduct(dto);
			
			// 추가 이미지 저장
			if(! dto.getAddFiles().isEmpty()) {
				insertProductPhoto(dto, uploadPath);
			}
			
		} catch (Exception e) {
			log.info("insertProduct : ", e);
			throw e;
		}
	}
	
	private void insertProductPhoto(GongguManage dto, String uploadPath) throws Exception {
		for (MultipartFile mf : dto.getAddFiles()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				dto.setGongguPhotoName(saveFilename);
				
				gongguManageMapper.insertProductPhoto(dto);
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
	}

	@Override
	public void updateGongguProduct(GongguManage dto, String uploadPath) throws Exception {
		try {
			// 썸네일 이미지
			String filename = storageService.uploadFileToServer(dto.getGongguThumbnailFile(), uploadPath);
			if(filename != null) {
				// 이전 파일 지우기
				if (! dto.getGongguThumbnail().isBlank()) {
					deleteUploadPhoto(uploadPath, dto.getGongguThumbnail());
				}
				
				dto.setGongguThumbnail(filename);
			}
			
			// 상품 수정
			gongguManageMapper.updateProduct(dto);
			
			// 추가 이미지
			if(! dto.getAddFiles().isEmpty()) {
				insertProductPhoto(dto, uploadPath);
			}
		
		} catch (Exception e) {
			log.info("updateProduct : ", e);
			
			throw e;
		}
	}

	@Override
	public void deleteGongguProduct(List<Long> gongguProductIds, String uploadPath) throws Exception {
		try {
			for(long gongguProductId : gongguProductIds) {
				GongguManage dto = gongguManageMapper.findById(gongguProductId);
				
				String pathString = uploadPath + File.separator + dto.getGongguPhotoName();
				
				List<GongguManage> photoList = gongguManageMapper.listProductPhoto(gongguProductId);
	            if (photoList != null) {
	                for (GongguManage photoDto : photoList) {
	                    storageService.deleteFile(uploadPath, photoDto.getGongguPhotoName());
	                }
	            }
				
	            gongguManageMapper.deleteProductPhoto(gongguProductId);

				gongguManageMapper.deleteProduct(dto.getGongguProductId());
			}
			
		} catch (Exception e) {
			log.info("deleteGongguProduct : ", e);
			
			throw e;
		}
		
	}
}