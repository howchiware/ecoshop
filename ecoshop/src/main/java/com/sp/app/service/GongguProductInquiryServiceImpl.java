package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.mapper.GongguProductInquiryMapper;
import com.sp.app.model.GongguProductInquiry;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GongguProductInquiryServiceImpl implements GongguProductInquiryService {
	private final GongguProductInquiryMapper mapper;
	private final MyUtil myUtil;
	
	@Override
	public void insertGongguInquiry(GongguProductInquiry dto, String uploadPath) throws Exception {
		try {
			mapper.insertInquiry(dto);
		} catch (Exception e) {
			log.info("insertInquiry : ", e);
			
			throw e;
		}
	}
	@Override
	public int dataCountGonggu(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map); 
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}
	@Override
	public List<GongguProductInquiry> listGongguInquiry(Map<String, Object> map) {
		List<GongguProductInquiry> list = null;
		
		try {
			list = mapper.listInquiry(map);
			
			for (GongguProductInquiry dto : list) {
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
	public int myGongguDataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.myDataCount(map); 
		} catch (Exception e) {
			log.info("myDataCount : ", e);
		}
		
		return result;
	}
	@Override
	public List<GongguProductInquiry> listMyGongguInquiry(Map<String, Object> map) {
		List<GongguProductInquiry> list = null;
		
		try {
			list = mapper.listMyInquiry(map);
			for (GongguProductInquiry dto : list) {
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
	public void updateGongguInquiry(GongguProductInquiry dto) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteGongguInquiry(long gongguInquiryId) throws Exception {
		try {
			mapper.deleteInquiry(gongguInquiryId);
		} catch (Exception e) {
			log.info("deleteInquiry : ", e);
			
			throw e;
		}
	}
	

}
