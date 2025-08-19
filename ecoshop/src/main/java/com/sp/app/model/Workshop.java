package com.sp.app.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Workshop {
	private Long categoryId;
	private String categoryName;

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

	public Long getCategoryId() {
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

	public Date getScheduleDate() {
		return scheduleDate;
	}

	public void setScheduleDate(Date scheduleDate) {
		this.scheduleDate = scheduleDate;
	}

	public Date getApplyDeadline() {
		return applyDeadline;
	}

	public void setApplyDeadline(Date applyDeadline) {
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

}
