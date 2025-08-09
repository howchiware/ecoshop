package com.sp.app.admin.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class NoticeManage {
	private long noticeId;
	private Long memberId;
	private String loginId;
	private String name;
	private int notice;
	private String subject;
	private String content;
	private int hitCount;
	private String regDate;
	private int showNotice;
	private Long updateId;
	private String loginUpdate;
	private String updateName;
	private String updateDate;


	private long noticefileId;
	private String saveFilename;
	private String originalFilename;
	private long fileSize;
	private int fileCount;
	
	private List<MultipartFile> selectFile;
	private long gap;
}

