package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Notice {
	private long noticeId;
	private int notice;
	private int memberId;
	private String subject;
	private String content;
	private int hitCount;
	private String reg_date;
	private String update_date;
	private int showNotice;

	private long noticefileId;
	private String saveFilename;
	private String originalFilename;
	private long fileSize;
}
