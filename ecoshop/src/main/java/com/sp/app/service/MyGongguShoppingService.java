package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Destination;
import com.sp.app.model.GongguLike; 

public interface MyGongguShoppingService {

	public void insertGongguLike(Map<String, Object> map) throws Exception;
	public void deleteGongguLike(Map<String, Object> map) throws Exception;
	public List<GongguLike> listGongguLike(Map<String, Object> map);
	public GongguLike findByGongguLikeId(Map<String, Object> map) throws Exception;
	public int gongguLikeDataCount(Map<String, Object> map);
	
	public void insertDestination(Destination dto) throws Exception;
	public int destinationCount(Long member_id);
	public List<Destination> listDestination(Long member_id);
	public void updateDestination(Destination dto) throws Exception;
	public void updateDefaultDestination(Map<String, Object> map) throws Exception;
	public void deleteDestination(Map<String, Object> map) throws Exception;
	public Destination defaultDelivery(Long member_id);

}
