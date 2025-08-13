package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MemberManage {
	private Long memberId;
	private String userId;
	private String password;
	private int userLevel;
	private String regDate;
	private String regUpdate;
	
	private String name;
	private String nickname;
	private String birth;
	private String tel;
	private String zip;
	private String addr1;
	private String addr2;
	private String email;
}
