package com.sp.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.mapper.ProductReviewMapper;
import com.sp.app.model.ProductReview;
import com.sp.app.model.ReviewHelpful;
import com.sp.app.model.Summary;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductReviewServiceImpl implements ProductReviewService {
	private final ProductReviewMapper mapper;
	private final StorageService storageService;
	private final MyUtil myUtil;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int dataCount = 0;
		
		try {
			dataCount = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return dataCount;
	}
	
	@Override
	public List<ProductReview> listReview(Map<String, Object> map) {
		List<ProductReview> list = null;
		
		try {
			list = mapper.listReview(map);
			
			for (ProductReview dto : list) {
				if(dto.getReviewImg() != null) {
					dto.setListReviewImg(dto.getReviewImg().split(","));
				}
				dto.setName(myUtil.nameMasking(dto.getName()));
				
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				
				if(dto.getAnswer() != null) {
					dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
				}
			}
		} catch (Exception e) {
			log.info("listReview : ", e);
		}
		
		return list;
	}
	
	@Override
	public List<ProductReview> listReviewOnlyPhoto(Map<String, Object> map) {
		List<ProductReview> list = null;
		
		try {
			list = mapper.listReviewOnlyPhoto(map);
			
			for (ProductReview dto : list) {
				if(dto.getReviewImg() != null) {
					dto.setListReviewImg(dto.getReviewImg().split(","));
				}
				dto.setName(myUtil.nameMasking(dto.getName()));
				
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				
				if(dto.getAnswer() != null) {
					dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
				}
			}
		} catch (Exception e) {
			log.info("listReviewOnlyPhoto : ", e);
		}
		
		return list;
	}

	@Override
	public Summary findByReviewSummary(Map<String, Object> map) {
		Summary dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByReviewSummary(map));
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByReviewSummary : ", e);
		}
		
		return dto;
	}

	@Override
	public void insertReview(ProductReview dto, String uploadPath) throws Exception {
		try {
			mapper.insertReview(dto);
			
			if( ! dto.getSelectFile().isEmpty() ) {
				insertReviewPhoto(dto, uploadPath);
			}
			
		} catch (Exception e) {
			log.info("insertReview : ", e);
			
			throw e;
		}
	}
	
	protected void insertReviewPhoto(ProductReview dto, String uploadPath) throws Exception {
		for (MultipartFile mf : dto.getSelectFile()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				
				dto.setReviewImg(saveFilename);

				mapper.insertReviewPhoto(dto);
			} catch (NullPointerException e) {
			} catch (StorageException e) {
			} catch (Exception e) {
				throw e;
			}
		}
	}

	@Override
	public ProductReview viewReviewDetail(long reviewId) {
		ProductReview dto = null;
		try {
			dto = mapper.viewReviewDetail(reviewId);
			if(dto.getReviewImg() != null) {
				dto.setListReviewImg(dto.getReviewImg().split(","));
			}
		} catch (Exception e) {
			log.info("viewReviewDetail : ", e);
			
			throw e;
		}
		return dto;
	}

	@Override
	public void deleteReviewHelpful(ReviewHelpful dto) {
		try {
			mapper.deleteReviewHelpful(dto);
		} catch (Exception e) {
			log.info("viewReviewDetail : ", e);
			
			throw e;
		}
	}

	@Override
	public void insertReviewHelpful(ReviewHelpful dto) {
		try {
			mapper.insertReviewHelpful(dto);
		} catch (Exception e) {
			log.info("insertReviewHelpful : ", e);
			
			throw e;
		}
	}

	@Override
	public int countReviewHelpful(long reviewId) {
		int result = 0;
		try {
			result = mapper.countReviewHelpful(reviewId);
		} catch (Exception e) {
			log.info("countReviewHelpful : ", e);
			
			throw e;
		}
		return result;
	}

	@Override
	public Integer userReviewHelpful(Map<String, Object> map) {
		int result = -1;
		try {
			if(mapper.userReviewHelpful(map) != null) {
				result = mapper.userReviewHelpful(map);				
			}
		} catch (Exception e) {
			log.info("userReviewHelpful : ", e);
			
			throw e;
		}
		return result;
	}

	@Override
	public int myDataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.myDataCount(map);
		} catch (Exception e) {
			log.info("myDataCount : ", e);
		}
		return result;
	}

	@Override
	public List<ProductReview> listMyReview(Map<String, Object> map) {
		List<ProductReview> list = null;
		
		try {
			list = mapper.listMyReview(map);
			
			for (ProductReview dto : list) {
				if(dto.getReviewImg() != null) {
					dto.setListReviewImg(dto.getReviewImg().split(",")); 
				}
				
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				
				if(dto.getAnswer() != null) {
					dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
				}
			}	
		} catch (Exception e) {
			log.info("listMyReview : ", e);
		}
		
		return list;
	}

	@Override
	public void deleteReview(long reviewId, String uploadPath) throws Exception {
		try {
			List<ProductReview> listPhoto = mapper.listReviewFile(reviewId);
			if (listPhoto != null) {
				for (ProductReview dto : listPhoto) {
					storageService.deleteFile(uploadPath, dto.getReviewImg());
				}
			}
			
			mapper.deleteReview(reviewId);
			
		} catch (Exception e) {
			log.info("deleteReview : ", e);
			
			throw e;
		}
	}

	@Override
	public List<ProductReview> imgList(long productCode) {
		List<ProductReview> imgList = null;
		try {
			imgList = mapper.imgList(productCode);
		} catch (Exception e) {
			log.info("imgList : ", e);
		}
		return imgList;
	}

	@Override
	public ProductReview findReviewById(long reviewId) {
		ProductReview dto = null;
		try {
			dto = mapper.findReviewById(reviewId);
			
			if(dto.getReviewImg() != null) {
				dto.setListReviewImg(dto.getReviewImg().split(","));
			}
			dto.setName(myUtil.nameMasking(dto.getName()));
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			if(dto.getAnswer() != null) {
				dto.setAnswer(dto.getAnswer().replaceAll("\n", "<br>"));
			}
		} catch (Exception e) {
			log.info("imgList : ", e);
		}
		return dto;
	}	

}
