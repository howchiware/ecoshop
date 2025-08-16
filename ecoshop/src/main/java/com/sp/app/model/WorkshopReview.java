package com.sp.app.model;

public class WorkshopReview {

	private long workshopReviewId;
	private String reviewContent;
	private long reviewImgId;
	private String reviewImagePath;
	private long participantId;
	private long workshopId;

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
}
