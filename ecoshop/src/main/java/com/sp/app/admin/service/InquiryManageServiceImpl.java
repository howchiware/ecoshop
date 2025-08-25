package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.InquiryManageMapper;
import com.sp.app.admin.model.InquiryManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class InquiryManageServiceImpl implements InquiryManageService {

	private final InquiryManageMapper mapper;

	@Override
	public List<InquiryManage> listInquiry(Map<String, Object> map) {
		
		List<InquiryManage> list = null;
		
		try {
			list = mapper.listInquiry(map);
			
		} catch (Exception e) {
			log.info("listInquiry", e);
		}
		
		return list;
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount: ", e);
		}
		
		return result;
	}
	
	@Override
	public InquiryManage findByInquiry(long inquiryId) {

		InquiryManage dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByInquiry(inquiryId));
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {	
		} catch (Exception e) {
			log.info("findByInquiry: ", e);
		}
		
		return dto;		
	}


	@Override
	public void updateInquiry(InquiryManage dto) throws Exception {
		
		try {
			mapper.updateInquiry(dto);
		} catch (Exception e) {
			log.info("updateInquiry: ", e);
			throw e;
		}
		
	}
	
	@Override
	public List<InquiryManage> listCategory(Map<String, Object> map) {
		
		List<InquiryManage> listCategory = null;
		
		try {
			listCategory = mapper.listCategory(map);
			
		} catch (Exception e) {
			log.info("listCategory", e);
		}
		
		return listCategory;
		
	}

	@Override
	public void insertCategory(InquiryManage dto) throws Exception {
		
		try {	
			mapper.insertCategory(dto);
		} catch (Exception e) {
			log.info("insertCategory", e);
		}
		
	}

	@Override
	public void updateCategory(InquiryManage dto) throws Exception {
		
		try {
			mapper.updateCategory(dto);
		} catch (Exception e) {
			log.info("updateCategory: ", e);
			throw e;
		}
		
	}

	@Override
	public void deleteCategory(long categoryId) throws Exception {
		
		try {
			mapper.deleteCategory(categoryId);
		} catch (Exception e) {
			log.info("deleteCategory: ", e);
			throw e;
		}
		
	}


	@Override
	public InquiryManage getInquiryStats() {
		 return mapper.getInquiryStats();
	}

}
