package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.TipBoard;

@Mapper
public interface TipBoardMapper {
	public long tipBoardSeq();
	public void insertTipBoard(TipBoard dto) throws SQLException;
	public void updateOrderNo(Map<String, Object> map) throws SQLException;
	public void updateTipBoard(TipBoard dto) throws SQLException;
	public void deleteTipBoard(long tipId) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<TipBoard> listTipBoard(Map<String, Object> map);
	
	public TipBoard findById(long tipId);
	public void updateHitCount(long tipId) throws SQLException;
	public TipBoard findByPrev(Map<String, Object> map);
	public TipBoard findByNext(Map<String, Object> map);
	
	public void insertTipBoardLike(Map<String, Object> map) throws SQLException;
	public void deleteTipBoardLike(Map<String, Object> map) throws SQLException;
	public int tipLikeCount(long tipId);
	public TipBoard hasUserTipBoardLiked(Map<String, Object> map);
	
}
