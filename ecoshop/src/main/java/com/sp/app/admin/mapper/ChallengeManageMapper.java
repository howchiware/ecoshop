package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sp.app.model.Challenge;

@Mapper
public interface ChallengeManageMapper {
	
	public Long nextChallengeId() throws SQLException;

    // 등록 
	public int insertChallenge(Challenge dto) throws SQLException;        // challenge
	public int insertDailyChallenge(Challenge dto) throws SQLException;   // dailyChallenge 
	public int insertSpecialChallenge(Challenge dto) throws SQLException; // specialChallenge 

    // 조회 
	public Challenge findById(@Param("challengeId") long challengeId) throws SQLException;
	public Challenge findDailyById(@Param("challengeId") long challengeId) throws SQLException;
	public Challenge findSpecialById(@Param("challengeId") long challengeId) throws SQLException;

    // 목록/검색/페이징
    public int dataCount(Map<String, Object> map) throws SQLException;

    /**
     * 목록은 조인 결과(weekday, startDate, endDate, requireDays, specialStatus 포함)로 내려옴.
     * map 파라미터 예: { kwd, challengeType, weekday, offset, size }
     */
    public List<Challenge> listChallenge(Map<String, Object> map) throws SQLException;

    // 수정 
    public int updateChallenge(Challenge dto) throws SQLException;         
    public int updateDailyChallenge(Challenge dto) throws SQLException;     
    public int updateSpecialChallenge(Challenge dto) throws SQLException;   

    // 삭제 (챌린지 타입 변경 시 사용)
    public int deleteDaily(@Param("challengeId") long challengeId) throws SQLException;
    public int deleteSpecial(@Param("challengeId") long challengeId) throws SQLException;

    // 삭제 (챌린지 전체 삭제)
    public int deleteChallenge(@Param("challengeId") long challengeId) throws SQLException; // CASCADE
    
    // 관리자 인증 목록 (데일리 + 스페셜) 
    public List<Challenge> listAdminCerts(Map<String, Object> param) throws SQLException;
    public int countAdminCerts(Map<String, Object> param) throws SQLException;

    // 인증글 상세 (사진 포함)
    public Challenge findCertDetail(@Param("postId") long postId) throws SQLException;
    public List<String> listCertPhotos(@Param("postId") long postId) throws SQLException;

    // 승인/반려 처리 
    public int updateCertApproval(@Param("postId") long postId,
                           @Param("approvalStatus") int approvalStatus) throws SQLException;

    // 포인트/완료 처리
    public Challenge selectRewardInfoByPostId(@Param("postId") long postId) throws SQLException;
    public int countApprovedDays(@Param("participationId") long participationId) throws SQLException;
    public int updateParticipationStatus(@Param("participationId") long participationId,
                                  @Param("status") int status) throws SQLException;
    
    // point 테이블에서 중복 적립 여부 확인
    public boolean existsPointByPostId(@Param("postId") long postId) throws SQLException;
    
    
    // 스페셜 requireDays 조회 (없으면 3)
    public Integer selectRequireDaysByChallengeId(@Param("challengeId") long challengeId) throws SQLException;
    
    
    
    
}
