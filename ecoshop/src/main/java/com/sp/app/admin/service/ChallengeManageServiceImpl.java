package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.ChallengeManageMapper;
import com.sp.app.common.StorageService;
import com.sp.app.mapper.PointMapper;
import com.sp.app.model.Challenge;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChallengeManageServiceImpl implements ChallengeManageService {

	private final ChallengeManageMapper mapper;
	private final StorageService storageService;
	
	private final PointMapper pointMapper;

	@Override
	public Long nextChallengeId() {
		try {
			return mapper.nextChallengeId();
		} catch (Exception e) {
			log.info("nextChallengeId :", e);
		}
		return null;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void insertChallenge(Challenge dto, String uploadPath) throws Exception {

		if (dto.getThumbnailFile() != null && !dto.getThumbnailFile().isEmpty()) {
			String saveFilename = storageService.uploadFileToServer(dto.getThumbnailFile(), uploadPath);
			if (saveFilename != null) {
				dto.setThumbnail(saveFilename);
			}
		}

		dto.setChallengeId(mapper.nextChallengeId());

		
		mapper.insertChallenge(dto);

		
		if ("DAILY".equals(dto.getChallengeType())) {
			mapper.insertDailyChallenge(dto);
		} else if ("SPECIAL".equals(dto.getChallengeType())) {
			mapper.insertSpecialChallenge(dto);
		}
	}

	@Override
	public Challenge findById(long challengeId) {
		try {
			return mapper.findById(challengeId);
		} catch (Exception e) {
			log.info("findById  : ", e);

		}
		return null;
	}

	@Override
	public Challenge findDailyById(long challengeId) {
		try {
			return mapper.findDailyById(challengeId);
		} catch (Exception e) {
			log.info("findDailyById :", e);

		}
		return null;
	}

	@Override
	public Challenge findSpecialById(long challengeId) {
		try {
			return mapper.findSpecialById(challengeId);
		} catch (Exception e) {
			log.info("findSpecialById :", e);

		}
		return null;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		try {
			return mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount :", e);

		}
		return 0;
	}

	@Override
	public List<Challenge> listChallenge(Map<String, Object> map) {
		try {
			
			if (map != null) {
				Object size = map.get("size");
				if (size instanceof Number) {
					int s = ((Number) size).intValue();
					if (s <= 0 || s > 100)
						map.put("size", 10);
				}
			}
			return mapper.listChallenge(map);
		} catch (Exception e) {
			log.info("listChallenge :", e);

		}
		return List.of();
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void updateChallenge(Challenge dto, String uploadPath) throws Exception {
		try {
	        Challenge before = mapper.findById(dto.getChallengeId());
	        String oldThumbnail = (before != null ? before.getThumbnail() : null);

	        boolean remove = Boolean.TRUE.equals(dto.getRemoveThumbnail());

	        if (remove) {
	         
	            if (oldThumbnail != null && !oldThumbnail.isBlank()) {
	                storageService.deleteFile(uploadPath, oldThumbnail);
	            }
	            dto.setThumbnail(null); 
	        } else if (dto.getThumbnailFile() != null && !dto.getThumbnailFile().isEmpty()) {
	           
	            String saveFilename = storageService.uploadFileToServer(dto.getThumbnailFile(), uploadPath);
	            if (saveFilename != null) {
	                dto.setThumbnail(saveFilename);
	                if (oldThumbnail != null && !oldThumbnail.isBlank()) {
	                    storageService.deleteFile(uploadPath, oldThumbnail);
	                }
	            } else {
	               
	                dto.setThumbnail(oldThumbnail);
	            }
	        } else {
	           
	            dto.setThumbnail(oldThumbnail);
	        }

	       
	        mapper.updateChallenge(dto);

	      
	        if ("DAILY".equals(dto.getChallengeType())) {
	            mapper.updateDailyChallenge(dto);
	            if ("SPECIAL".equals(before.getChallengeType())) {
	                mapper.deleteSpecial(dto.getChallengeId());
	            }
	        } else if ("SPECIAL".equals(dto.getChallengeType())) {
	            mapper.updateSpecialChallenge(dto);
	            if ("DAILY".equals(before.getChallengeType())) {
	                mapper.deleteDaily(dto.getChallengeId());
	            }
	        }
	    } catch (Exception e) {
	        log.error("updateChallenge :", e);
	        throw e;
	    }
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void deleteChallenge(long challengeId, String uploadPath) throws Exception {
	    try {
	    
	        Challenge dto = mapper.findById(challengeId);
	        if (dto == null) {
	            return;
	        }

	      
	        if (dto.getThumbnail() != null && !dto.getThumbnail().isBlank()) {
	            storageService.deleteFile(uploadPath, dto.getThumbnail());
	        }

	     
	        
	        if ("DAILY".equals(dto.getChallengeType())) {
	            mapper.deleteDaily(challengeId);
	        } else if ("SPECIAL".equals(dto.getChallengeType())) {
	            mapper.deleteSpecial(challengeId);
	        }
	        
	       
	        mapper.deleteChallenge(challengeId);

	    } catch (Exception e) {
	        log.error("deleteChallenge :", e);
	        throw e;
	    }
	}

	// 관리자 인증 관리 
	 @Override
	 public List<Challenge> listAdminCerts(Map<String, Object> param) {
	        try {
	           
	            if (param != null) {
	                if (!param.containsKey("type")) param.put("type", "ALL");
	                if (!param.containsKey("offset")) param.put("offset", 0);
	                if (!param.containsKey("limit")) param.put("limit", 20);
	            }
	            return mapper.listAdminCerts(param);
	        } catch (Exception e) {
	            log.error("listAdminCerts error", e);
	            return List.of();
	        }
	    }	    

	 @Override
	 public int countAdminCerts(Map<String, Object> param) {
	        try {
	            if (param != null && !param.containsKey("type")) param.put("type", "ALL");
	            return mapper.countAdminCerts(param);
	        } catch (Exception e) {
	            log.error("countAdminCerts error", e);
	            return 0;
	        }
	    }    

	@Override
	public Challenge findCertDetail(long postId) {
        try {
            return mapper.findCertDetail(postId);
        } catch (Exception e) {
            log.error("findCertDetail error", e);
            return null;
        }
    }
	
	@Override
	public List<String> listCertPhotos(long postId) {
        try {
            return mapper.listCertPhotos(postId);
        } catch (Exception e) {
            log.error("listCertPhotos error", e);
            return List.of();
        }
    }

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void approveCert(long postId) throws Exception {
		 try {
		        Challenge ctx = mapper.selectRewardInfoByPostId(postId);
		        if (ctx == null) throw new IllegalStateException("대상이 없습니다.");
		        if (!"SPECIAL".equalsIgnoreCase(ctx.getChallengeType())) {
		            throw new IllegalStateException("DAILY는 승인/반려 대상이 아닙니다.");
		        }

		        long participationId = ctx.getParticipationId();
		        long memberId        = ctx.getMemberId();
		        long challengeId     = ctx.getChallengeId();
		        int  rewardPoints    = (ctx.getRewardPoints() == null ? 0 : ctx.getRewardPoints());
		        Integer requireDays  = mapper.selectRequireDaysByChallengeId(challengeId);
		        if (requireDays == null || requireDays <= 0) requireDays = 3;

		        if (ctx.getDayNumber() != null && ctx.getDayNumber().intValue() == requireDays) {
		            var days = mapper.selectSpecialDayDates(participationId);
		            java.time.LocalDate d1 = null, d2 = null, d3 = null;
		            for (java.util.Map<String,Object> row : days) {
		                if (row.get("DAYNUMBER") == null || row.get("DAYDATE") == null) continue;
		                int dayN = Integer.parseInt(String.valueOf(row.get("DAYNUMBER")));
		                java.time.LocalDate dd = java.time.LocalDate.parse(String.valueOf(row.get("DAYDATE")));
		                if (dayN == 1) d1 = dd;
		                if (dayN == 2) d2 = dd;
		                if (dayN == 3) d3 = dd;
		            }
		            boolean consecutive = (d1 != null && d2 != null && d3 != null
		                    && d2.equals(d1.plusDays(1)) && d3.equals(d2.plusDays(1)));
		            if (!consecutive) {
		               
		                throw new IllegalStateException("연속 3일이 아니므로 승인할 수 없습니다.");
		            }
		        }

		       
		        int updated = mapper.updateCertApproval(postId, 1);
		        if (updated != 1) {
		            throw new IllegalStateException("승인 처리 대상이 존재하지 않거나 중복 요청입니다.");
		        }

		      
		        if (ctx.getDayNumber() == null || !ctx.getDayNumber().equals(requireDays)) return;

		       
		        if (mapper.existsPointByPostId(postId)) return;

		      
		        com.sp.app.model.Point p = new com.sp.app.model.Point();
		        p.setMemberId(memberId);
		        p.setReason("SPECIAL_COMPLETE");
		        p.setClassify(1);
		        p.setPoints(rewardPoints);
		        p.setPostId(postId);
		        pointMapper.insertPoint(p);

		        // 완료 처리
		        mapper.updateParticipationStatus(participationId, 2);

		    } catch (Exception e) {
		        log.error("approveCert error", e);
		        throw e;
		    }
		}

	@Override
	@Transactional(rollbackFor = Exception.class)
    public void rejectCert(long postId) throws Exception {
		 try {
		       
		        Challenge ctx = mapper.selectRewardInfoByPostId(postId);
		        if (ctx == null) {
		            throw new IllegalStateException("대상이 없습니다.");
		        }

		        if (!"SPECIAL".equalsIgnoreCase(ctx.getChallengeType())) {
		            throw new IllegalStateException("DAILY는 승인/반려 대상이 아닙니다.");
		        }

		    
		        int updated = mapper.updateCertApproval(postId, 2);
		        if (updated != 1) {
		            throw new IllegalStateException("반려 처리 대상이 존재하지 않거나 중복 요청입니다.");
		        }

		       

		    } catch (Exception e) {
		        log.error("rejectCert error", e);
		        throw e;
		    }
		}
}
