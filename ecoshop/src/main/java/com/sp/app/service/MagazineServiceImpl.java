package com.sp.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;
import com.sp.app.mapper.MagazineMapper;
import com.sp.app.model.Magazine;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MagazineServiceImpl implements MagazineService {
	private final MyUtil myUtil;
	private final MagazineMapper mapper;
	private final StorageService storageService;
	
	@Override
	public List<Magazine> magazineList(Map<String, Object> map) {
		List<Magazine> list = null;
		
		try {
			list = mapper.magazineList(map);			
		} catch (Exception e) {
			log.info("dairyList : ", e);
		}
		
		return list;
	}

	@Override
	public Magazine findByMagazine(long magazineId) {
		Magazine dto = null;
		
		try {
			dto = mapper.findByMagazine(magazineId);
		} catch (Exception e) {
			log.info("findByMagazine: ", e);
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
	public void updateHitCount(long magazineId) throws Exception {
		try {
			mapper.updateHitCount(magazineId);
		} catch (Exception e) {
			log.info("updateHitCount: ", e);
			throw e;
		}
		
	}

	@Override
	public Magazine findByPrev(Map<String, Object> map) {
		Magazine dto = null;
		
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev: ", e);
		}
		
		return dto;
	}

	@Override
	public Magazine findByNext(Map<String, Object> map) {
		Magazine dto = null;
		
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext: ", e);
		}
		
		return dto;
	}

	@Override
	public void insertMagazine(Magazine dto, String uploadPath) throws Exception {
		try {
			String saveFilename = null;
			
			 if (dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) {
		            saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
		        }
			 
			 if (saveFilename == null || saveFilename.isBlank()) {
		            dto.setOriginalFilename(saveFilename);
		        } else {
		            dto.setOriginalFilename(saveFilename);
		        }

		        mapper.insertMagazine(dto);
		    } catch (Exception e) {
		        log.info("insertReguide : ", e);
		        throw e;
		    }
	}

	@Override
	public void updateMagazine(Magazine dto, String uploadPath) throws Exception {
		try {
			if (dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) {

	            // 기존 이미지 삭제
	            if (dto.getOriginalFilename() != null && !dto.getOriginalFilename().isBlank()) {
	                deleteUploadFile(uploadPath, dto.getOriginalFilename());
	            }

	            String originalFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
	            if (originalFilename == null || originalFilename.isBlank()) {
	                dto.setOriginalFilename(null);;
	            } else {
	                dto.setOriginalFilename(originalFilename);
	            }
	        }
			mapper.updateMagazine(dto);
		} catch (Exception e) {
			log.info("updateMagazine: ", e);
			throw e;
		}
		
	}

	@Override
	public void deleteMagazine(long magazineId, Long memberId, int userLevel, String uploadPath, String filename) throws Exception {
		try {
			
			if (filename != null && !filename.isBlank()) {
	            deleteUploadFile(uploadPath, filename);
	        }
			
			mapper.deleteMagazine(magazineId);
			
			Magazine dto = findByMagazine(magazineId);

	        if (dto == null) {
	            return;
	        }

	        if (userLevel < 51 && !memberId.equals(dto.getMemberId())) {
	            return; 
	        }
	        
	        mapper.deleteMagazine(magazineId);

	    } catch (Exception e) {
	        log.error("deleteMagazine: ", e);
	        throw e;
	    }
		
	}

	@Override
	public void insertReply(Magazine dto) throws Exception {
		try {
			mapper.insertReply(dto);
		} catch (Exception e) {
			log.info("insertReply : ", e);
			throw e;
		}
	}

	@Override
	public List<Magazine> listReply(Map<String, Object> map) {
		List<Magazine> list = null;
		
		try {
			list = mapper.listReply(map);
			for(Magazine dto : list) {
				dto.setContent(myUtil.htmlSymbols(dto.getContent()));
				map.put("magazineReplyNum", dto.getMagazineReplyNum());
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
	public List<Magazine> listReplyAnswer(Map<String, Object> map) {
		List<Magazine> list = null;
		
		try {
			list = mapper.listReplyAnswer(map);
			for(Magazine dto : list) {
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
	public void insertMagazineLike(Map<String, Object> map) throws Exception {
		try {
			mapper.insertMagazineLike(map);
		} catch (Exception e) {
			log.info("insertMagazineLike : ", e);
			throw e;
		}
		
	}

	@Override
	public void deleteMagazineLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteMagazineLike(map);
		} catch (Exception e) {
			log.info("deleteMagazineLike : ", e);
			throw e;
		}
		
	}

	@Override
	public int magazineLikeCount(long magazineId) {
		int result = 0;
		
		try {
			result = mapper.magazineLikeCount(magazineId);
		} catch (Exception e) {
			log.info("magazineLikeCount", e);
		}
		
		return result;
	}

	@Override
	public boolean isUserMagazineLiked(Map<String, Object> map) {
		boolean result = false;
		
		try {
			Magazine dto = mapper.hasUserMagazineLiked(map);
			if(dto != null) {
				result = true;
			}
			result = Objects.nonNull(mapper.hasUserMagazineLiked(map));
		} catch (Exception e) {
			log.info("isUserMagazineLiked: ", e);
		}
		
		return result;
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		// TODO Auto-generated method stub
		return false;
	}

}
