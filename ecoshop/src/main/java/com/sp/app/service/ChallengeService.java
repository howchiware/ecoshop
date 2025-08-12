package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Challenge;

public interface ChallengeService {
	public void insertChallenge(Challenge dto) throws Exception;

    public int dataCount(Map<String, Object> map);
    public List<Challenge> listChallenge(Map<String, Object> map);

    // 상세 
    public Challenge findById(long challengeId);
    public Challenge findDailyById(long challengeId);
    public Challenge findSpecialById(long challengeId);

    public void updateChallenge(Challenge dto) throws Exception;
    public void deleteChallenge(long challengeId) throws Exception;
}
