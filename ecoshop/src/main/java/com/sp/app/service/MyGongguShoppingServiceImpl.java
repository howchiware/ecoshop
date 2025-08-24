package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MyGongguShoppingMapper; 
import com.sp.app.model.GongguLike;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyGongguShoppingServiceImpl implements MyGongguShoppingService {

	private final MyGongguShoppingMapper mapper;

	@Override
	public void insertGongguLike(Map<String, Object> map) throws Exception {
		try {
			mapper.insertGongguLike(map);

			Long memberId = (Long)map.get("memberId");
			
			mapper.deleteOldestGongguLikes(memberId);
		} catch (Exception e) {
			log.error("insertGongguLike : ", e);
			throw e;
		}
	}

	@Override
	public void deleteGongguLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteGongguLike(map);
		} catch (Exception e) {
			log.error("deleteGongguLike : ", e);
			throw e;
		}
	}

	@Override
	public List<GongguLike> listGongguLike(Long memberId) throws Exception {
		List<GongguLike> list = null;
		try {
			list = mapper.listGongguLike(memberId);
		} catch (Exception e) {
			log.error("listGongguLike : ", e);
			throw e;
		}
		return list;
	}

	@Override
	public GongguLike findByGongguLikeId(Map<String, Object> map) throws Exception {
		GongguLike dto = null;
		try {
			dto = mapper.findByGongguLikeId(map);
		} catch (Exception e) {
			log.error("findByGongguLikeId : ", e);
			throw e;
		}
		return dto;
	}
}
