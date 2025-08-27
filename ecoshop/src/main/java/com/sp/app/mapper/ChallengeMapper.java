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
    
	// SPECIAL (더보기 전용) 
    /**
     * 스페셜 카드 목록 - 더보기
     * @param lastId 직전 페이지 마지막 challengeId (첫 로드 null)
     * @param size   가져올 개수 (예: 6/9)
     * @param sort   'POPULAR' | 'CLOSE_DATE' | 'RECENT'
     */
    public List<Challenge> listSpecialMore(Map<String, Object> param );


    // 상세 
    public Challenge findDailyDetail(@Param("challengeId") long challengeId) throws SQLException;
    public Challenge findSpecialDetail(@Param("challengeId") long challengeId) throws SQLException;

    
    // 참여 시퀀스 
    public Long nextParticipationId() throws SQLException;
    public Long nextPostId() throws SQLException; // 인증글 시퀀스
    public Long nextPhotoId() throws SQLException; // 인증사진 시퀀스

    

    // 참여(요일: 당일 1회 제한) 
    public int countTodayDailyJoin(
            @Param("memberId") long memberId,
            @Param("challengeId") long challengeId
    ) throws SQLException;

    
    // 참여/인증 INSERT/UPDATE ,참여 등록  
    public int insertParticipation(Challenge dto) throws SQLException;
    public int insertCertificationPost(Challenge dto) throws SQLException;
    public int insertCertificationPhoto(Challenge dto) throws SQLException;

    //참여 상태/취소일 갱신 
    public int updateParticipation(Challenge dto) throws SQLException;

    
    
    //스페셜 진행률(1~3일) - 진행 현황 조회
    /**
     * dayNumber(1~3), done(0/1) 형태로 반환
     * resultType=map 이므로 List<Map<String, Object>>로 받기
     */
    public List<Map<String, Object>> selectSpecialProgress(
            @Param("participationId") long participationId
    ) throws SQLException;
	
    // 해당 요일 1건 조회
	public Challenge selectDailyByWeekday(@Param("weekday") int weekday);
	
	
	// 스페셜 제출용 추가 메서드
    // 현재 진행/대기 중인 참여 1건
    public Challenge selectActiveParticipation(@Param("memberId") long memberId,
                                        @Param("challengeId") long challengeId) throws SQLException;

    // 해당 참여에서 특정 일차 존재 여부(중복 방지)
    public int existsPostByParticipationAndDay(@Param("participationId") long participationId,
                                        @Param("dayNumber") int dayNumber) throws SQLException;

    // 해당 참여의 최대 dayNumber (순서 검증용)
    public Integer selectMaxDayNumber(@Param("participationId") long participationId) throws SQLException;
    
    
    // 스페셜 챌리지 최종 제출 - 승인요청용
    public Challenge findParticipationById(@Param("participationId") long participationId) throws SQLException;
    
    public int countSpecialPosts(@Param("participationId") long participationId) throws SQLException;
    
    public List<Challenge> listMyChallenges(long memberId) throws Exception;
    
    // 총 건수 
    public int countMyChallenges(@Param("memberId") long memberId) throws Exception;
    
    // 페이징 목록
    public List<Challenge> listMyChallengesPaged(@Param("memberId") long memberId,
    											@Param("offset") int offset,
    											@Param("size") int size) throws Exception;
    // 마이페이지 
    public int updatePostVisibility(@Param("postId") long postId,
    								@Param("memberId") long memberId,
    								@Param("isPublic") String isPublic) throws Exception;
    public int countPublicSpecialPosts(@Param("kwd") String kwd) throws Exception;
    public List<Challenge> listPublicSpecialPostsPaged(@Param("offset") int offset,
    												  @Param("size") int size,
    												  @Param("sort") String sort,
    												  @Param("kwd") String kwd) throws Exception;
    
    
    // 내 인증글 관리용 (스페셜 인증글만: dayNumber IS NOT NULL)
    public int countMySpecialPosts(
            @Param("memberId") long memberId,
            @Param("challengeId") Long challengeId,   // 선택 필터(없으면 null)
            @Param("kwd") String kwd                   // 내용 키워드(없으면 null)
    ) throws Exception;

    public List<Challenge> listMySpecialPostsPaged(
            @Param("memberId") long memberId,
            @Param("challengeId") Long challengeId,   // 선택 필터(없으면 null)
            @Param("offset") int offset,
            @Param("size") int size,
            @Param("kwd") String kwd                   // 내용 키워드(없으면 null)
    ) throws Exception;
    
    
    public Challenge findPublicSpecialPost(@Param("postId") long postId) throws Exception;
    public List<String> listPostPhotos(@Param("postId") long postId) throws Exception;
    
    
}
	

