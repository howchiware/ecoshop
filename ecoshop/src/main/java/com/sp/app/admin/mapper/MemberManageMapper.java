package com.sp.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.MemberManage;

@Mapper
public interface MemberManageMapper {
	public int dataCount(Map<String, Object> map);
	public List<MemberManage> listMember(Map<String, Object>map);
	
	public MemberManage findById(int memberId);
}
