package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.mapper.CategoryManageMapper;
import com.sp.app.admin.mapper.ProductManageMapper;
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
			dto.setProductCode(productId);
			
			// 상품 저장
			mapper.insertProduct(dto);
			
			// 추가 이미지 저장
			if(! dto.getAddFiles().isEmpty()) {
				insertProductFile(dto, uploadPath);
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
	
	private void insertProductFile(ProductManage dto, String uploadPath) throws Exception {
		for (MultipartFile mf : dto.getAddFiles()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				dto.setPhotoName(saveFilename);
				
				mapper.insertProductFile(dto);
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

	@Override
	public void updateProduct(ProductManage dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteProduct(long productId, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteProductPhoto(long productPhotoNum, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteOptionDetail(long optionDetailNum) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProductManage> listProduct(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductManage findById(long productId) {
		// TODO Auto-generated method stub
		return null;
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductManage> listProductOption(long productId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductManage> listOptionDetail(long optionNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductManage findByCategory(long categoryNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductManage> listCategory() {
		try {
			List<ProductManage> listCategory = mapper.listCategory();
			
			return listCategory;
		} catch (Exception e) {
			log.info("listCategory : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateProductStock(ProductStockManage dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ProductStockManage> listProductStock(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteUploadPhoto(String uploadPath, String photoName) {
		// TODO Auto-generated method stub
		return false;
	}
	
	public long productCodeGenerate(long id) {
		long result;
		
		String resultStr = String.format("%06d", id);
		result = Long.parseLong(resultStr);
		 
		return result;
	};

}
