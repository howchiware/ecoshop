package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Free;

@Mapper
public interface FreeMapper {
	
	public void insertDairy(Free dto) throws Exception;
	public void updateDairy(Free dto) throws Exception;
	public void deleteDairy(long freeId) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Free> dairyList(Map<String, Object> map);
	public Free findByDairy(long freeId);
	public void updateHitCount(long freeId) throws Exception;
	public Free findByPrev(Map<String, Object> map);
	public Free findByNext(Map<String, Object> map);
	
	public void insertReply(Free dto) throws SQLException;
	public int replyCount(Map<String, Object> map);
	public List<Free> listReply(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;

	public List<Free> listReplyAnswer(Map<String, Object> map);
	public int replyAnswerCount(Map<String, Object> map);
	
}
