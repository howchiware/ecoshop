package com.sp.app.service;

import java.util.Map;

import com.sp.app.model.Member;


public interface MemberService {
	
	public Member loginMember(Map<String, Object> map);
	public void insertMember(Member dto) throws Exception;
	public void updateMember(Member dto) throws Exception;
	public Member findById(String userId);
	public Member findByMemberId(long memberId);
	public Member findByNickname(String nickname);
	public void deleteMember(Map<String, Object> map) throws Exception;
	public void generatePwd(Member dto) throws Exception;
	
	// 포인트 조회 // public Point findByPoint(long memberId);
	
}
