package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.mapper.ChallengeMapper;
import com.sp.app.model.Challenge;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChallengeServiceImpl implements ChallengeService {
	
	private final ChallengeMapper mapper;

	@Transactional
	@Override
	public void insertChallenge(Challenge dto) throws Exception {
		try {
			// 시퀀스로 새로운 챌린지 아이디 생성 
			Long challengeId = mapper.challengeSeq();
			dto.setChallengeId(challengeId);
			
			// 메인 챌린지 정보 저장 
			mapper.insertChallenge(dto);
			
			 // 챌린지 타입에 따라 추가정보 저장(1:DAILY, 2: SPECIAL)
			if("DAILY".equals(dto.getChallengeType())) {
				mapper.insertDailyChallenge(dto);
			} else if ("SPECIAL".equals(dto.getChallengeType())) {
				mapper.insertSpecialChallenge(dto);
			}
			
		} catch (Exception e) {
			log.info("insertChallenge : ", e);
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return result;
	}

	@Override
	public List<Challenge> listChallenge(Map<String, Object> map) {
		List<Challenge> list = null;
		try {
			list = mapper.listChallenge(map);
		} catch (Exception e) {
			log.info("listChallenge : ", e);
		}
		return list;
	}

	@Override
	public Challenge findById(long challengeId) {
		Challenge dto = null;
		try {
			// 챌린지 정보 조회 
			dto = mapper.findById(challengeId);
			
			if (dto != null) {
				// 챌린지 타입에 따라 상세정보 조회
				if(dto.getChallengeType().equals("DAILY")) {
					Challenge dailyDto  = mapper.findDailyById(challengeId);
					if(dailyDto != null) {
						dto.setWeekday(dailyDto.getWeekday());
					}
				} else if(dto.getChallengeType().equals("SPECIAL")) {
					Challenge specialDto = mapper.findSpecialById(challengeId);
					if(specialDto != null) {
						dto.setStartDate(specialDto.getStartDate());
						dto.setEndDate(specialDto.getEndDate());
						dto.setRequireDays(specialDto.getRequireDays());
						dto.setSpecialStatus(specialDto.getSpecialStatus());
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Challenge findDailyById(long challengeId) {
		Challenge dto = null;
		try {
			dto = mapper.findDailyById(challengeId);
			if(dto != null) {
				Challenge dailyDto = mapper.findDailyById(challengeId);
				if(dailyDto != null) {
					dto.setWeekday(dailyDto.getWeekday());
				}
			}
		} catch (Exception e) {
			log.info("findDailyById : ", e);
		}
		return dto;
	}

	@Override
	public Challenge findSpecialById(long challengeId) {
		Challenge dto = null;
		try {
			dto = mapper.findSpecialById(challengeId);
			if(dto != null) {
				Challenge specialDto = mapper.findSpecialById(challengeId);
				if(specialDto != null) {
					dto.setStartDate(specialDto.getStartDate());
					dto.setEndDate(specialDto.getEndDate());
					dto.setRequireDays(specialDto.getRequireDays());
					dto.setSpecialStatus(specialDto.getSpecialStatus());
					
				}
			}
		} catch (Exception e) {
			log.info("findSpecialById : ", e);
			
		}
		return dto;
	}

	@Override
	public void updateChallenge(Challenge dto) throws Exception {
		try {
			if(dto.getChallengeType() != null) {
				dto.setChallengeType(dto.getChallengeType().toUpperCase());
			}
			
			mapper.updateChallenge(dto);
			// 데일리/스페셜 업데이트가 필요하면
            // - mapper에 updateDailyChallenge / updateSpecialChallenge 추가해서 타입 분기 처리
		} catch (Exception e) {
			log.info("updateChallenge : ", e);
            throw e;
		}
		
	}

	@Override
	public void deleteChallenge(long challengeId) throws Exception {
		try {
			mapper.deleteChallenge(challengeId);
		} catch (Exception e) {
			log.info("deleteChallenge : ", e);
            throw e;
		}
		
	}
	
}
