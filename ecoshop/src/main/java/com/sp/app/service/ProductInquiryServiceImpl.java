package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;
import com.sp.app.mapper.ProductInquiryMapper;
import com.sp.app.model.ProductInquiry;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductInquiryServiceImpl implements ProductInquiryService {
	private final ProductInquiryMapper mapper;
	private final StorageService storageService;
	private final MyUtil myUtil;
	
	@Override
	public void insertInquiry(ProductInquiry dto, String uploadPath) throws Exception {
		try {
			mapper.insertInquiry(dto);
		} catch (Exception e) {
			log.info("insertInquiry : ", e);
			
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
	public List<ProductInquiry> listInquiry(Map<String, Object> map) {
		List<ProductInquiry> list = null;
		
		try {
			list = mapper.listInquiry(map);
			
			for (ProductInquiry dto : list) {
				dto.setName(myUtil.nameMasking(dto.getName()));
				
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				
				if(dto.getAnswer() != null) {
					dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
				}
			}
		} catch (Exception e) {
			log.info("listInquiry : ", e);
		}
		
		return list;
	}
	@Override
	public int myDataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.myDataCount(map); 
		} catch (Exception e) {
			log.info("myDataCount : ", e);
		}
		
		return result;
	}
	@Override
	public List<ProductInquiry> listMyInquiry(Map<String, Object> map) {
		List<ProductInquiry> list = null;
		
		try {
			list = mapper.listMyInquiry(map);
			for (ProductInquiry dto : list) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				
				if(dto.getAnswer() != null) {
					dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
				}
			}			
		} catch (Exception e) {
			log.info("listMyInquiry : ", e);
		}
		
		return list;
	}
	@Override
	public void updateInquiry(ProductInquiry dto) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteInquiry(long inquiryId) throws Exception {
		try {
			mapper.deleteInquiry(inquiryId);
		} catch (Exception e) {
			log.info("deleteInquiry : ", e);
			
			throw e;
		}
	}
	

}
