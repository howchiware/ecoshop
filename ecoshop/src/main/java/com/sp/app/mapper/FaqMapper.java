package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.FaqManage;

@Mapper
public interface FaqMapper {
	
	public List<FaqManage> listFaq(Map<String, Object> map);
	public FaqManage findByFaq(long faqId);
	public List<FaqManage> listCategory(Map<String, Object> map);
	
}
