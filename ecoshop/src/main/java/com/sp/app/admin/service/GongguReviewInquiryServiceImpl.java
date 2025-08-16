package com.sp.app.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.GongguReviewInquiryManageMapper;
import com.sp.app.admin.model.GongguInquiryManage;
import com.sp.app.admin.model.GongguReviewManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GongguReviewInquiryServiceImpl implements GongguReviewInquiryManageService {
	private final GongguReviewInquiryManageMapper gongguReviewInquiryManageMapper;
	
	@Override
	public List<GongguReviewManage> getReviewList() {
		List<GongguReviewManage> list = null;
        try {
            list = gongguReviewInquiryManageMapper.findAllReviews();
        } catch (Exception e) {
            log.error("gongguReviewList :", e);
        }
        return list;
	}

	@Override
	public List<GongguInquiryManage> getInquiryList() {
		List<GongguInquiryManage> list = null;
		try {
			list = gongguReviewInquiryManageMapper.findAllInquirys();
		} catch (Exception e) {
			log.error("gongguInquiryList :", e);
		}
		return list;
	}

	
}
