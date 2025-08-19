package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.ProductReviewInquiryManageMapper;
import com.sp.app.admin.model.ProductInquiryManage;
import com.sp.app.admin.model.ProductReviewManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductReviewInquiryManageServiceImpl implements ProductReviewInquiryManageService {
	private final ProductReviewInquiryManageMapper productReviewInquiryManageMapper;
	
	@Override
	public List<ProductReviewManage> getReviewList() {
		List<ProductReviewManage> list = null;
        try {
            list = productReviewInquiryManageMapper.findAllReviews();
        } catch (Exception e) {
            log.error("getReviewList :", e);
        }
        return list;
	}

	@Override
	public List<ProductInquiryManage> getInquiryList() {
		List<ProductInquiryManage> list = null;
		try {
			list = productReviewInquiryManageMapper.findAllInquirys();
		} catch (Exception e) {
			log.error("getInquiryList :", e);
		}
		return list;
	}

	@Override
	public List<ProductReviewManage> searchReviews(Map<String, Object> map) {
		List<ProductReviewManage> list = null;
		
		try {
			list = productReviewInquiryManageMapper.findReviewsBySearch(map);
		} catch (Exception e) {
			log.info("searchReviews: ", e);
		}
		return list;   
	}

	@Override
	public List<ProductInquiryManage> searchInquirys(Map<String, Object> map) {
		List<ProductInquiryManage> list = null;
		try {
			list = productReviewInquiryManageMapper.findInquirysBySearch(map);
		} catch (Exception e) {
			log.info("searchInquirys: ", e);
		}
		return list; 
	}

	@Override
	public void updateAnswer(ProductInquiryManage dto) {
		try {
			productReviewInquiryManageMapper.updateAnswer(dto);
		} catch (Exception e) {
			log.info("insertAnswer: ", e);
		}
	}

	@Override
	public String answerNameFindById(long answerId) {
		String name = null;
		
		try {
			name = productReviewInquiryManageMapper.answerNameFindById(answerId);
		} catch (Exception e) {
			log.info("answerNameFindById: ", e);
		}
		
		return name;
	}

	@Override
	public void deleteAnswer(long inquiryId) {
		try {
			productReviewInquiryManageMapper.deleteAnswer(inquiryId);
		} catch (Exception e) {
			log.info("deleteAnswer: ", e);
		}
	}

	@Override
	public void deleteInquiry(long inquiryId) {
		try {
			productReviewInquiryManageMapper.deleteInquiry(inquiryId);
		} catch (Exception e) {
			log.info("deleteInquiry: ", e);
		}
	}

}
