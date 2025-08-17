package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Challenge;

public interface ChallengeService {

    // DAILY
    public List<Challenge> listDailyAll();
    public Challenge getTodayDaily();                   // 오늘 요일 자동 계산
    public Challenge getTodayDaily(int todayDow);       // 0(일)~6(토) 직접 지정
    
    public Challenge getDailyByWeekday(int weekday);

    // SPECIAL (더보기)
    public List<Challenge> listSpecialMore(Long lastId, Integer size, String sort);

    // 상세
    public Challenge findDailyDetail(long challengeId);
    public Challenge findSpecialDetail(long challengeId);

    // 참여
    public int countTodayDailyJoin(long memberId, long challengeId);
    public Long nextParticipationId();
    public void insertParticipation(Challenge dto) throws Exception;
    public void updateParticipation(Challenge dto) throws Exception;

    // 스페셜 진행률 1~3일 (dayNumber, done)
    public List<Map<String, Object>> selectSpecialProgress(long participationId);
}
