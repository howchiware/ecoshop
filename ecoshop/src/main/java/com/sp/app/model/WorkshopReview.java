package com.sp.app.model;

import java.util.Date;

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

	public long getWorkshopReviewId() {
		return workshopReviewId;
	}

	public void setWorkshopReviewId(long workshopReviewId) {
		this.workshopReviewId = workshopReviewId;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public long getReviewImgId() {
		return reviewImgId;
	}

	public void setReviewImgId(long reviewImgId) {
		this.reviewImgId = reviewImgId;
	}

	public String getReviewImagePath() {
		return reviewImagePath;
	}

	public void setReviewImagePath(String reviewImagePath) {
		this.reviewImagePath = reviewImagePath;
	}

	public long getParticipantId() {
		return participantId;
	}

	public void setParticipantId(long participantId) {
		this.participantId = participantId;
	}

	public long getWorkshopId() {
		return workshopId;
	}

	public void setWorkshopId(long workshopId) {
		this.workshopId = workshopId;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getWriterName() {
		return writerName;
	}

	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}

	public String getRegDateStr() {
		return regDateStr;
	}

	public void setRegDateStr(String regDateStr) {
		this.regDateStr = regDateStr;
	}

}
