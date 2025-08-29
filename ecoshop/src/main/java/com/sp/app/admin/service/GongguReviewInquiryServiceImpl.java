package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Override
	public List<GongguReviewManage> searchReviews(Map<String, Object> map) {
		List<GongguReviewManage> list = null;
		
		try {
			list = gongguReviewInquiryManageMapper.findReviewsBySearch(map);
		} catch (Exception e) {
			log.info("gongguReviewKwd: ", e);
		}
		return list;   
	}
	
	@Override
	public List<GongguInquiryManage> searchInquirys(Map<String, Object> map) {
		List<GongguInquiryManage> list = null;
		try {
			list = gongguReviewInquiryManageMapper.findInquirysBySearch(map);
		} catch (Exception e) {
			log.info("gongguReviewKwd: ", e);
		}
		return list;  
	}

	@Transactional
	@Override
	public void updateAnswer(GongguReviewManage dto) {
		try {
			gongguReviewInquiryManageMapper.updateAnswer(dto);
		} catch (Exception e) {
			log.info("gongguInsertAnswer: ", e);
		}
	}

	@Override
	public String answerNameFindById(long answerId) {
		String name = null;
		
		try {
			name = gongguReviewInquiryManageMapper.answerNameFindById(answerId);
		} catch (Exception e) {
			log.info("gongguAnswerNameFindById: ", e);
		}
		
		return name;
	}

	@Transactional
	@Override
	public void deleteAnswer(long gongguOrderDetailId) {
		try {
			gongguReviewInquiryManageMapper.deleteAnswer(gongguOrderDetailId);
		} catch (Exception e) {
			log.info("gongguDeleteAnswer: ", e);
		}
	}

	@Transactional
	@Override
	public void deleteReview(long gongguOrderDetailId) {
		try {
			gongguReviewInquiryManageMapper.deleteReview(gongguOrderDetailId);
		} catch (Exception e) {
			log.info("gongguDeleteInquiry: ", e);
		}
	}
	
	
}
