package com.sp.app.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Workshop {
	private Long categoryId;
	private String categoryName;
	private Integer isActive;

	private Long programId;
	private String programTitle;
	private String programContent;
	private Date regDate;
	private Date updDate;

	private Long managerId;
	private String name;
	private String tel;
	private String email;
	private String department;

	private Long workshopId;
	private String workshopTitle;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private Date scheduleDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private Date applyDeadline;
	private String location;
	private int workshopStatus;
	private int capacity;
	private String thumbnailPath;
	private String workshopContent;

	private Long photoId;
	private String workshopImagePath;
	
	private Date appliedDate;
    private Integer participantStatus;
    private String isAttended;
}
