package com.sp.app.admin.service;

import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.mapper.GongguManageMapper;
import com.sp.app.admin.model.GongguManage;
import com.sp.app.admin.model.GongguPackageManage;
import com.sp.app.admin.model.GongguProductDeliveryRefundInfoManage;
import com.sp.app.admin.model.ProductManage;
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
	public int dataCountGongguProduct(Map<String, Object> map) {
		int result = 0;
		try {
			result = gongguManageMapper.dataCountGongguProduct(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void insertGongguProduct(GongguManage dto, String uploadPath) throws Exception {
	    try {
	        dto.setStartDate(dto.getSday() + " " + dto.getStime() + ":00");
	        dto.setEndDate(dto.getEday() + " " + dto.getEtime() + ":00");
	        dto.setCategoryId(dto.getCategoryId());
	        dto.setLimitCount(dto.getLimitCount());
	        String filename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
	        dto.setGongguThumbnail(filename);
	        dto.setContent(dto.getContent());
	        dto.setDetailInfo(dto.getDetailInfo());
	        
	        dto.setSale(dto.getSale());
	        dto.setOriginalPrice(0);
	        
	        long gongguProductId = gongguManageMapper.gongguProductSeq();
	        dto.setGongguProductId(gongguProductId);
	        
	        gongguManageMapper.insertProduct(dto);
	        
	        if(! dto.getAddFiles().isEmpty()) {
	        	insertGongguProductPhoto(dto, uploadPath);
	        }
	    } catch (Exception e) {
	        log.info("insertProduct : ", e);
	        throw e;
	    }
	}
	
	public void insertGongguProductPhoto(GongguManage dto, String uploadPath) throws SQLException {
		for (MultipartFile mf : dto.getAddFiles()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				dto.setDetailPhoto(saveFilename);
				gongguManageMapper.insertGongguProductPhoto(dto);
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
	}
	
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void updateGongguProduct(GongguManage dto, String uploadPath) throws Exception {
	    try {
	        dto.setStartDate(dto.getSday() + " " + dto.getStime() + ":00");
	        dto.setEndDate(dto.getEday() + " " + dto.getEtime() + ":00");
	        dto.setCategoryId(dto.getCategoryId());
	        dto.setLimitCount(dto.getLimitCount());
	        dto.setDetailInfo(dto.getDetailInfo());
	        
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
	        
	        String updatedDetailInfo = processHtmlContentImages(dto.getDetailInfo(), uploadPath);
	        dto.setDetailInfo(updatedDetailInfo);
	        
	        gongguManageMapper.updateProduct(dto);

	        if(! dto.getAddFiles().isEmpty()) {
	        	insertGongguProductPhoto(dto, uploadPath);
	        }

	    } catch (Exception e) {
	    	log.info("updateProduct : ", e);
	    	
	        throw e;
	    }
	}
	
	private String processHtmlContentImages(String htmlContent, String uploadPath) {
	    if (htmlContent == null || htmlContent.trim().isEmpty()) {
	        return htmlContent;
	    }

	    Pattern pattern = Pattern.compile("<img[^>]*src=\"([^\"]+)\"");
	    Matcher matcher = pattern.matcher(htmlContent);

	    StringBuffer sb = new StringBuffer();
	    
	    while (matcher.find()) {
	        String imagePath = matcher.group(1);
	        
	        if (imagePath.startsWith("/uploads/editor/")) {
	            try {
	                String tempDirectoryPath = storageService.getRealPath("/uploads/editor");
	                
	                String filename = imagePath.substring(imagePath.lastIndexOf("/") + 1);
	                
	                String newFilename = storageService.transferFile(tempDirectoryPath, filename, uploadPath);
	                
	                if (newFilename != null) {
	                    String newUrl = "/uploads/gonggu/" + newFilename;
	                    matcher.appendReplacement(sb, "<img src=\"" + newUrl + "\"");
	                } else {
	                    matcher.appendReplacement(sb, matcher.group(0));
	                }
	            } catch (Exception e) {
	                log.error("HTML 이미지 처리 중 오류 발생: " + imagePath, e);
	                matcher.appendReplacement(sb, matcher.group(0));
	            }
	        } else {
	            matcher.appendReplacement(sb, matcher.group(0));
	        }
	    }
	    matcher.appendTail(sb);

	    return sb.toString();
	}
	
	@Override
	public boolean deleteUploadPhoto(String uploadPath, String photoName) {
		return storageService.deleteFile(uploadPath, photoName);
	}
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void deleteGongguProduct(List<Long> gongguProductIds, String uploadPath) throws Exception {
		try {
			for(long gongguProductId : gongguProductIds) {
			GongguManage dto = gongguManageMapper.findById(gongguProductId);
				
			String pathString = uploadPath + File.separator + dto.getGongguThumbnail();
			
			if (! dto.getGongguThumbnail().isBlank()) {
				deleteUploadPhoto(uploadPath, dto.getGongguThumbnail());
			}
			
			deleteGongguProductPhoto(dto.getGongguProductId(), pathString);
			
			gongguManageMapper.deleteProduct(gongguProductId);
			}
		} catch (Exception e) {
			log.info("deleteProduct : ", e);
			
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
			
			if (dto != null) {
				long price = dto.getOriginalPrice(); 
				long sale = dto.getSale(); 

				long gongguPrice = price; 

	            if (sale > 0 && price > 0) {
	                gongguPrice = (long) (price - (price * sale / 100.0));
	            }
	            dto.setGongguPrice(gongguPrice);
	        }
	    } catch (Exception e) {
	        log.error("findById : ", e);
	        throw e;
	    }
	    return dto;
	}


	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		return storageService.deleteFile(uploadPath, filename);
	}

	
	@Override
	public GongguProductDeliveryRefundInfoManage listGongguDeliveryRefundInfo() {
		try {
			GongguProductDeliveryRefundInfoManage dto = gongguManageMapper.listGongguDeliveryRefundInfo();
			return dto;
		} catch (Exception e) {
			log.info("listGongguDeliveryRefundInfo : ", e);
			throw e;

		}
	}

	@Override
	public List<GongguProductDeliveryRefundInfoManage> listGongguDeliveryFee() {
		try {
			List<GongguProductDeliveryRefundInfoManage> list = gongguManageMapper.listGongguDeliveryFee();
			return list;
		} catch (Exception e) {
			log.info("listGongguDeliveryFee : ", e);
			throw e;
		}
	}

	@Override
	public void insertGongguDeliveryRefundInfo(GongguProductDeliveryRefundInfoManage dto) {
		try {
			gongguManageMapper.insertGongguDeliveryRefundInfo(dto);
		} catch (Exception e) {
			log.info("insertGongguDeliveryRefundInfo : ", e);
			throw e;
		}	
	}
	
	@Override
	public void insertGongguDeliveryFee(Map<String, Object> map) {
		try {
			gongguManageMapper.insertGongguDeliveryFee(map);
		} catch (Exception e) {
			log.info("insertGongguDeliveryFee : ", e);
			throw e;
		}

	}

	@Override
	public void updateGongguDeliveryRefundInfo(GongguProductDeliveryRefundInfoManage dto) {
		try {
			gongguManageMapper.updateGongguDeliveryRefundInfo(dto);
		} catch (Exception e) {
			log.info("updateGongguDeliveryRefundInfo : ", e);
		}
	}

	@Override
	public void deleteGongguDeliveryFee() {
		try {
			gongguManageMapper.deleteGongguDeliveryFee();
		} catch (Exception e) {
			log.info("deleteGongguDeliveryFee : ", e);
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

	@Override
	public List<GongguManage> listGongguProductPhoto(long gongguProductId) {
		List<GongguManage> list = null;
		
		try {
			list = gongguManageMapper.listGongguProductPhoto(gongguProductId);
		} catch (Exception e) {
			log.info("listGongguProductPhoto : ", e);
		}
		
		return list;
	}

	@Override
	public void deleteGongguProductPhoto(long gongguProductId, String uploadPath) throws Exception {
		try {
			if (uploadPath != null && ! uploadPath.isBlank()) {
				storageService.deleteFile(uploadPath);
			}

			gongguManageMapper.deleteGongguProductPhoto(gongguProductId);
		} catch (Exception e) {
			log.info("deleteGongguProductPhoto : ", e);
			
			throw e;
		}
	}

	// 패키지 구성 넣기
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void insertGongguPackage(GongguPackageManage dto) throws Exception {
	    try {
	        GongguManage gongguDto = gongguManageMapper.findById(dto.getGongguProductId());
	        
	        if (gongguDto != null) {
	            dto.setStock(gongguDto.getLimitCount());
	        }
	        
	        gongguManageMapper.insertGongguPackage(dto);
	        updateOriginalPrice(dto.getGongguProductId());
	        
	        Map<String, Object> map = new HashMap<>();
	        map.put("gongguProductId", dto.getGongguProductId());
	        
	        List<GongguPackageManage> packageList = gongguManageMapper.listPackage(map);
	        dto.setPackageNum(packageList.get(0).getPackageNum());
	        
	    } catch (Exception e) {
	        log.error("insertGongguPackage : ", e);
	        throw e;
	    }
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public long deleteGongguPackage(long packageNum) throws Exception {
	    GongguPackageManage dto = gongguManageMapper.findPacById(packageNum);
	    long gongguProductId = dto.getGongguProductId();
	    
	    gongguManageMapper.deleteGongguPackage(packageNum);
	    
	    long originalPrice = gongguManageMapper.sumPackagePrices(gongguProductId);

	    Map<String, Object> map = new HashMap<>();
	    map.put("gongguProductId", gongguProductId);
	    map.put("originalPrice", originalPrice);
	    gongguManageMapper.updateOnlyOriginalPrice(map);
	    
	    return gongguProductId; 
	}

	@Override
	public List<ProductManage> productSearch(Map<String, Object> map) {
	    List<ProductManage> list = null; 
	    try {
	        list = gongguManageMapper.productSearch(map);
	    } catch (Exception e) {
	    	log.error("productSearch : ", e);
	    }
	    return list;
	}

	@Override
	public void deleteSingleProductPhoto(long gongguProductDetailId, String uploadPath) throws Exception {
	    try {
	        GongguManage dto = gongguManageMapper.findByProductDetailId(gongguProductDetailId);
	        
	        if (dto != null && !dto.getDetailPhoto().isBlank()) {
	            storageService.deleteFile(uploadPath, dto.getDetailPhoto());
	        }
	        gongguManageMapper.deleteSingleGongguProductPhoto(gongguProductDetailId);
	    } catch (Exception e) {
	        log.error("deleteSingleGongguProductPhoto : ", e);
	        throw e;
	    }
	}

	@Override
	public List<GongguPackageManage> listPackage(Map<String, Object> map) throws Exception {
	    List<GongguPackageManage> list = null;
	    try {
	        list = gongguManageMapper.listPackage(map);
	    } catch (Exception e) {
	        log.error("listPackage : ", e);
	        throw e;
	    }
	    return list;
	}

	@Override
	public long calculateOriginalPrice(long gongguProductId) throws Exception {
		long originalPrice = 0;
	    try {
	        originalPrice = gongguManageMapper.sumPackagePrices(gongguProductId);
	    } catch (Exception e) {
	        log.error("calculateOriginalPrice : ", e);
	        throw e;
	    }
	    return originalPrice;
	}
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void updateOriginalPrice(long gongguProductId) throws Exception {
	    try {
	    	long originalPrice = gongguManageMapper.sumPackagePrices(gongguProductId);

	        Map<String, Object> map = new HashMap<>();
	        map.put("gongguProductId", gongguProductId);
	        map.put("originalPrice", originalPrice);
	        
	        gongguManageMapper.updateOnlyOriginalPrice(map); 
	        
	    } catch (Exception e) {
	        log.error("updateOriginalPrice : ", e);
	        throw e;
	    }
	}

	@Override
	public GongguPackageManage findPacById(long packageNum) {
	    GongguPackageManage dto = null;
	    try {
	        dto = gongguManageMapper.findPacById(packageNum);
	    } catch (Exception e) {
	        log.error("findPacById : ", e);
	    }
	    return dto;
	}
	
}
