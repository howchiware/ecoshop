package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.ChallengeManageMapper;
import com.sp.app.model.Challenge;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChallengeManageServiceImpl implements ChallengeManageService {
	
	private final ChallengeManageMapper mapper;
	
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
	public void insertChallenge(Challenge dto) throws Exception {
		try {
			Long id = (dto.getChallengeId() != null) ? dto.getChallengeId() : mapper.nextChallengeId();
			dto.setChallengeId(id);
			
			mapper.insertChallenge(dto);
			
			if("DAILY".equalsIgnoreCase(dto.getChallengeType())) {
				if(dto.getWeekday() == null) dto.setWeekday(0);
				mapper.insertDailyChallenge(dto);
			} else if ("SPECIAL".equalsIgnoreCase(dto.getChallengeType())) {
				// 스페셜 챌린지 등록 로직
	            mapper.insertSpecialChallenge(dto);
			} else {
				throw new IllegalArgumentException("challengeType must be DAILY or SPECIAL");
				
			}
			
		} catch (Exception e) {
			log.info("insertChallenge :", e);
            throw e;
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
			if(map != null) {
				Object size = map.get("size");
				if(size instanceof Number) {
					int s = ((Number) size).intValue();
					if(s <= 0 || s > 100) map.put("size", 10);
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
	public void updateChallenge(Challenge dto) throws Exception {
		try {
			mapper.updateChallenge(dto);
			
			if("DAILY".equalsIgnoreCase(dto.getChallengeType())) {
				if (dto.getWeekday() == null) dto.setWeekday(0); // NOT NULL
				mapper.updateDailyChallenge(dto);
			} else if ("SPECIAL".equalsIgnoreCase(dto.getChallengeType())) {
				mapper.updateSpecialChallenge(dto);
			}
		} catch (Exception e) {
			log.info("updateChallenge :", e);
            throw e;
		}
		
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void deleteChallenge(long challengeId) throws Exception {
		try {
			mapper.deleteChallenge(challengeId);
		} catch (Exception e) {
			log.info("deleteChallenge :", e);
            throw e;
		}
		
	}
	
}
