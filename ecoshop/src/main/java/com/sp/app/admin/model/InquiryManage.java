package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class InquiryManage {
	
	private Long memberId;
	private String userId;
	private int userLevel;
	private String regDate;
	
	private String name;
	private String nickname;
	
	private Long categoryId;
	private String categoryName;
	
	private Long inquiryId;
	private String subject;
	private String question;
	private Long answerId;
	private String questionAnswer;
	private String answerDate;
	private int status;
	
	private String answerName;
	
	private int waitInquiry;
    private int allInquiry;
    private int compInquiry;
}
