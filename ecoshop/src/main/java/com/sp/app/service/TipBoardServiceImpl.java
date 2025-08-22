package com.sp.app.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.TipBoardMapper;
import com.sp.app.model.TipBoard;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TipBoardServiceImpl implements TipBoardService{
	private final TipBoardMapper mapper;

	
	@Override
	public void insertTipBoard(TipBoard dto, String mode) throws Exception {
		try {
			long seq = mapper.tipBoardSeq();
			
			if(mode.equals("write")) {
				dto.setTipId(seq);
				dto.setGroupNum(seq);
				dto.setDepth(0);
				dto.setOrderNo(0);
				dto.setParent(0);
			}else {
				Map<String, Object> map = new HashMap<>();
				map.put("groupNum", dto.getGroupNum());
				map.put("orderNo", dto.getOrderNo());
				mapper.updateOrderNo(map);
				
				dto.setTipId(seq);
				dto.setDepth(dto.getDepth() + 1);
				dto.setOrderNo(dto.getOrderNo() + 1);
			}
			
			mapper.insertTipBoard(dto);
			
		} catch (Exception e) {
			log.info("insertTipBoard", e);
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<TipBoard> listTipBoard(Map<String, Object> map) {
		List<TipBoard> list = null;
		
		try {
			list = mapper.listTipBoard(map);
			
			long gap;
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime today = LocalDateTime.now();
			for (TipBoard dto : list) {
				LocalDateTime dateTime = LocalDateTime.parse(dto.getRegDate(), formatter);
				gap = dateTime.until(today, ChronoUnit.HOURS);
				dto.setGap(gap);
				
				//dto.setContent(myUtil.htmlSymbols(dto.getContent()));
				//dto.setName(myUtil.nameMasking(dto.getName()));				

				dto.setRegDate(dto.getRegDate().substring(0, 10));
			}
			
		} catch (Exception e) {
			log.info("listBoard : ", e);
		}
		return list;
	}

	@Override
	public void updateHitCount(long tipId) throws Exception {
		try {
			mapper.updateHitCount(tipId);
		} catch (Exception e) {
			log.info("updateHitCount : ", e);
			
			throw e;
		}
		
	}

	@Override
	public TipBoard findById(long tipId) {
		TipBoard dto = null;
		try {
			dto = mapper.findById(tipId);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		return dto;
	}

	@Override
	public TipBoard findByPrev(Map<String, Object> map) {
		TipBoard dto = null;
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
		}
		return dto;
	}

	@Override
	public TipBoard findByNext(Map<String, Object> map) {
		TipBoard dto = null;
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext : ", e);
		}
		return dto;
	}

	@Override
	public void updateTipBoard(TipBoard dto) throws Exception {
		try {
			mapper.updateTipBoard(dto);;
		} catch (Exception e) {
			log.info("updateTipBoard : ", e);
			
			throw e;
		}
		
	}

	@Override
	public void deleteTipBoard(long tipId, Long memberId, int userLevel) throws Exception {
		try {
			TipBoard dto = findById(tipId);
			if (dto == null || (userLevel < 51 && dto.getMemberId() != memberId)) {
				return;
			}

			mapper.deleteTipBoard(tipId);
		} catch (Exception e) {
			log.info("deleteBoard : ", e);
			
			throw e;
		}
	}
	
	@Override
	public void insertTipBoardLike(Map<String, Object> map) throws Exception {
		try {
			mapper.insertTipBoardLike(map);
		} catch (Exception e) {
			log.info("insertTipBoardLike : ", e);
			throw e;
		}
		
	}

	@Override
	public void deleteTipBoardLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteTipBoardLike(map);
		} catch (Exception e) {
			log.info("deleteTipBoardLike : ", e);
			throw e;
		}
		
	}

	@Override
	public int tipLikeCount(long tipId) {
		int result = 0;
		
		try {
			result = mapper.tipLikeCount(tipId);
		} catch (Exception e) {
			log.info("tipLikeCount : ", e);
		}
		
		return result;
	}

	@Override
	public boolean isUserTipBoardLiked(Map<String, Object> map) {
		boolean result = false;
		try {
			TipBoard dto = mapper.hasUserTipBoardLiked(map);
			if(dto != null) {
				result = true; 
			}

		} catch (Exception e) {
			log.info("isUserTipBoardLiked : ", e);
		}
		
		return result;
	}

}
	
