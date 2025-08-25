package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Magazine;

@Mapper
public interface MagazineMapper {
	public void insertMagazine(Magazine dto) throws Exception;
	public void updateMagazine(Magazine dto) throws Exception;
	public void deleteMagazine(long magazineId) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Magazine> magazineList(Map<String, Object> map);
	public Magazine findByMagazine(long magazineId);
	public void updateHitCount(long magazineId) throws Exception;
	public Magazine findByPrev(Map<String, Object> map);
	public Magazine findByNext(Map<String, Object> map);
	
	public void insertReply(Magazine dto) throws SQLException;
	public int replyCount(Map<String, Object> map);
	public List<Magazine> listReply(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;

	public List<Magazine> listReplyAnswer(Map<String, Object> map);
	public int replyAnswerCount(Map<String, Object> map);
	public void updateReplyReport(Map<String, Object> map) throws SQLException;
	
	public void insertMagazineLike(Map<String, Object> map) throws SQLException;
	public void deleteMagazineLike(Map<String, Object> map) throws SQLException;
	public int magazineLikeCount(long magazineId);
	public Magazine hasUserMagazineLiked(Map<String, Object> map);
}
