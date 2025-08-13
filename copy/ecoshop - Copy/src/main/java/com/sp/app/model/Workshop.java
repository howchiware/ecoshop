package com.sp.app.model;

import java.util.Date;

public class Workshop {
	private long categoryId;
	private String categoryName;

	private long programId;
	private String programTitle;
	private String programContent;
	private Date regDate;
	private Date updDate;

	private long managerId;
	private String name;
	private String tel;
	private String email;
	private String department;

	private long workshopId;
	private String workshopTitle;
	private String scheduleDate;
	private String applyDeadline;
	private String location;
	private int workshopStatus;
	private int capacity;
	private String thumbnailPath;
	private String workshopContent;

	private long faqId;
	private String question;
	private String answer;

	private long photoId;
	private String workshopImagePath;

	private long participantId;
	private int participantStatus;
	private String isAttended;
	private String appliedDate;

	private long workshopReviewId;
	private String reviewContent;

	private long reviewImgId;
	private String reviewImagePath;

	public long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public long getProgramId() {
		return programId;
	}

	public void setProgramId(long programId) {
		this.programId = programId;
	}

	public String getProgramTitle() {
		return programTitle;
	}

	public void setProgramTitle(String programTitle) {
		this.programTitle = programTitle;
	}

	public String getProgramContent() {
		return programContent;
	}

	public void setProgramContent(String programContent) {
		this.programContent = programContent;
	}

	public java.util.Date getRegDate() {
		return regDate;
	}

	public void setRegDate(java.util.Date regDate) {
		this.regDate = regDate;
	}

	public java.util.Date getUpdDate() {
		return updDate;
	}

	public void setUpdDate(java.util.Date updDate) {
		this.updDate = updDate;
	}

	public long getManagerId() {
		return managerId;
	}

	public void setManagerId(long managerId) {
		this.managerId = managerId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public long getWorkshopId() {
		return workshopId;
	}

	public void setWorkshopId(long workshopId) {
		this.workshopId = workshopId;
	}

	public String getWorkshopTitle() {
		return workshopTitle;
	}

	public void setWorkshopTitle(String workshopTitle) {
		this.workshopTitle = workshopTitle;
	}

	public String getScheduleDate() {
		return scheduleDate;
	}

	public void setScheduleDate(String scheduleDate) {
		this.scheduleDate = scheduleDate;
	}

	public String getApplyDeadline() {
		return applyDeadline;
	}

	public void setApplyDeadline(String applyDeadline) {
		this.applyDeadline = applyDeadline;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getWorkshopStatus() {
		return workshopStatus;
	}

	public void setWorkshopStatus(int workshopStatus) {
		this.workshopStatus = workshopStatus;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getThumbnailPath() {
		return thumbnailPath;
	}

	public void setThumbnailPath(String thumbnailPath) {
		this.thumbnailPath = thumbnailPath;
	}

	public String getWorkshopContent() {
		return workshopContent;
	}

	public void setWorkshopContent(String workshopContent) {
		this.workshopContent = workshopContent;
	}

	public long getFaqId() {
		return faqId;
	}

	public void setFaqId(long faqId) {
		this.faqId = faqId;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public long getPhotoId() {
		return photoId;
	}

	public void setPhotoId(long photoId) {
		this.photoId = photoId;
	}

	public String getWorkshopImagePath() {
		return workshopImagePath;
	}

	public void setWorkshopImagePath(String workshopImagePath) {
		this.workshopImagePath = workshopImagePath;
	}

	public long getParticipantId() {
		return participantId;
	}

	public void setParticipantId(long participantId) {
		this.participantId = participantId;
	}

	public int getParticipantStatus() {
		return participantStatus;
	}

	public void setParticipantStatus(int participantStatus) {
		this.participantStatus = participantStatus;
	}

	public String getIsAttended() {
		return isAttended;
	}

	public void setIsAttended(String isAttended) {
		this.isAttended = isAttended;
	}

	public String getAppliedDate() {
		return appliedDate;
	}

	public void setAppliedDate(String appliedDate) {
		this.appliedDate = appliedDate;
	}

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

}
