package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
public class GongguReview {
    private long gongguReviewId;
    private String Username;
    private int rate;
    private String content;
    private String regDate;
    private long gongguProductId; 
    private long memberId;
    private Boolean showReview; 
    private boolean deletePermit;
    private long answerId; 
    private String answerDate;
    private String answer;  
    private String AnswerName;
    
    private long reviewPhotoId;
    private String reviewImg;
	private List<MultipartFile> selectFile;
	
	private String[] listReviewImg;
	private String gongguProductName;
	
	private int	reviewHelpfulCount;
}