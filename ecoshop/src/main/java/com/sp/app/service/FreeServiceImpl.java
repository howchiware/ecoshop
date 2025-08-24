package com.sp.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.mapper.FreeMapper;
import com.sp.app.model.Free;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FreeServiceImpl implements FreeService {
	
	private final FreeMapper mapper;
	private final MyUtil myUtil;
	// private final StorageService storageService;
	
	
	@Override
	public List<Free> dairyList(Map<String, Object> map) {
		List<Free> list = null;
		
		try {
			list = mapper.dairyList(map);			
		} catch (Exception e) {
			log.info("dairyList : ", e);
		}
		
		return list;
	}
	
	@Override
	public Free findByDairy(long freeId) {
		Free dto = null;
		
		try {
			dto = mapper.findByDairy(freeId);
		} catch (Exception e) {
			log.info("findByDairy: ", e);
		}
		
		return dto;
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount: ", e);
		}
		
		return result;
	}
	
	@Override
	public void updateHitCount(long freeId) throws Exception {
		try {
			mapper.updateHitCount(freeId);
		} catch (Exception e) {
			log.info("updateHitCount: ", e);
			throw e;
		}
	}
	
	@Override
	public Free findByPrev(Map<String, Object> map) {
		Free dto = null;
		
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev: ", e);
		}
		
		return dto;
	}
	
	@Override
	public Free findByNext(Map<String, Object> map) {
		Free dto = null;
		
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext: ", e);
		}
		
		return dto;
	}
	
	@Override
	public void insertDairy(Free dto) throws Exception {
		try {
			/*
			if(! dto.getSelectFile().isEmpty()) {
				String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getSelectFile().getOriginalFilename());
			}
			*/
			mapper.insertDairy(dto);
		} catch (Exception e) {
			log.info("insertDairy: ", e);
			throw e;
		}
	}
	@Override
	public void updateDairy(Free dto) throws Exception {
		try {
			/*
			if(dto.getSelectFile() != null && ! dto.getSelectFile().isEmpty()) {
				if(! dto.getSaveFilename().isBlank()) {
					deleteUploadFile(uploadPath, dto.getSaveFilename());					
				}
				
				String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getSelectFile().getOriginalFilename());
			}
			*/
			mapper.updateDairy(dto);
		} catch (Exception e) {
			log.info("updateDairy: ", e);
			throw e;
		}
	}

	@Override
	public void deleteDairy(long freeId, Long memberId, int userLevel) throws Exception {
	    try {
	        Free dto = findByDairy(freeId);

	        if (dto == null) {
	            return;
	        }

	        if (userLevel < 51 && !memberId.equals(dto.getMemberId())) {
	            return; 
	        }
	        
	        mapper.deleteDairy(freeId);

	    } catch (Exception e) {
	        log.error("deleteDairy: ", e);
	        throw e;
	    }
	}
	
	@Override
	public void insertReply(Free dto) throws Exception {
		try {
			mapper.insertReply(dto);
		} catch (Exception e) {
			log.info("insertReply : ", e);
			throw e;
		}
	}
	
	@Override
	public List<Free> listReply(Map<String, Object> map) {
		List<Free> list = null;
		
		try {
			list = mapper.listReply(map);
			for(Free dto : list) {
				dto.setContent(myUtil.htmlSymbols(dto.getContent()));
				map.put("replyId", dto.getReplyId());
			}
		} catch (Exception e) {
			log.info("listReply : ", e);
		}
		
		return list;
	}
	
	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.replyCount(map);
		} catch (Exception e) {
			log.info("replyCount : ", e);
		}
		
		return result;
	}
	
	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteReply(map);
		} catch (Exception e) {
			log.info("deleteReply : ", e);
			throw e;
		}
	}
	
	@Override
	public List<Free> listReplyAnswer(Map<String, Object> map) {
		List<Free> list = null;
		
		try {
			list = mapper.listReplyAnswer(map);
			for(Free dto : list) {
				dto.setContent(myUtil.htmlSymbols(dto.getContent()));
			}
		} catch (Exception e) {
			log.info("listReplyAnswer : ", e);
		}
		
		return list;
	}
	
	@Override
	public int replyAnswerCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.replyAnswerCount(map);
		} catch (Exception e) {
			log.info("replyAnswerCount : ", e);
		}
		
		return result;
	}
	/*
	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		return storageService.deleteFile(uploadPath, filename);
	}
	*/

	@Override
	public void updateReplyReport(Map<String, Object> map) throws Exception {
		try {
			mapper.updateReplyReport(map);
		} catch (Exception e) {
			log.info("updateReplyShowHide : ", e);
			throw e;
		}
		
	}

	@Override
	public int freeLikeCount(long freeId) {
		int result = 0;
		
		try {
			result = mapper.freeLikeCount(freeId);
		} catch (Exception e) {
			log.info("freeLikeCount", e);
		}
		
		return result;
	}

	@Override
	public boolean isUserFreeLiked(Map<String, Object> map) {
		boolean result = false;
		
		try {
			Free dto = mapper.hasUserFreeLiked(map);
			if(dto != null) {
				result = true;
			}
			result = Objects.nonNull(mapper.hasUserFreeLiked(map));
		} catch (Exception e) {
			log.info("isUserFreeLiked: ", e);
		}
		
		return result;
	}

	@Override
	public void insertFreeLike(Map<String, Object> map) throws Exception {
		try {
			mapper.insertFreeLike(map);
		} catch (Exception e) {
			log.info("insertFreeLike : ", e);
			throw e;
		}
	}

	@Override
	public void deleteFreeLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteFreeLike(map);
		} catch (Exception e) {
			log.info("deleteFreeLike : ", e);
			throw e;
		}
	}
	
	
}
