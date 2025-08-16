package com.sp.app.model;

import java.util.Date;

public class Participant {
	private long participantId;
	private long workshopId;
	private long memberId;
	private int participantStatus;
	private String isAttended;
	private Date appliedDate;

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

	public long getMemberId() {
		return memberId;
	}

	public void setMemberId(long memberId) {
		this.memberId = memberId;
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

	public Date getAppliedDate() {
		return appliedDate;
	}

	public void setAppliedDate(Date appliedDate) {
		this.appliedDate = appliedDate;
	}
}