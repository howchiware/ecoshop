package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.TipBoard;

public interface TipBoardService {
	public void insertTipBoard(TipBoard dto, String mode) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<TipBoard> listTipBoard(Map<String, Object> map);
	
	public void updateHitCount(long tipId) throws Exception;
	public TipBoard findById(long tipId);
	public TipBoard findByPrev(Map<String, Object> map);
	public TipBoard findByNext(Map<String, Object> map);
	
	public void updateTipBoard(TipBoard dto) throws Exception;
	public void deleteTipBoard(long tipId, Long memberId, int userLevel) throws Exception;

}
