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
	public void updateAnswer(GongguInquiryManage dto) {
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
	public void deleteAnswer(long gongguInquiryId) {
		try {
			gongguReviewInquiryManageMapper.deleteAnswer(gongguInquiryId);
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
	
	@Override
	public int dataCountReview(Map<String, Object> map) {
		int dataCountReview = 0;
		
		try {
			dataCountReview = gongguReviewInquiryManageMapper.dataCountReview(map);
		} catch (Exception e) {
			log.info("dataCountReview : ", e);
		}
		
		return dataCountReview;
	}

	@Override
	public int dataCountInquiry(Map<String, Object> map) {
		int dataCountInquiry = 0;
		
		try {
			dataCountInquiry = gongguReviewInquiryManageMapper.dataCountInquiry(map);
		} catch (Exception e) {
			log.info("dataCountInquiry : ", e);
		}
		
		return dataCountInquiry;
	}

	@Override
	public void deleteInquiry(long gongguInquiryId) {
		try {
			gongguReviewInquiryManageMapper.deleteInquiry(gongguInquiryId);
		} catch (Exception e) {
			log.info("deleteInquiry: ", e);
		}
	}

	@Override
	public void updateReviewAnswer(GongguReviewManage dto) {
		try {
			gongguReviewInquiryManageMapper.updateReviewAnswer(dto);
		} catch (Exception e) {
			log.info("updateReviewAnswer: ", e);
		}
	}

	@Override
	public String reviewAnswerNameFindById(long answerId) {
		String name = null;
		
		try {
			name = gongguReviewInquiryManageMapper.reviewAnswerNameFindById(answerId);
		} catch (Exception e) {
			log.info("reviewAnswerNameFindById: ", e);
		}
		
		return name;
	}

	@Override
	public void deleteReviewAnswer(long gongguOrderDetailId) {
		try {
			gongguReviewInquiryManageMapper.deleteReviewAnswer(gongguOrderDetailId);
		} catch (Exception e) {
			log.info("gongguDeleteAnswer: ", e);
		}
	}

	
	
}
