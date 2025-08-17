package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
public class ChallengeManage {
	// 챌린지 
    private Long challengeId;
    private String title;
    private String description;
    private String thumbnail;
    private Integer rewardPoints;       
    private String challengeRegDate;    
    private String challengeType; // 'DAILY' | 'SPECIAL'

    // 데일리 챌린지
    private Integer weekday; 

    // 스페셜 챌린지
    private String startDate;           
    private String endDate;             
    private Integer requireDays; // 기본 3
    private Integer specialStatus; // 0~3
}


