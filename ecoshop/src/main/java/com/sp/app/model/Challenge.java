package com.sp.app.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Challenge {
	// 챌린지 
	private Long challengeId;    
    private String title;        
    private String description;  
    private String thumbnail;    
    private Integer rewardPoints; 
    private String challengeRegDate; // 챌린지 등록일  
    private String challengeType; // 'DAILY' | 'SPECIAL'
    
    // 데일리챌린지(요일별)
    private Integer weekday;
    
    // 스페셜챌린지(특별)
    private String startDate;
    private String endDate;
    private Integer requireDays;
    private Integer specialStatus; // 스페셜 챌린지 진행상태
    
    // 챌린지 참여기록 
    private Long participationId;
    private Long memberId;
    private String participateDate; 
    private Integer participationStatus; // 챌린지 참여상태 , 0~5
    private String cancelAt;
    
    // 인증 게시글
    private Long postId;
    private Integer dayNumber; // 특별챌린지 날짜 인증: 1~3
    private String content;
    private String postRegDate; // 게시글 작성일자 
    private Integer approvalStatus; // 승인상태 
    private String isPublic;
    
    // 인증 사진
    private Long photoId;
    private String photoUrl;
    private String photoRegDate; // 인증사진 등록일자 
    
    // 파일 업로드
    private MultipartFile thumbnailFile;
    private MultipartFile photoFile; // 챌린지 인증 시 사용
    
    // 관리자 챌린지 수정시 썸네일 삭제 
    private Boolean removeThumbnail;
    
    private String memberName;   // 사용자 이름
    
    private Integer certCount;    // 인증글 수
    private Integer approvedDays; // 승인된 일차 수
    
    //챌린지 톡
    private Integer likeCount;
    private Integer commentCount;
    private Integer hitCount;
    
}
