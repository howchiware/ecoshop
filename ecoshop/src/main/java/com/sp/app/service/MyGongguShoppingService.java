package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.GongguLike; 

public interface MyGongguShoppingService {

	public void insertGongguLike(Map<String, Object> map) throws Exception;
	public void deleteGongguLike(Map<String, Object> map) throws Exception;
	public List<GongguLike> listGongguLike(Long memberId) throws Exception;
	public GongguLike findByGongguLikeId(Map<String, Object> map) throws Exception;

}
