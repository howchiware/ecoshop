package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AdvertisementManage {
	private long advertisingId;
	private String username ;
	private String subject;
	private String content;
	private String regDate;
	private int inquiryType;
	private int status;
	private int postingStatus;
	private String email;
	private String tel;
	private String adverStart;
	private String adverEnd;
	
	private long statuslogId;
	private long memberId;
	private String changeDate;
	private int oldStatus;
	private int newStatus;
	private int oldPosting;
	private int newPosting;
	
	private long advertisingFileNum;
	private String saveFilename;
	private String originalFilename;
	private long fileSize;
	private String zip;
	
	private long promotionId;
	private String imageFilename;
	
	
	

}
