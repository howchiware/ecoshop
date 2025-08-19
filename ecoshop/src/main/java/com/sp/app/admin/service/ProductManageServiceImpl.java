package com.sp.app.admin.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.mapper.ProductManageMapper;
import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.model.ProductDeliveryRefundInfoManage;
import com.sp.app.admin.model.ProductManage;
import com.sp.app.admin.model.ProductStockManage;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductManageServiceImpl implements ProductManageService {

	private final ProductManageMapper mapper;
	private final StorageService storageService;
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void insertProduct(ProductManage dto, String uploadPath) throws Exception {
		try {
			// 썸네일 이미지
			String filename = storageService.uploadFileToServer(dto.getThumbnailFile(), uploadPath);
			dto.setThumbnail(filename);
			
			long productId = mapper.productSeq();
			
			dto.setProductId(productId);
			dto.setProductCode(productCodeGenerate(productId));
			
			// 상품 저장
			mapper.insertProduct(dto);
			
			// 추가 이미지 저장
			if(! dto.getAddFiles().isEmpty()) {
				insertProductPhoto(dto, uploadPath);
			}
			
			// 옵션 추가
			if(dto.getOptionCount() > 0) {
				insertProductOption(dto);
			}
			
		} catch (Exception e) {
			log.info("insertProduct : ", e);
			throw e;
		}
	}
	
	private void insertProductPhoto(ProductManage dto, String uploadPath) throws Exception {
		for (MultipartFile mf : dto.getAddFiles()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				dto.setPhotoName(saveFilename);
				
				mapper.insertProductPhoto(dto);
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
	}
	
	private void insertProductOption(ProductManage dto) throws Exception{
		try {
			long optionNum = 0, optionNum2 = 0;
			long optionDetailNum;
			
			// 옵션1 추가
			if(dto.getOptionCount() > 0) {
				optionNum = mapper.optionSeq();
				dto.setOptionNum(optionNum);
				dto.setParentOption(null);
				mapper.insertProductOption(dto);
				
				// 옵션1 값 추가
				dto.setOptionDetailNums(new ArrayList<Long>());
				for(String optionValue : dto.getOptionValues()) {
					optionDetailNum = mapper.detailSeq();
					dto.setOptionDetailNum(optionDetailNum);
					dto.setOptionValue(optionValue);
					
					mapper.insertOptionDetail(dto);
					
					dto.getOptionDetailNums().add(optionDetailNum);
				}
			}
			
			// 옵션2 추가
			if(dto.getOptionCount() > 1) {
				optionNum2 = mapper.optionSeq();
				dto.setOptionNum(optionNum2);
				dto.setOptionName(dto.getOptionName2());
				dto.setParentOption(optionNum);
				mapper.insertProductOption(dto);
				
				// 옵션2 값 추가
				dto.setOptionDetailNums2(new ArrayList<Long>());
				for(String optionValue2 : dto.getOptionValues2()) {
					optionDetailNum = mapper.detailSeq();
					dto.setOptionDetailNum(optionDetailNum);
					dto.setOptionValue(optionValue2);
					
					mapper.insertOptionDetail(dto);
					
					dto.getOptionDetailNums2().add(optionDetailNum);
				}
			}
		} catch (Exception e) {
			log.info("insertProductOption : ", e);
			
			throw e;
		}
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void updateProduct(ProductManage dto, String uploadPath) throws Exception {
		try {
			// 썸네일 이미지
			String filename = storageService.uploadFileToServer(dto.getThumbnailFile(), uploadPath);
			if(filename != null) {
				// 이전 파일 지우기
				if (! dto.getThumbnail().isBlank()) {
					deleteUploadPhoto(uploadPath, dto.getThumbnail());
				}
				
				dto.setThumbnail(filename);
			}
			
			// 상품 수정
			mapper.updateProduct(dto);
			
			// 추가 이미지
			if(! dto.getAddFiles().isEmpty()) {
				insertProductPhoto(dto, uploadPath);
			}
			
			// 옵션 수정
			updateProductOption(dto);
		
		} catch (Exception e) {
			log.info("updateProduct : ", e);
			
			throw e;
		}
	}
	
	private void updateProductOption(ProductManage dto) throws Exception {
		try {
			if(dto.getOptionCount() == 0) {
				// 기존 옵션1, 옵션2 삭제
				if(dto.getPrevOptionNum2() != 0) {
					mapper.deleteOptionDetail2(dto.getPrevOptionNum2());
					mapper.deleteProductOption(dto.getPrevOptionNum2());
				}
				
				if(dto.getPrevOptionNum() != 0) {
					mapper.deleteOptionDetail2(dto.getPrevOptionNum());
					mapper.deleteProductOption(dto.getPrevOptionNum());
				}
				
				return;
			} else if(dto.getOptionCount() == 1) {
				// 기존 옵션 2 삭제
				if(dto.getPrevOptionNum2() != 0) {
					mapper.deleteOptionDetail2(dto.getPrevOptionNum2());
					mapper.deleteProductOption(dto.getPrevOptionNum2());
				}
			}
			
			long detailNum, parentNum;
			
			// 옵션1 -----
			// 옵션1이 없는 상태에서 옵션1을 추가한 경우
			if(dto.getOptionNum() == 0) {
				insertProductOption(dto);
				return;
			}
			// 옵션1이 존재하는 경우 옵션1 수정
			mapper.updateProductOption(dto);
			
			// 기존 옵션1 옵션값 수정
			int size = dto.getOptionDetailNums().size();
			for(int i = 0; i < size; i++) {
				dto.setOptionDetailNum(dto.getOptionDetailNums().get(i));
				dto.setOptionValue(dto.getOptionValues().get(i));
				mapper.updateOptionDetail(dto);
			}

			// 새로운 옵션1 옵션값 추가
			dto.setOptionDetailNums(new ArrayList<Long>());
			for(int i = size; i < dto.getOptionValues().size(); i++) {
				detailNum = mapper.detailSeq(); 
				dto.setOptionDetailNum(detailNum);
				dto.setOptionValue(dto.getOptionValues().get(i));
				mapper.insertOptionDetail(dto);
				
				dto.getOptionDetailNums().add(detailNum);
			}

			// 옵션2 -----
			if(dto.getOptionCount() > 1) {
				//  옵션2가 없는 상태에서 옵션2를 추가한 경우
				parentNum = dto.getOptionNum(); // 옵션1 옵션번호 
				if(dto.getOptionNum2() == 0) {
					long optionNum2 = mapper.optionSeq();
					dto.setOptionNum(optionNum2);
					dto.setOptionName(dto.getOptionName2());
					dto.setParentOption(parentNum);
					mapper.insertProductOption(dto);
					
					// 옵션 2 값 추가
					dto.setOptionDetailNums2(new ArrayList<Long>());
					for(String optionValue2 : dto.getOptionValues2()) {
						detailNum = mapper.detailSeq(); 
						dto.setOptionDetailNum(detailNum);
						dto.setOptionValue(optionValue2);
						mapper.insertOptionDetail(dto);
						
						dto.getOptionDetailNums2().add(detailNum);
					}
					
					return;
				} 
				
				// 옵션2 가 존재하는 경우 옵션2 수정
				dto.setOptionNum(dto.getOptionNum2());
				dto.setOptionName(dto.getOptionName2());
				mapper.updateProductOption(dto);
				
				// 기존 옵션2 옵션값 수정
				int size2 = dto.getOptionDetailNums2().size();
				for(int i = 0; i < size2; i++) {
					dto.setOptionDetailNum(dto.getOptionDetailNums2().get(i));
					dto.setOptionValue(dto.getOptionValues2().get(i));
					mapper.updateOptionDetail(dto);
				}
	
				// 새로운 옵션2 옵션값 추가
				dto.setOptionDetailNums2(new ArrayList<Long>());
				for(int i = size2; i < dto.getOptionValues2().size(); i++) {
					detailNum = mapper.detailSeq(); 
					dto.setOptionDetailNum(detailNum);
					dto.setOptionValue(dto.getOptionValues2().get(i));
					mapper.insertOptionDetail(dto);
					
					dto.getOptionDetailNums2().add(detailNum);
				}
			}
		} catch (Exception e) {
			log.info("updateProductOption : ", e);
			
			throw e;
		}
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void deleteProduct(List<Long> productIds, String uploadPath) throws Exception {
		
		try {
			for(long productId : productIds) {
				ProductManage dto = mapper.findById(productId);
				
				String pathString = uploadPath + File.separator + dto.getPhotoName();
				
				List<Long> productOptionNum = mapper.optionFindByCode(dto.getProductId());
				
				// 파일 삭제(thumbnail)
				if (! dto.getThumbnail().isBlank()) {
					deleteUploadPhoto(uploadPath, dto.getThumbnail());
				}
				
				// 추가 파일 삭제
				deleteProductPhoto(dto.getProductId(), pathString);
				
				// 재고 삭제
				mapper.deleteProductStock(dto.getProductId());
				
				// 옵션 삭제
				if(dto.getOptionCount() == 2) {
					for(long optionNum : productOptionNum) {
						mapper.deleteOptionDetail2(optionNum);
					}
					if(productOptionNum.get(0) > productOptionNum.get(1)) {
						mapper.deleteProductOption(productOptionNum.get(0));
						mapper.deleteProductOption(productOptionNum.get(1));
					} else if(productOptionNum.get(0) < productOptionNum.get(1)) {
						mapper.deleteProductOption(productOptionNum.get(1));
						mapper.deleteProductOption(productOptionNum.get(0));
					}
				}
				else if(dto.getOptionCount() == 1) {
					// 기존 옵션1, 옵션2 삭제
					for(long optionNum : productOptionNum) {
						mapper.deleteOptionDetail2(optionNum);
						mapper.deleteProductOption(optionNum);
					}
				}
				
				// 상품 삭제
				mapper.deleteProduct(dto.getProductId());
			}
			
		} catch (Exception e) {
			log.info("deleteProduct : ", e);
			
			throw e;
		}
		
	}

	@Override
	public void deleteProductPhoto(long productCode, String uploadPath) throws Exception {
		try {
			if (uploadPath != null && ! uploadPath.isBlank()) {
				storageService.deleteFile(uploadPath);
			}

			mapper.deleteProductPhoto(productCode);
		} catch (Exception e) {
			log.info("deleteProductFile : ", e);
			
			throw e;
		}
	}

	@Override
	public void deleteOptionDetail(long optionDetailNum) throws Exception {
		// TODO Auto-generated method stub
		
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
	public List<ProductManage> listProduct(Map<String, Object> map) {
		 List<ProductManage> list = null;
		 
		 try {
			
			list = mapper.listProduct(map);
			
			for(ProductManage dto : list) {
				dto.setProductCode(productCodeGenerate(Long.parseLong(dto.getProductCode())));
			}
		} catch (Exception e) {
			log.info("listProduct : ", e);
		}
		 
		return list;
	}

	@Override
	public ProductManage findById(long productId) {
		ProductManage dto = null;
		
		try {
			dto = mapper.findById(productId);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}

	@Override
	public ProductManage findByPrev(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductManage findByNext(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductManage> listProductPhoto(long productId) {
		List<ProductManage> list = null;
		
		try {
			list = mapper.listProductPhoto(productId);
		} catch (Exception e) {
			log.info("listProductPhoto : ", e);
		}
		
		return list;
	}

	@Override
	public List<ProductManage> listProductOption(long productId) {
		List<ProductManage> list = null;
		
		try {
			list = mapper.listProductOption(productId);
		} catch (Exception e) {
			log.info("listProductOption : ", e);
		}
		
		return list;
	}

	@Override
	public List<ProductManage> listOptionDetail(long optionNum) {
		List<ProductManage> list = null;
		
		try {
			list = mapper.listOptionDetail(optionNum);
		} catch (Exception e) {
			log.info("listOptionDetail : ", e);
		}
		
		return list;
	}

	@Override
	public CategoryManage findByCategory(long categoryId) {
		CategoryManage dto = null;
		
		try {
			dto = mapper.findByCategory(categoryId);
		} catch (Exception e) {
			log.info("findByCategory : ", e);
		}
		
		return dto;
	}

	@Override
	public List<CategoryManage> listCategory() {
		try {
			List<CategoryManage> listCategory = mapper.listCategory();
			
			return listCategory;
		} catch (Exception e) {
			log.info("listCategory : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateProductStock(ProductStockManage dto) throws Exception {
		try {
			// 상세 옵션별 재고 추가 또는 변경
			for(int idx = 0; idx < dto.getStockNums().size(); idx++) {
				dto.setStockNum(dto.getStockNums().get(idx));
				if(dto.getOptionDetailNums() != null && dto.getOptionDetailNums().get(idx) != 0){
					dto.setOptionDetailNum(dto.getOptionDetailNums().get(idx));
				}
				if(dto.getOptionDetailNums2() != null && dto.getOptionDetailNums2().get(idx) != 0) {
					dto.setOptionDetailNum2(dto.getOptionDetailNums2().get(idx));
				}
				dto.setTotalStock(dto.getTotalStocks().get(idx));
				
				if(dto.getStockNum() == 0) {
					mapper.insertProductStock(dto);
				} else {
					mapper.updateProductStock(dto);
				}
			}
			
		} catch (Exception e) {
			log.info("updateProductStock : ", e);
			
			throw e;
		}
	}

	@Override
	public List<ProductStockManage> listProductStock(Map<String, Object> map) {
		List<ProductStockManage> list = null;
		
		try {
			list = mapper.listProductStock(map);
		} catch (Exception e) {
			log.info("listProductStock : ", e);
		}
		
		return list;
	}

	@Override
	public boolean deleteUploadPhoto(String uploadPath, String photoName) {
		return storageService.deleteFile(uploadPath, photoName);
	}
	
	public String productCodeGenerate(long id) {
		String result;
		
		result = String.format("%06d", id);
		 
		return result;
	}

	@Override
	public ProductDeliveryRefundInfoManage listDeliveryRefundInfo() {
		try {
			ProductDeliveryRefundInfoManage dto = mapper.listDeliveryRefundInfo();
			
			return dto;
		} catch (Exception e) {
			log.info("listDeliveryRefundInfo : ", e);
			
			throw e;
		}
	}

	@Override
	public List<ProductDeliveryRefundInfoManage> listDeliveryFee() {
		try {
			List<ProductDeliveryRefundInfoManage> list = mapper.listDeliveryFee();
			
			return list;
		} catch (Exception e) {
			log.info("listDeliveryRefundInfo : ", e);
			
			throw e;
		}
	}

	@Override
	public void insertProductDeliveryRefundInfo(ProductDeliveryRefundInfoManage dto) {
		try {
			mapper.insertProductDeliveryRefundInfo(dto);
		} catch (Exception e) {
			log.info("insertProductDeliveryRefundInfo : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateProductDeliveryRefundInfo(ProductDeliveryRefundInfoManage dto) {
		try {
			mapper.updateProductDeliveryRefundInfo(dto);
		} catch (Exception e) {
			log.info("updateProductDeliveryRefundInfo : ", e);
			
			throw e;
		}
	}

	@Override
	public void insertProductDeliveryFee(Map<String, Object> map) {
		try {
			mapper.insertProductDeliveryFee(map);
		} catch (Exception e) {
			log.info("insertProductDeliveryFee : ", e);
			
			throw e;
		}
	}

	@Override
	public void deleteProductDeliveryFee() {
		try {
			mapper.deleteProductDeliveryFee();
		} catch (Exception e) {
			log.info("deleteProductDeliveryFee : ", e);
			
			throw e;
		}
	};

}
