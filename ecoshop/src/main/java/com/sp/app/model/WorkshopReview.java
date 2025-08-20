package com.sp.app.model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WorkshopReview {

	private String writerName;
	private Long workshopReviewId;
	private String reviewContent;
	private Long reviewImgId;
	private String reviewImagePath;
	private Long participantId;
	private Long workshopId;
	private Date regDate;
	private String regDateStr;
}
