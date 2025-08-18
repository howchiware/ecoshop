package com.sp.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.admin.model.FaqManage;
import com.sp.app.mapper.FaqMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FaqServiceImpl implements FaqService {

	private final FaqMapper mapper;

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
	public List<FaqManage> listCategory(Map<String, Object> map) {

		List<FaqManage> listCategory = null;

		try {
			listCategory = mapper.listCategory(map);

		} catch (Exception e) {
			log.info("listCategory", e);
		}

		return listCategory;

	}

}
