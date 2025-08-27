package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Challenge;

public interface ChallengeManageService {
	
	public Long nextChallengeId();

    // 등록
    public void insertChallenge(Challenge dto, String uploadPath) throws Exception;

    // 단건 조회
    public Challenge findById(long challengeId);
    public Challenge findDailyById(long challengeId);
    public Challenge findSpecialById(long challengeId);

    // 목록/검색
    public int dataCount(Map<String, Object> map);
    public List<Challenge> listChallenge(Map<String, Object> map);

    // 관리자 수정(썸네일 교체 및 삭제 포함)
    public void updateChallenge(Challenge dto, String uploadPath) throws Exception;

    // 삭제 (CASCADE) (파일 삭제 + 보조테이블 정리 + 메인 삭제 포함)
    public void deleteChallenge(long challengeId, String uploadPath) throws Exception;
    
    public List<Challenge> listAdminCerts(Map<String, Object> param);
    public int countAdminCerts(Map<String, Object> param);

    public Challenge findCertDetail(long postId);
    public List<String> listCertPhotos(long postId);

    public void approveCert(long postId) throws Exception;
    public void rejectCert(long postId) throws Exception;
}
