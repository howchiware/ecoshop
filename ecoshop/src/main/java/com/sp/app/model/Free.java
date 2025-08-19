package com.sp.app.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Free {
	
	private Long memberId;
	private String userId;
	private String password;
	private int userLevel;
	private String name;
	private String nickname;
	
	private Long freeId;
	private String subject;
	private String content;
	private int hitCount;
	private String regDate;
	private String saveFilename;
	private String originalFilename;
	private MultipartFile selectFile;
	private int block;
	private int report;
	
	private Long replyId;
	private String replyContent;
	private String replyRegDate;
	private Long parentNum;
	private int replyBlock;
	private int replyReport;

}
