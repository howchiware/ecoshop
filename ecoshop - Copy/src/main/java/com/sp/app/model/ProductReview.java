package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductReview {
	private long reviewId;
	private Long memberId;
	private String name;
	private int rate;
	private String content;
	private long productCode;
	private String regDate;
	private boolean deletePermit;
	private int showReview;
	private Long answerId;
	// private String login_answer;
	private String answerName;
	private String answer;
	private String answerDate;

	private long reviewPhotoId;
	private String reviewImg;
	private List<MultipartFile> selectFile;

	private String[] listReviewImg;
	
	private String productName;
	private String optionValue;
	private String optionValue2;

	private int	reviewHelpfulCount;
}
