package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Quiz {
	
	// 퀴즈
	private int quizId;
	
	// 퀴즈 제출
	private int quizAnswerId;
	private int quizAnswer;
	private String answerDate;
	private Long memberId;
	
	

}
