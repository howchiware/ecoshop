package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Magazine;

public interface MagazineService {
	public List<Magazine> magazineList(Map<String, Object> map);
	public Magazine findByMagazine(long magazineId);
	public int dataCount(Map<String, Object> map);
	public void updateHitCount(long magazineId) throws Exception;
	public Magazine findByPrev(Map<String, Object> map);
	public Magazine findByNext(Map<String, Object> map);
		
	public void insertMagazine(Magazine dto) throws Exception;
	public void updateMagazine(Magazine dto) throws Exception;
	public void deleteMagazine(long magazineId, Long memberId, int userLevel) throws Exception;
	
	public void insertReply(Magazine dto) throws Exception;
	public List<Magazine> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Magazine> listReplyAnswer(Map<String, Object> map);
	public int replyAnswerCount(Map<String, Object> map);
	
	public void updateReplyReport(Map<String, Object> map) throws Exception;
	
	public void insertMagazinDeLike(Map<String, Object> map) throws Exception;
	public void deleteMagazineLike(Map<String, Object> map) throws Exception;
	public int magazineLikeCount(long num);
	public boolean isUserMagazineLiked(Map<String, Object> map);
}
