package com.sp.app.model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WorkshopFaq {
	private Long faqId;
	private Long programId;
	private String question;
	private String answer;
	private Date regDate;

}
