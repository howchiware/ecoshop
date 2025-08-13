package com.sp.app.admin.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AttendanceManage {
	
	private Long memberId;
	private String userId;
	private int userLevel;
	private String regDate;
	private String regUpdate;
	
	private String name;
	private String nickname;

	private int dayIndex;
	
	private int attendanceCount;
	private Date lastAttendanceDate;

}
