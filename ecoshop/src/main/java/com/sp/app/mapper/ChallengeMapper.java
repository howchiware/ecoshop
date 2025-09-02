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
	
	public Challenge getTodayDaily(@Param("todayDow") int todayDow) throws SQLException;
    
    public List<Challenge> listSpecialMore(Map<String, Object> param );


    // 상세 
    public Challenge findDailyDetail(@Param("challengeId") long challengeId) throws SQLException;
    public Challenge findSpecialDetail(@Param("challengeId") long challengeId) throws SQLException;

    
    public Long nextParticipationId() throws SQLException;
    public Long nextPostId() throws SQLException; 
    public Long nextPhotoId() throws SQLException; 
    
    public int countTodayDailyJoin(
            @Param("memberId") long memberId,
            @Param("challengeId") long challengeId
    ) throws SQLException;

    public int insertParticipation(Challenge dto) throws SQLException;
    public int insertCertificationPost(Challenge dto) throws SQLException;
    public int insertCertificationPhoto(Challenge dto) throws SQLException;
    
    public int updateParticipation(Challenge dto) throws SQLException;
    
    public List<Map<String, Object>> selectSpecialProgress(
            @Param("participationId") long participationId
    ) throws SQLException;
   
	public Challenge selectDailyByWeekday(@Param("weekday") int weekday);
	
    public Challenge selectActiveParticipation(@Param("memberId") long memberId,
                                        @Param("challengeId") long challengeId) throws SQLException;

    public int existsPostByParticipationAndDay(@Param("participationId") long participationId,
                                        @Param("dayNumber") int dayNumber) throws SQLException;

    public Integer selectMaxDayNumber(@Param("participationId") long participationId) throws SQLException;
    
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
    
    
    // 내 인증글 관리용 (스페셜 인증글만)
    public int countMySpecialPosts(
            @Param("memberId") long memberId,
            @Param("challengeId") Long challengeId,   
            @Param("kwd") String kwd                   
    ) throws Exception;

    public List<Challenge> listMySpecialPostsPaged(
            @Param("memberId") long memberId,
            @Param("challengeId") Long challengeId,   
            @Param("offset") int offset,
            @Param("size") int size,
            @Param("kwd") String kwd                   
    ) throws Exception;
    
    public Challenge findPublicSpecialPost(@Param("postId") long postId) throws Exception;
    public List<String> listPostPhotos(@Param("postId") long postId) throws Exception;
    
    public List<Challenge> listSpecialBundlesPaged(@Param("offset") int offset,
            @Param("size") int size,
            @Param("sort") String sort) throws Exception;

    public List<Challenge> listPublicThreadByParticipation(@Param("participationId") long participationId) throws Exception;

    // 오늘날짜 인증글 있는지 확인용
    public int countTodaySpecialCertByParticipation(@Param("participationId") long participationId) throws SQLException; 
    // 인증날짜 조회용
    public String findPrevDayDate(@Param("participationId") long participationId,
            @Param("prevDay") int prevDay) throws SQLException;
    
    public int countTodaySpecialPost(long participationId);
    public Map<String, Object> selectLastPostInfo(long participationId); 
    
    public Long findPrevPostId(@Param("participationId") long participationId,
            @Param("dayNumber") int dayNumber);
    public	Long findNextPostId(@Param("participationId") long participationId,
            @Param("dayNumber") int dayNumber);

    public Challenge findChallengeSummary(@Param("challengeId") long challengeId);
}
	

