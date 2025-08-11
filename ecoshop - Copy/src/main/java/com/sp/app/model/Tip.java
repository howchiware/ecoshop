package com.sp.app.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Tip {
	private Long tipId;
	private Long memberId;
	private String subject;
	private String content;
	private long groupNum;
	private int depth;
	private int orderNo;
	private long parent;
	private long gap;
	
	private int hitCount;
	private String regDate;
	private int block;
	private int report;
	
	private String saveFilename;
	private String originalFilename;
	private MultipartFile selectFile;
	
	private int tipLikeCount;
}
