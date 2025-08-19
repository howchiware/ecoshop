package com.sp.app.admin.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GongguReviewManage {
    private long gongguReviewId;
    private String userName;
    private String content;
    private Date regDate;
    private long gongguProductId; 
    private long memberId;
    private Boolean showReview; 
    private long answerId; 
    private Date  answerDate;
    private String answer;
    private String answerName;
   
    private String gongguProductName; 
    private Integer rate;
    private int status;
}