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
            for (ProductReviewManage dto : list) {
				if(dto.getReviewImg() != null) {
					dto.setListReviewImg(dto.getReviewImg().split(","));
				}
				
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				
				if(dto.getAnswer() != null) {
					dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
				}
			}
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
			
            for (ProductReviewManage dto : list) {
				if(dto.getReviewImg() != null) {
					System.out.println(dto.getReviewImg());
					dto.setListReviewImg(dto.getReviewImg().split(","));
				}
				
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				
				if(dto.getAnswer() != null) {
					dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
				}
			}
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
			
            for (ProductInquiryManage dto : list) {

				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				
				if(dto.getAnswer() != null) {
					dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
				}
			}
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
	
	@Override
	public void updateReviewAnswer(ProductReviewManage dto) {
		try {
			productReviewInquiryManageMapper.updateReviewAnswer(dto);
		} catch (Exception e) {
			log.info("updateReviewAnswer: ", e);
		}
	}

	@Override
	public String reviewAnswerNameFindById(long answerId) {
		String name = null;
		
		try {
			name = productReviewInquiryManageMapper.reviewAnswerNameFindById(answerId);
		} catch (Exception e) {
			log.info("reviewAnswerNameFindById: ", e);
		}
		
		return name;
	}

	@Override
	public void deleteReviewAnswer(long reviewId) {
		try {
			productReviewInquiryManageMapper.deleteReviewAnswer(reviewId);
		} catch (Exception e) {
			log.info("gongguDeleteAnswer: ", e);
		}
	}

	@Override
	public void deleteReview(long reviewId) {
		try {
			productReviewInquiryManageMapper.deleteReview(reviewId);
		} catch (Exception e) {
			log.info("gongguDeleteInquiry: ", e);
		}
	}

	@Override
	public int dataCountReview(Map<String, Object> map) {
		int dataCountReview = 0;
		
		try {
			dataCountReview = productReviewInquiryManageMapper.dataCountReview(map);
		} catch (Exception e) {
			log.info("dataCountReview : ", e);
		}
		
		return dataCountReview;
	}

	@Override
	public int dataCountInquiry(Map<String, Object> map) {
		int dataCountInquiry = 0;
		
		try {
			dataCountInquiry = productReviewInquiryManageMapper.dataCountInquiry(map);
		} catch (Exception e) {
			log.info("dataCountInquiry : ", e);
		}
		
		return dataCountInquiry;
	}
	

}
