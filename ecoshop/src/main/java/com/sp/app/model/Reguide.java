package com.sp.app.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Reguide {
	private long guidId;
	private long memberId;
	private int categoryCode;
	private String name;
	private String subject;
	private String content;
	private int hitCount;
	private String regDate;	

	private MultipartFile selectFile;
	private String imageFilename;
	
	private long gap;
}
