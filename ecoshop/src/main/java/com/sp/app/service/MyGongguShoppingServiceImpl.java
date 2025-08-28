package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MyGongguShoppingMapper;
import com.sp.app.model.Destination;
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
	
	@Override
	public List<GongguLike> listGongguLike(Map<String, Object> map) {
		List<GongguLike> list = null;
		
		try {
			list = mapper.listGongguLike(map);
		} catch (Exception e) {
			log.info("listGongguLike : ", e);
		}
		
		return list;
	}
	
	@Override
	public void insertDestination(Destination dto) throws Exception {
		try {
			String tel = dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3();
			dto.setTel(tel);
			
			if(dto.getDefaultDest() == 1) {
				Map<String, Object> map = new HashMap<>();
				map.put("memberId", dto.getMemberId());
				map.put("defaultDest", 0);
				mapper.updateDefaultDestination(map);
			}
			
			mapper.insertDestination(dto);
			
			// 최근 10개만 남기고 삭제
			mapper.deleteOldestDestination(dto.getMemberId());			
		} catch (Exception e) {
			log.info("insertDestination : ", e);
			
			throw e;
		}
	}

	@Override
	public int destinationCount(Long member_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Destination> listDestination(Long memberId) {
		List<Destination> list = null;
		
		try {
			list = mapper.listDestination(memberId);
			
			for(Destination dto : list) {
				String [] tel = dto.getTel().split("-");
				if(tel.length == 3) {
					dto.setTel1(tel[0]);
					dto.setTel2(tel[1]);
					dto.setTel3(tel[2]);
				}
			}
			
		} catch (Exception e) {
			log.info("listDestination : ", e);
		}
		
		return list;
	}
	@Override
	public void updateDestination(Destination dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateDefaultDestination(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteDestination(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Destination defaultDelivery(Long memberId) {
		Destination dto = null;
		
		try {
			dto = mapper.defaultDelivery(memberId);
		} catch (Exception e) {
			log.info("defaultDelivery : ", e);
		}
		
		return dto;
	}

	@Override
	public int gongguLikeDataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.gongguLikeDataCount(map);
		} catch (Exception e) {
			log.info("gongguLikeDataCount : ", e);
		}
		
		return result;
	}

}
