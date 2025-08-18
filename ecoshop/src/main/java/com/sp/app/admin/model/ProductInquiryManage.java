package com.sp.app.admin.model;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductInquiryManage {
	private String productName;
	private String title;
	private String content;
	private Date regDate;
	private int status;
	
	private Long memberId;
	private String userName;
	private String userId;
	private int userLevel;
	
	private Long categoryId;
	private String categoryName;
	
	private Long inquiryId;
	private Long answerId;
	private String answer;
	private Date answerDate;
	private String answerName;
	
}
