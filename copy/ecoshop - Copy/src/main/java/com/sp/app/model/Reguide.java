package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Reguide {
	private long guidId;
	private String name;
	private int notice;
	private String subject;
	private String content;
	private int hitCount;
	private String reg_date;
	private int showNotice;
	private String update_date;

	private long fileNum;
	private String originalFilename;
	private String saveFilename;
	private long fileSize;
	private int fileCount;
	
	private long gap;
}
