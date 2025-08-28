package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.MemberManage;

public interface MemberManageService {
	public int dataCount(Map<String, Object> map);
	public List<MemberManage> listMember(Map<String, Object> map);
	
	public MemberManage findById(Long memberId);
	
	public void insertMember(MemberManage dto) throws Exception;
	
	public MemberManage findById1(String userId);
	public MemberManage findByNickname(String nickname);
	
	public void updateMember(Map<String, Object> map) throws Exception;
	public void updateMemberEnabled(long memberId) throws Exception;
	public void deleteMember(long memberId) throws Exception;
	
	public List<MemberManage> listMemberStatus(Long memberId);
	public MemberManage findByStatus(Long memberId);
	
	
}
