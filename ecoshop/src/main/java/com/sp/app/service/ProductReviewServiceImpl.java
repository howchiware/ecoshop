package com.sp.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.mapper.ProductReviewMapper;
import com.sp.app.model.ProductReview;
import com.sp.app.model.Summary;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductReviewServiceImpl implements ProductReviewService {
	private final ProductReviewMapper mapper;
	private final StorageService storageService;
	private final MyUtil myUtil;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int dataCount = 0;
		
		try {
			dataCount = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return dataCount;
	}
	
	@Override
	public List<ProductReview> listReview(Map<String, Object> map) {
		List<ProductReview> list = null;
		
		try {
			list = mapper.listReview(map);
			
			for (ProductReview dto : list) {
				dto.setName(myUtil.nameMasking(dto.getName()));
				
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				
				if(dto.getAnswer() != null) {
					dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
				}
			}
		} catch (Exception e) {
			log.info("listReview : ", e);
		}
		
		return list;
	}

	@Override
	public Summary findByReviewSummary(Map<String, Object> map) {
		Summary dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByReviewSummary(map));
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByReviewSummary : ", e);
		}
		
		return dto;
	}

	@Override
	public void insertReview(ProductReview dto, String uploadPath) throws Exception {
		try {
			mapper.insertReview(dto);
			
			if( ! dto.getSelectFile().isEmpty() ) {
				insertReviewPhoto(dto, uploadPath);
			}
			
		} catch (Exception e) {
			log.info("insertReview : ", e);
			
			throw e;
		}
	}
	
	protected void insertReviewPhoto(ProductReview dto, String uploadPath) throws Exception {
		for (MultipartFile mf : dto.getSelectFile()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				
				dto.setReviewImg(saveFilename);

				mapper.insertReviewPhoto(dto);
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
	}	

}
