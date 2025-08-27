package com.sp.app.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Magazine {
	private long memberId;
	private String userId;
	private String password;
	private int userLevel;
	private String name;
	private String nickname;
	
	private long magazineId;
	private String subject;
	private String content;
	private int hitCount;
	private String regDate;
	
	private String originalFilename;
	private String saveFilename;
	private MultipartFile selectFile;
	
	private long magazineReplyNum;
	private String replyContent;
	private String replyRegDate;
	private long parentNum;
	private int showReply;
	private int block;
	private int report;
	private int replyCount;
	private int answerCount;

	private int magazineLikeCount;
	
}
