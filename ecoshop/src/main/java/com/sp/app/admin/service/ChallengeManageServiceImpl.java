package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.ChallengeManageMapper;
import com.sp.app.common.StorageService;
import com.sp.app.model.Challenge;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChallengeManageServiceImpl implements ChallengeManageService {

	private final ChallengeManageMapper mapper;
	private final StorageService storageService;

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
			// offset/size 가드(Optional)
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
	        // 기존 썸네일 파일명 조회
	        Challenge before = mapper.findById(dto.getChallengeId());
	        String oldThumbnail = (before != null ? before.getThumbnail() : null);

	        // 썸네일 파일 교체 처리
	        if (dto.getThumbnailFile() != null && !dto.getThumbnailFile().isEmpty()) {
	            // 새 파일 업로드
	            String saveFilename = storageService.uploadFileToServer(dto.getThumbnailFile(), uploadPath);
	            if (saveFilename != null) {
	                dto.setThumbnail(saveFilename);
	                // 기존 파일 삭제
	                if (oldThumbnail != null && !oldThumbnail.isBlank()) {
	                    storageService.deleteFile(uploadPath, oldThumbnail);
	                }
	            }
	        } else {
	            // 새 파일이 없으면 기존 파일명을 그대로 유지
	            dto.setThumbnail(oldThumbnail);
	        }

	        // 1) 챌린지 메인 테이블(challenge) 업데이트
	        mapper.updateChallenge(dto);

	        // 2) DAILY/SPECIAL 부가 정보 업데이트
	        if ("DAILY".equals(dto.getChallengeType())) {
	            mapper.updateDailyChallenge(dto);
	            // SPECIAL에서 DAILY로 타입을 변경하는 경우, 기존 SPECIAL 정보 삭제
	            if ("SPECIAL".equals(before.getChallengeType())) {
	                mapper.deleteSpecial(dto.getChallengeId());
	            }
	        } else if ("SPECIAL".equals(dto.getChallengeType())) {
	            mapper.updateSpecialChallenge(dto);
	            // DAILY에서 SPECIAL로 타입을 변경하는 경우, 기존 DAILY 정보 삭제
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

}
