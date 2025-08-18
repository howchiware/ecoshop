package com.sp.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.InquiryManageMapper;
import com.sp.app.admin.model.InquiryManage;
import com.sp.app.mapper.InqMapper;
import com.sp.app.model.Inquiry;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class InquiryServiceImpl implements InquiryService {
	
	private final InquiryManageMapper inqMapper;
	private final InqMapper mapper;

	@Override
	public void insertInq(Inquiry dto) throws Exception {
		
		try {
			mapper.insertInq(dto);
		} catch (Exception e) {
			log.info("insertInq: ", e);
		}
	}

	@Override
	public void updateInq(Inquiry dto) throws Exception {
		
		try {
			mapper.updateInq(dto);
		} catch (Exception e) {
			log.info("updateInq: ", e);
		}
		
	}

	@Override
	public void deleteInq(Inquiry dto) throws Exception {
	
		try {
			mapper.deleteInq(dto);
		} catch (Exception e) {
			log.info("deleteFaq: ", e);
		}
		
	}

	@Override
	public List<InquiryManage> listCategory(Map<String, Object> map) {
		
		List<InquiryManage> listCategory = null;
		
		try {
			listCategory = inqMapper.listCategory(map);
		} catch (Exception e) {
			log.info("listCategory: ", e);
		}
		
		return listCategory;
	}

	@Override
	public Inquiry findByInq(Long inquiryId) {
		
		Inquiry dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByInq(inquiryId));
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {	
		} catch (Exception e) {
			log.info("findByInq: ", e);
		}
		
		return dto;		
	}

	@Override
	public List<Inquiry> listInqByMember(Map<String, Object> map) {
		
		List<Inquiry> list = null;

		try {
			list = mapper.listInqByMember(map);

		} catch (Exception e) {
			log.info("listInq: ", e);
		}

		return list;

	}

	@Override
	public Inquiry findByInq(long inquiryId) {
		
		Inquiry dto = null;

		try {
			dto = Objects.requireNonNull(mapper.findByInq(inquiryId));
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findByInq: ", e);
		}

		return dto;
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

}
