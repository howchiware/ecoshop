package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MagazineReply {
	private long magazineReplyNum;
	private long magazineId;
	private Long memberId;
	private String name;
	private String content;
	private String reg_date;
	private long parentNum;
	private int showReply;
	private int block;
	private int answerCount;
}
