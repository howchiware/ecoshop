package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Quiz {
	
	// 퀴즈
	private Long quizId;
	private String subject;
	private String content;
	private int answer;
	private String commentary;
	private String regDate;
	private String openDate;
	
	// 퀴즈 제출
	private Long quizAnswerId;
	private int quizAnswer;
	private String answerDate;
	private Long memberId;
	
	private int dayIndex;

}
