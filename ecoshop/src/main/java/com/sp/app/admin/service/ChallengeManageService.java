package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Challenge;

public interface ChallengeManageService {
	
	public Long nextChallengeId();

    // 등록
    public void insertChallenge(Challenge dto) throws Exception;

    // 단건
    public Challenge findById(long challengeId);
    public Challenge findDailyById(long challengeId);
    public Challenge findSpecialById(long challengeId);

    // 목록/검색
    public int dataCount(Map<String, Object> map);
    public List<Challenge> listChallenge(Map<String, Object> map);

    // 수정
    public void updateChallenge(Challenge dto) throws Exception;

    // 삭제 (CASCADE)
    public void deleteChallenge(long challengeId) throws Exception;
}
