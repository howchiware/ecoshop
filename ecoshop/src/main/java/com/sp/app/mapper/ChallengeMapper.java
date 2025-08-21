package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sp.app.model.Challenge;

@Mapper
public interface ChallengeMapper {
	// 데일리 챌린지 7개 전체 
	public List<Challenge> listDailyAll() throws SQLException;
	
	// 데일리 오늘 요일 챌린지 1개, (todayDow: 0=일 ~ 6=토)
	public Challenge getTodayDaily(@Param("todayDow") int todayDow) throws SQLException;
    
	// SPECIAL (더보기 전용: 키셋 페이지네이션) 

    /**
     * 스페셜 카드 목록 - 더보기
     * @param lastId 직전 페이지 마지막 challengeId (첫 로드 null)
     * @param size   가져올 개수 (예: 6/9)
     * @param sort   'POPULAR' | 'CLOSE_DATE' | 'RECENT'
     */
    public List<Challenge> listSpecialMore(
            Map<String, Object> param );


    // 상세 
    public Challenge findDailyDetail(@Param("challengeId") long challengeId) throws SQLException;
    public Challenge findSpecialDetail(@Param("challengeId") long challengeId) throws SQLException;


    // 참여(요일: 당일 1회 제한) 
    public int countTodayDailyJoin(
            @Param("memberId") long memberId,
            @Param("challengeId") long challengeId
    ) throws SQLException;

    // 참여 시퀀스 
    public Long nextParticipationId() throws SQLException;
    public Long nextPostId() throws SQLException; // 인증글 시퀀스
    public Long nextPhotoId() throws SQLException; // 인증사진 시퀀스

    // 참여 등록 (parameterType = com.sp.app.model.Challenge) 
    public int insertParticipation(Challenge dto) throws SQLException;
    public int insertCertificationPost(Challenge dto) throws SQLException;
    public int insertCertificationPhoto(Challenge dto) throws SQLException;

    //참여 상태/취소일 갱신 (넘겨준 필드만 갱신) 
    public int updateParticipation(Challenge dto) throws SQLException;

    //스페셜 진행률(1~3일) - 진행 현황 조회

    /**
     * dayNumber(1~3), done(0/1) 형태로 반환
     * resultType=map 이므로 List<Map<String, Object>>로 받기
     */
    public List<Map<String, Object>> selectSpecialProgress(
            @Param("participationId") long participationId
    ) throws SQLException;
	
	public Challenge selectDailyByWeekday(@Param("weekday") int weekday);
	
	
	
	
    
}
