package com.sp.app.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.mapper.TipBoardMapper;
import com.sp.app.model.TipBoard;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TipBoardServiceImpl implements TipBoardService{
	private final TipBoardMapper mapper;
	private final MyUtil myUtil;
	
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
				
				dto.setContent(myUtil.htmlSymbols(dto.getContent()));
				dto.setName(myUtil.nameMasking(dto.getName()));				

				dto.setRegDate(dto.getRegDate().substring(0, 10));
			}
			
		} catch (Exception e) {
			log.info("listBoard : ", e);
		}
		return list;
	}

}
	
