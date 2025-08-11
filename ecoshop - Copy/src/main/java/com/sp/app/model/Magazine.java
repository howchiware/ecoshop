package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Magazine {
	private long magazineId;
	private long memberId;
	private String subject;
	private String content;
	private int hitCount;
	private String reg_date;
	private String originalFilename;
	private String saveFilename;
	
	private int magazineLikeCount;
}
