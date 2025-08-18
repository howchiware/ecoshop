package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Inquiry {
	
	private Long memberId;
	private String userId;
	private String password;
	private int userLevel;
	private String name;
	private String nickname;
	
	private Long inquiryId;
	private String subject;
	private String question;
	private String regDate;
	private Long answerId;
	private String questionAnswer;
	private String answerDate;
	private int status;
	
	private Long categoryId;
	private String categoryName;

}
