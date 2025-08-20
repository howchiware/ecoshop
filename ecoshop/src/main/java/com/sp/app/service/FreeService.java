package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Free;

public interface FreeService {
	
	public List<Free> dairyList(Map<String, Object> map);
	public Free findByDairy(long freeId);
	public int dataCount(Map<String, Object> map);
	public void updateHitCount(long freeId) throws Exception;
	public Free findByPrev(Map<String, Object> map);
	public Free findByNext(Map<String, Object> map);
		
	public void insertDairy(Free dto) throws Exception;
	public void updateDairy(Free dto) throws Exception;
	public void deleteDairy(long freeId, Long memberId, int userLevel) throws Exception;
	
	public void insertReply(Free dto) throws Exception;
	public List<Free> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Free> listReplyAnswer(Map<String, Object> map);
	public int replyAnswerCount(Map<String, Object> map);
	
	// public boolean deleteUploadFile(String uploadPath, String filename);
	
	public void updateReplyShowHide(Map<String, Object> map) throws Exception;
}
