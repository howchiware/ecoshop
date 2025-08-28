package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GongguProductInquiry {
	private long gongguInquiryId;
	private long gongguProductId;
	private Long memberId;
	private String name;
	private int secret;
	private String title;
	private String content;
	private String regDate;
	private int showQuestion;
	private Long answerId;
	private String answerName;
	private String answerDate;
	private String answer;
	
	private String productName;
	
	private int deletePermit;
}
