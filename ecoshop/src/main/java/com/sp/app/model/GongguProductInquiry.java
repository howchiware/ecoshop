package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GongguProductInquiry {
    private long gongguInquiryId;
    private long gongguProductId;
    private long memberId; 
    private String name;
    private String title;
    private String content;
    private String regDate;
    private Boolean secret; 
    private Boolean showQuestion; 
    private long answerId; 
    private String answerName;
    private String answerDate;
    private String answer;
    
    private String gongguProductName;    
}