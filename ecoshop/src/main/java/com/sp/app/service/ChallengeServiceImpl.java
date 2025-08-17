package com.sp.app.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
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
	
	/** Java DayOfWeek(1=MON..7=SUN) -> 0(SUN)..6(SAT) 변환 */
    private int calcTodayDow() {
        int dow = LocalDate.now().getDayOfWeek().getValue(); // 1~7 (MON..SUN)
        return (dow == DayOfWeek.SUNDAY.getValue()) ? 0 : dow; // SUN->0, MON..SAT 그대로(1..6)
    }
	
	
	
	@Override
	public List<Challenge> listDailyAll() {
		try {
			return mapper.listDailyAll();
		} catch (Exception e) {
			log.info("listDailyAll :", e);
            
		}
		return List.of();
	}

	@Override
	public Challenge getTodayDaily() {
		return getTodayDaily(calcTodayDow());
	}

	@Override
	public Challenge getTodayDaily(int todayDow) {
		try {
			return mapper.getTodayDaily(todayDow);
		} catch (Exception e) {
			log.info("getTodayDaily :", e);
            
		}
		return null;
	}

	@Override
	public List<Challenge> listSpecialMore(Long lastId, Integer size, String sort) {
		
		return listSpecialMore(lastId, size, sort, null);
	}

	@Override
	public Challenge findDailyDetail(long challengeId) {
		try {
			return mapper.findDailyDetail(challengeId);
		} catch (Exception e) {
			log.info("findDailyDetail :", e);
           
		}
		 return null;
	}

	@Override
	public Challenge findSpecialDetail(long challengeId) {
		try {
			return mapper.findSpecialDetail(challengeId);
		} catch (Exception e) {
			log.info("findSpecialDetail :", e);
            
		}
		return null;
	}

	@Override
	public int countTodayDailyJoin(long memberId, long challengeId) {
		try {
			return mapper.countTodayDailyJoin(memberId, challengeId);
		} catch (Exception e) {
			log.info("countTodayDailyJoin :", e);
            
		}
		return 0;
	}

	@Override
	public Long nextParticipationId() {
		try {
			 return mapper.nextParticipationId();
		} catch (Exception e) {
			log.info("nextParticipationId :", e);
            
		}
		return null;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void insertParticipation(Challenge dto) throws Exception {
		try {
			if(dto.getParticipationStatus() == null) dto.setParticipationStatus(0);
			mapper.insertParticipation(dto);
		} catch (Exception e) {
			log.info("insertParticipation :", e);
            throw e;
		}
		
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void updateParticipation(Challenge dto) throws Exception {
		try {
			mapper.updateParticipation(dto);
		} catch (Exception e) {
			log.info("updateParticipation :", e);
            throw e;
		}
		
	}

	@Override
	public List<Map<String, Object>> selectSpecialProgress(long participationId) {
		try {
			return mapper.selectSpecialProgress(participationId);
		} catch (Exception e) {
			 log.info("selectSpecialProgress :", e);
	            
		}
		return List.of();
	}



	@Override
	public Challenge getDailyByWeekday(int weekday) {
		try {
			return mapper.selectDailyByWeekday(weekday);
		} catch (Exception e) {
			log.info("getDailyByWeekday : ", e);
		}
		return null;
	}



	@Override
	public List<Challenge> listSpecialMore(Long lastId, Integer size, String sort, String lastEndDate) {
		try {
			int pageSize = (size == null || size <= 0 || size > 50) ? 6 : size;
	        String s = (sort == null || sort.isBlank()) ? "RECENT" : sort;
	        
	        Map<String,Object> param = new java.util.HashMap<>();
	        param.put("lastId", lastId);
	        param.put("size", pageSize);
	        param.put("sort", s);
	        param.put("lastEndDate", lastEndDate);

	        return mapper.listSpecialMore(param);
		} catch (Exception e) {
			log.info("listSpecialMore :", e);
		}
		return List.of();
	}
	
	
	
}
