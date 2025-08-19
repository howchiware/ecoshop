package com.sp.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

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

}
