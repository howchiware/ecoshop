package com.sp.app.admin.model;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductReviewManage {
    private long reviewId;
    private String userName;
    private String content;
    private Date regDate;
    private long productId;
    private String productCode;
    private long memberId;
    private Boolean showReview; 
    private long answerId; 
    private Date  answerDate;
    private String answer;   
    private String answerName;
    
	private long reviewPhotoId;
	private String reviewImg;
	private String[] listReviewImg;
   
    private String productName; 
    private Integer rate;
    private int status;
}
