package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QuizManage {
	
	private Long memberId;
	private String userId;
	private int userLevel;
	
	private String name;
	private String nickname;
	
	// 퀴즈
	private Long quizId;
	private String subject;
	private String content;
	private int answer;
	private String commentary;
	private String regDate;
	private String openDate;
	
	private Long insertId;
	
}
