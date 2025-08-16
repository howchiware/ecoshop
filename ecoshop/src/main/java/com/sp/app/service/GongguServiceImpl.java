package com.sp.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.GongguMapper;
import com.sp.app.model.GongguProduct;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GongguServiceImpl implements GongguService {
	private final GongguMapper gongguMapper;
	
	@Override
	public List<GongguProduct> listPackageByCategoryId(long categoryId) throws Exception {
		try {
			return gongguMapper.listPackageByCategoryId(categoryId);
		} catch (Exception e) {
			log.info("listPackageByCategoryId :", e);
		}
		
		return null;
		

	}

}
