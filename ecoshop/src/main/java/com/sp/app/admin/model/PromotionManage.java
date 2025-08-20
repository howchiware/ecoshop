package com.sp.app.admin.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PromotionManage {
	private long promotionId;
	private long memberId;
	private Integer advertisingId;
	private String subject;
	private String imageFilename;
	private String regDate;
	private int postingStatus;
	private int block;
	
	private MultipartFile selectFile;
}
