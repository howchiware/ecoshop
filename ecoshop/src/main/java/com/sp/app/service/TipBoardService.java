package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.TipBoard;

public interface TipBoardService {
	public void insertTipBoard(TipBoard dto, String mode) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<TipBoard> listTipBoard(Map<String, Object> map);

}
