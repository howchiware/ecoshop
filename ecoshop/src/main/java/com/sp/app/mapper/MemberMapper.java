package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Member;

@Mapper
public interface MemberMapper {
	
	public Member loginMember(Map<String, Object> map);
	
	public long selectMemberId();
	public void insertMember1(Member dto) throws SQLException;
	public void insertMember2(Member dto) throws SQLException;
	
	public void updateMemberEnabled(Map<String, Object> map) throws SQLException;
	public void updateMemberLevel(Map<String, Object> map) throws SQLException;
	
	public void updateMember1(Member dto) throws SQLException;
	public void updateMember2(Member dto) throws SQLException;
	
	public Member findById(String userId);
	public Member findByMemberId(long memberId);
	public Member findByNickname(String nickname);
	public void updateMemberEnabled(long memberId) throws SQLException;
	public void deleteMember2(long memberId) throws Exception;
	
}
