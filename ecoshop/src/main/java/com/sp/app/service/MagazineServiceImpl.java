package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.mapper.MagazineMapper;
import com.sp.app.model.Free;
import com.sp.app.model.Magazine;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MagazineServiceImpl implements MagazineService {
	private final MyUtil myUtil;
	private final MagazineMapper mapper;
	
	@Override
	public List<Magazine> magazineList(Map<String, Object> map) {
		List<Magazine> list = null;
		
		try {
			list = mapper.magazineList(map);			
		} catch (Exception e) {
			log.info("dairyList : ", e);
		}
		
		return list;
	}

	@Override
	public Magazine findByMagazine(long magazineId) {
		Magazine dto = null;
		
		try {
			dto = mapper.findByMagazine(magazineId);
		} catch (Exception e) {
			log.info("findByMagazine: ", e);
		}
		
		return dto;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount: ", e);
		}
		
		return result;
	}

	@Override
	public void updateHitCount(long magazineId) throws Exception {
		try {
			mapper.updateHitCount(magazineId);
		} catch (Exception e) {
			log.info("updateHitCount: ", e);
			throw e;
		}
		
	}

	@Override
	public Magazine findByPrev(Map<String, Object> map) {
		Magazine dto = null;
		
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev: ", e);
		}
		
		return dto;
	}

	@Override
	public Magazine findByNext(Map<String, Object> map) {
		Magazine dto = null;
		
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext: ", e);
		}
		
		return dto;
	}

	@Override
	public void insertMagazine(Magazine dto) throws Exception {
		try {
			mapper.insertMagazine(dto);
		} catch (Exception e) {
			log.info("insertMagazine: ", e);
			throw e;
		}
		
	}

	@Override
	public void updateMagazine(Magazine dto) throws Exception {
		try {
			mapper.updateMagazine(dto);
		} catch (Exception e) {
			log.info("updateDairy: ", e);
			throw e;
		}
		
	}

	@Override
	public void deleteMagazine(long magazineId, Long memberId, int userLevel) throws Exception {
		try {
			Magazine dto = findByMagazine(magazineId);

	        if (dto == null) {
	            return;
	        }

	        if (userLevel < 51 && !memberId.equals(dto.getMemberId())) {
	            return; 
	        }
	        
	        mapper.deleteMagazine(magazineId);

	    } catch (Exception e) {
	        log.error("deleteMagazine: ", e);
	        throw e;
	    }
		
	}

	@Override
	public void insertReply(Magazine dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Magazine> listReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Magazine> listReplyAnswer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int replyAnswerCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void updateReplyReport(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertMagazinDeLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMagazineLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int magazineLikeCount(long num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean isUserMagazineLiked(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return false;
	}

}
