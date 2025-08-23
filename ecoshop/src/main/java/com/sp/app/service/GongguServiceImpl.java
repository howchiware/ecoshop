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
	        List<GongguProduct> dtoList = gongguMapper.listPackageByCategoryId(categoryId);

            if (dtoList != null) {
                for (GongguProduct dto : dtoList) {
                    long originalPrice = dto.getOriginalPrice();
                    long sale = dto.getSale();
                    
                    long gongguPrice = originalPrice;
                    if (sale > 0) {
                        gongguPrice = (long) (originalPrice - (originalPrice * sale / 100.0));
                    }
                    dto.setGongguPrice(gongguPrice);
                }
            }
	        return dtoList;
	    } catch (Exception e) {
	        log.error("listPackageByCategoryId : ", e);
	    }

	    return null;
	}
}