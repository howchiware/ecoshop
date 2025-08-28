package com.sp.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.mapper.GongguReviewMapper;
import com.sp.app.model.GongguReview;
import com.sp.app.model.GongguReviewHelpful;
import com.sp.app.model.GongguSummary;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GongguProductReviewServiceImpl implements GongguProductReviewService {
	private final GongguReviewMapper mapper;
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
	public List<GongguReview> listGongguReview(Map<String, Object> map) {
		List<GongguReview> list = null;
		
		try {
			list = mapper.listReview(map);
			
			for (GongguReview dto : list) {
				if(dto.getReviewImg() != null) {
					dto.setListReviewImg(dto.getReviewImg().split(","));
				}
				dto.setUsername(myUtil.nameMasking(dto.getUsername()));
				
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
	public void insertGongguReview(GongguReview dto, String uploadPath) throws Exception {
		try {
			mapper.insertReview(dto);
			
			if( ! dto.getSelectFile().isEmpty() ) {
				insertGongguReviewPhoto(dto, uploadPath);
			}
			
		} catch (Exception e) {
			log.info("insertReview : ", e);
			
			throw e;
		}
	}

	protected void insertGongguReviewPhoto(GongguReview dto, String uploadPath) throws Exception {
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
	public void deleteGongguReview(long gongguReviewId, String uploadPath) throws Exception {
		try {
			List<GongguReview> gongguListPhoto = mapper.listReviewFile(gongguReviewId);
			if (gongguListPhoto != null) {
				for (GongguReview dto : gongguListPhoto) {
					storageService.deleteFile(uploadPath, dto.getReviewImg());
				}
			}
			
			mapper.deleteReview(gongguReviewId);
			
		} catch (Exception e) {
			log.info("deleteReview : ", e);
			
			throw e;
		}
	}	

	@Override
	public GongguReview viewGongguReviewDetail(long gongguReviewId) {
		GongguReview dto = null;
		try {
			dto = mapper.viewReviewDetail(gongguReviewId);
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
	public void deleteGongguReviewHelpful(GongguReviewHelpful dto) {
		try {
			mapper.deleteReviewHelpful(dto);
		} catch (Exception e) {
			log.info("viewReviewDetail : ", e);
			
			throw e;
		}
	}
	@Override
	public void insertGongguReviewHelpful(GongguReviewHelpful dto) {
		try {
			mapper.insertReviewHelpful(dto);
		} catch (Exception e) {
			log.info("insertReviewHelpful : ", e);
			
			throw e;
		}
	}

	@Override
	public int countGongguReviewHelpful(long gongguReviewId) {
		int result = 0;
		try {
			result = mapper.countReviewHelpful(gongguReviewId);
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
	public int myGongguDataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.myDataCount(map);
		} catch (Exception e) {
			log.info("myDataCount : ", e);
		}
		return result;
	}

	@Override
	public List<GongguReview> listMyReview(Map<String, Object> map) {
		List<GongguReview> list = null;
		
		try {
			list = mapper.listMyReview(map);
			
			for (GongguReview dto : list) {
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
	public GongguSummary findByGongguReviewSummary(Map<String, Object> map) {
		GongguSummary dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByReviewSummary(map));
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByReviewSummary : ", e);
		}
		
		return dto;
	}
	
	@Override
	public List<GongguReview> imgList(long gongguProductId) {
		List<GongguReview> imgList = null;
		try {
			imgList = mapper.imgList(gongguProductId);
		} catch (Exception e) {
			log.info("imgList : ", e);
		}
		return imgList;
	}	

}
