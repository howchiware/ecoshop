package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.FaqManageMapper;
import com.sp.app.admin.model.FaqManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FaqManageServiceImpl implements FaqManageService {

	private final FaqManageMapper mapper;

	@Override
	public List<FaqManage> listFaq(Map<String, Object> map) {
		
		List<FaqManage> list = null;
		
		try {
			list = mapper.listFaq(map);
			
		} catch (Exception e) {
			log.info("listFaq", e);
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
	public void insertFaq(FaqManage dto) throws Exception {
		
		try {	
			mapper.insertFaq(dto);
		} catch (Exception e) {
			log.info("insertFaq: ", e);
		}
	}
	
	@Override
	public FaqManage findByFaq(long faqId) {

		FaqManage dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByFaq(faqId));
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {	
		} catch (Exception e) {
			log.info("findByFaq: ", e);
		}
		
		return dto;		
	}


	@Override
	public void updateFaq(FaqManage dto) throws Exception {
		
		try {
			mapper.updateFaq(dto);
		} catch (Exception e) {
			log.info("updateFaq: ", e);
			throw e;
		}
		
	}

	@Override
	public void deleteFaq(Map<String, Object> map) throws Exception {
		
		try {
			mapper.deleteFaq(map);
		} catch (Exception e) {
			log.info("deleteFaq: ", e);
			throw e;
		}
		
	}
	
	@Override
	public List<FaqManage> listCategory(Map<String, Object> map) {
		
		List<FaqManage> listCategory = null;
		
		try {
			listCategory = mapper.listCategory(map);
			
		} catch (Exception e) {
			log.info("listCategory", e);
		}
		
		return listCategory;
		
	}

	@Override
	public void insertCategory(FaqManage dto) throws Exception {
		
		try {	
			mapper.insertCategory(dto);
		} catch (Exception e) {
			log.info("insertCategory", e);
		}
		
	}

	@Override
	public void updateCategory(FaqManage dto) throws Exception {
		
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

	
	
	

}
