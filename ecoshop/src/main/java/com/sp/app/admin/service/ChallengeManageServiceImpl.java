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

		// 1) 챌린지 메인 insert
		mapper.insertChallenge(dto);

		// 2) DAILY/SPECIAL 분기 insert
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
	            // 1) 삭제 체크된 경우: 파일 삭제 + DB 값 비우기
	            if (oldThumbnail != null && !oldThumbnail.isBlank()) {
	                storageService.deleteFile(uploadPath, oldThumbnail);
	            }
	            dto.setThumbnail(null); // DB를 NULL로(아래 매퍼에서 NULL 반영되도록 처리)
	        } else if (dto.getThumbnailFile() != null && !dto.getThumbnailFile().isEmpty()) {
	            // 2) 새 파일 업로드
	            String saveFilename = storageService.uploadFileToServer(dto.getThumbnailFile(), uploadPath);
	            if (saveFilename != null) {
	                dto.setThumbnail(saveFilename);
	                if (oldThumbnail != null && !oldThumbnail.isBlank()) {
	                    storageService.deleteFile(uploadPath, oldThumbnail);
	                }
	            } else {
	                // 업로드 실패 시 기존 값 유지
	                dto.setThumbnail(oldThumbnail);
	            }
	        } else {
	            // 3) 변경 없음 -> 기존 값 유지
	            dto.setThumbnail(oldThumbnail);
	        }

	        // 메인 테이블 업데이트
	        mapper.updateChallenge(dto);

	        // DAILY/SPECIAL 보조 테이블 업데이트 + 타입 변경 시 정리
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
	        // 1. 기존 챌린지 정보 조회
	        Challenge dto = mapper.findById(challengeId);
	        if (dto == null) {
	            return;
	        }

	        // 2. 썸네일 파일 삭제
	        if (dto.getThumbnail() != null && !dto.getThumbnail().isBlank()) {
	            storageService.deleteFile(uploadPath, dto.getThumbnail());
	        }

	        // 3. 챌린지 DB 레코드 삭제
	        // 자식 테이블(dailyChallenge 또는 specialChallenge) 레코드를 먼저 삭제
	        if ("DAILY".equals(dto.getChallengeType())) {
	            mapper.deleteDaily(challengeId);
	        } else if ("SPECIAL".equals(dto.getChallengeType())) {
	            mapper.deleteSpecial(challengeId);
	        }
	        
	        // 부모 테이블(challenge) 레코드 삭제
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
	            // 기본값 가드(옵션)
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
	        // 1) 인증글 승인 처리
	        int updated = mapper.updateCertApproval(postId, 1);
	        if (updated != 1) {
	            throw new IllegalStateException("승인 처리 대상이 존재하지 않거나 중복 요청입니다.");
	        }

	        // 2) 보상 판단 정보
	        Challenge ctx = mapper.selectRewardInfoByPostId(postId);
	        if (ctx == null) return;

	        if (!"SPECIAL".equalsIgnoreCase(ctx.getChallengeType())) {
	            // DAILY라면 포인트 지급 정책이 없으면 여기서 종료
	            return;
	        }

	        long participationId = ctx.getParticipationId();
	        long memberId        = ctx.getMemberId();
	        long challengeId     = ctx.getChallengeId();
	        int  rewardPoints    = (ctx.getRewardPoints() == null ? 0 : ctx.getRewardPoints());

	        // 3) 마지막 일차인지(=requireDays인지) 
	        Integer requireDays = mapper.selectRequireDaysByChallengeId(challengeId);
	        if (requireDays == null || requireDays <= 0) requireDays = 3;

	        if (ctx.getDayNumber() == null || !ctx.getDayNumber().equals(requireDays)) {
	            // 마지막 일차가 아니면 포인트 지급/완료 처리 없음 (승인만 반영)
	            return;
	        }

	        // 4) (선호) 누적 승인 일차가 requireDays 이상인지 확인
	        // int approvedDays = mapper.countApprovedDays(participationId);
	        // if (approvedDays < requireDays) {
	            // 아직 누적이 모자라면 지급 보류 (마지막 승인인데 과거가 미승인인 상황)
	          //  return;
	        // }

	        // 5) 중복 적립 방지 (이 postId로 이미 적립했는지)
	        boolean alreadyGiven = mapper.existsPointByPostId(postId);
	        if (alreadyGiven) return;

	        // 6) 포인트 적립 
	        com.sp.app.model.Point p = new com.sp.app.model.Point();
	        p.setMemberId(memberId);
	        p.setReason("SPECIAL_COMPLETE");
	        p.setClassify(1);        // 적립
	        p.setPoints(rewardPoints);
	        p.setPostId(postId);
	        pointMapper.insertPoint(p);

	        // 7) 참여 상태 완료로 변경 (선택)
	        mapper.updateParticipationStatus(participationId, 2); // 2=완료

	    } catch (Exception e) {
	        log.error("approveCert error", e);
	        throw e;
	    }
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
    public void rejectCert(long postId) throws Exception {
        try {
            int updated = mapper.updateCertApproval(postId, 2);
            if (updated != 1) {
                throw new IllegalStateException("반려 처리 대상이 존재하지 않거나 중복 요청입니다.");
            }

            
            // Challenge ctx = mapper.selectRewardInfoByPostId(postId);
            // mapper.updateParticipationStatus(ctx.getParticipationId(), 3);

        } catch (Exception e) {
            log.error("rejectCert error", e);
            throw e;
        }
    }
}
