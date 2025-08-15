package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class FaqManage {
	
	private Long memberId;
	private String userId;
	private int userLevel;
	private String regDate;
	private String regUpdate;
	
	private String name;
	private String nickname;

	private Long faqId;
	private String subject;
	private String content;
	private Long updateId;
	
	private Long categoryId;
	private String categoryName;
	
	private String updateName;

}
