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
		// TODO Auto-generated method stub
		
	}
	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public List<ProductInquiry> listInquiry(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int dataCountManage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public List<ProductInquiry> listInquiryManage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void updateInquiry(ProductInquiry dto) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteInquiry(long num, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}
	

}
